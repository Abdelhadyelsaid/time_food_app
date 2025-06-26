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
import '../Models/products_model.dart';

class ProductEditorScreen extends StatefulWidget {
  const ProductEditorScreen({super.key, required this.productDetails});

  final Product productDetails;

  @override
  _ProductEditorScreenState createState() => _ProductEditorScreenState();
}

class _ProductEditorScreenState extends State<ProductEditorScreen> {
  final TextEditingController quantityController = TextEditingController();
  DateTime? productionDate;
  DateTime? expiryDate;
  bool notifyBefore = false;

  Future<void> pickDate(
    BuildContext context,
    Function(DateTime) onPicked,
  ) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (date != null) {
      onPicked(date);
    }
  }

  int calculateRemainingDays() {
    if (expiryDate == null) return 0;
    return expiryDate!.difference(DateTime.now()).inDays;
  }

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
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

  Widget _buildImagePicker() {
    return GestureDetector(
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
                : Image.network(
                  widget.productDetails.image ?? '',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[300],
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.broken_image,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                ),
      ),
    );
  }

  void initState() {
    super.initState();
    quantityController.text = widget.productDetails.quantity?.toString() ?? '';
    productionDate = widget.productDetails.startDate;
    expiryDate = widget.productDetails.expirationDate;
    notifyBefore = widget.productDetails.sendNotification ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final remainingDays = calculateRemainingDays();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(" تعديل المنتج"),
        centerTitle: true,
        backgroundColor: cPrimaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is EditProductErrorState) {
                context.showErrorSnackBar(
                  "${state.message}حدث خظأ اثناء الحفظ:",
                );
              }
              if (state is EditProductSuccessState) {
                context.showErrorSnackBar(
                  "تم الحفظ بنجاح",
                  color: Colors.green,
                );
                context.pushNamed(Routes.layoutScreen.name);
              }
            },
            builder: (context, state) {
              var cubit = HomeCubit.get(context);
              return state is EditProductLoadingState
                  ? Center(
                    child: CircularProgressIndicator(color: cPrimaryColor),
                  )
                  : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildImagePicker(),
                        SizedBox(height: 16),
                        Text("الكمية"),
                        TextField(
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text("تاريخ الإنتاج"),
                        ListTile(
                          title: Text(
                            productionDate == null
                                ? "اختر تاريخ الإنتاج"
                                : DateFormat(
                                  'yyyy-MM-dd',
                                ).format(productionDate!),
                          ),
                          trailing: Icon(Icons.calendar_today),
                          onTap:
                              () => pickDate(
                                context,
                                (date) => setState(() => productionDate = date),
                              ),
                        ),
                        Text("تاريخ الانتهاء"),
                        ListTile(
                          title: Text(
                            expiryDate == null
                                ? "اختر تاريخ الانتهاء"
                                : DateFormat('yyyy-MM-dd').format(expiryDate!),
                          ),
                          trailing: Icon(Icons.calendar_today),
                          onTap:
                              () => pickDate(
                                context,
                                (date) => setState(() => expiryDate = date),
                              ),
                        ),
                        SizedBox(height: 8),
                        CheckboxListTile(
                          title: Text("إرسال تذكير قبل انتهاء الوقت ؟"),
                          value: notifyBefore,
                          onChanged:
                              (val) => setState(() => notifyBefore = val!),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "الأيام المتبقية: ${remainingDays < 0 ? 0 : remainingDays} يوم",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(height: 24),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cPrimaryColor,
                              foregroundColor: Colors.white, // Text color
                            ),
                            onPressed: () {
                              cubit.editProduct(
                                id: widget.productDetails.id!,
                                quantity: int.parse(quantityController.text),
                                startDate: productionDate.toString(),
                                endDate: expiryDate.toString(),
                                sendNotification: notifyBefore,
                                image: _selectedImage,
                              );
                            },
                            child: Text("حفظ"),
                          ),
                        ),
                      ],
                    ),
                  );
            },
          ),
        ),
      ),
    );
  }
}
