import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:time_food/Core/Const/colors.dart';

class ProductEditorScreen extends StatefulWidget {
  const ProductEditorScreen({super.key});

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
    final XFile? image = await _picker.pickImage(source: source, imageQuality: 80);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _showImageSourcePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
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
        child: _selectedImage != null
            ? Image.file(_selectedImage!, height: 200, width: double.infinity, fit: BoxFit.cover)
            : Image.network(
          "https://housefood.africa/wp-content/uploads/2022/04/beef.webp",
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
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
          child: Padding(
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
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
                SizedBox(height: 16),
                Text("تاريخ الإنتاج"),
                ListTile(
                  title: Text(
                    productionDate == null
                        ? "اختر تاريخ الإنتاج"
                        : DateFormat('yyyy-MM-dd').format(productionDate!),
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
                  onChanged: (val) => setState(() => notifyBefore = val!),
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
                      backgroundColor: cPrimaryColor, // Button background color
                      foregroundColor: Colors.white, // Text color
                    ),
                    onPressed: () {
                      // Save logic here
                    },
                    child: Text("حفظ"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
