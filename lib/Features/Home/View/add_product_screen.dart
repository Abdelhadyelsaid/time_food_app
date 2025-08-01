import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:time_food/Core/Const/colors.dart';
import 'package:time_food/Core/Shared%20Widgets/snackBar_widget.dart';
import 'package:time_food/Features/Home/Cubit/home_cubit.dart';

import '../../../routing/routes.dart';
import '../../Notifications/Helper/notification_helper.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  DateTime? productionDate;
  DateTime? expiryDate;
  bool notifyBefore = false;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (image != null) {
      setState(() => _selectedImage = File(image.path));
    }
  }

  void _showImageSourcePicker() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('اختيار من المعرض'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('التقاط بالكاميرا'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
    );
  }

  Future<void> _pickDate({required bool isProduction}) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (date != null) {
      setState(() {
        if (isProduction) {
          productionDate = date;
        } else {
          expiryDate = date;
        }
      });
    }
  }

  int get remainingDays {
    if (expiryDate == null) return 0;
    return expiryDate!
        .difference(DateTime.now())
        .inDays
        .clamp(0, double.infinity)
        .toInt();
  }

  void _saveProduct() {
    print("Image: ${_selectedImage?.path}");
    print("Quantity: ${quantityController.text}");
    print("Production Date: $productionDate");
    print("Expiry Date: $expiryDate");
    print("Notify Before: $notifyBefore");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("إضافة منتج"),
        centerTitle: true,
        backgroundColor: cPrimaryColor,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AddProductErrorState) {
            context.showErrorSnackBar("${state.message}حدث خظأ اثناء الاضافة:");
          }
          if (state is AddProductSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              NotificationHelper.scheduleNotificationAfter24Hours(
                context,
                nameController.text,
                expiryDate ?? DateTime.now().add(const Duration(hours: 24)),
              );
            });
            context.showErrorSnackBar("تم الاضافة بنجاح", color: Colors.green);
            context.pushReplacementNamed(Routes.layoutScreen.name);
          }
        },
        builder: (context, state) {
          return state is AddProductLoadingState
              ? Center(child: CircularProgressIndicator(color: cPrimaryColor))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: _showImageSourcePicker,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child:
                                _selectedImage != null
                                    ? Image.file(
                                      _selectedImage!,
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                    : Container(
                                      height: 200,
                                      width: double.infinity,
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.image, size: 60),
                                    ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text("الاسم"),
                        TextField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.right,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text("الكمية"),
                        TextField(
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDateField(
                          "تاريخ الإنتاج",
                          productionDate,
                          () => _pickDate(isProduction: true),
                        ),
                        _buildDateField(
                          "تاريخ الانتهاء",
                          expiryDate,
                          () => _pickDate(isProduction: false),
                        ),
                        const SizedBox(height: 8),
                        CheckboxListTile(
                          title: const Text("إرسال تنبيه قبل انتهاء الوقت؟"),
                          value: notifyBefore,
                          onChanged:
                              (val) =>
                                  setState(() => notifyBefore = val ?? false),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "الأيام المتبقية: $remainingDays يوم",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cPrimaryColor,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              final name = nameController.text.trim();
                              final quantityText =
                                  quantityController.text.trim();

                              if (name.isEmpty ||
                                  quantityText.isEmpty ||
                                  productionDate == null ||
                                  expiryDate == null ||
                                  _selectedImage == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'يرجى ملء جميع الحقول المطلوبة',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              _saveProduct();
                              context.read<HomeCubit>().addProduct(
                                name: name,
                                quantity: int.parse(quantityText),
                                startDate: productionDate.toString(),
                                endDate: expiryDate.toString(),
                                sendNotification: notifyBefore,
                                image: _selectedImage!,
                              );
                            },

                            child: const Text("اضافة المنتج"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
        },
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label),
        ListTile(
          title: Text(
            date == null
                ? "اختر $label"
                : DateFormat('yyyy-MM-dd').format(date),
          ),
          trailing: const Icon(Icons.calendar_today),
          onTap: onTap,
        ),
      ],
    );
  }
}
