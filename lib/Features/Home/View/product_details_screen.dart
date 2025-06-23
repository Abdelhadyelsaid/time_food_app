import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:time_food/Core/Const/AppUrl.dart';
import 'package:time_food/Core/Const/colors.dart';
import 'package:time_food/Features/Home/Models/products_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key, required this.productDetails});

  final Product productDetails;

  int get remainingDays {
    return productDetails.expirationDate!
        .difference(DateTime.now())
        .inDays
        .clamp(0, double.infinity)
        .toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("تفاصيل المنتج"),
        centerTitle: true,
        backgroundColor: cPrimaryColor,
      ),
      body: SingleChildScrollView(
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
                _buildImage(),
                const SizedBox(height: 16),
                _buildDetail(
                  label: "الكمية",
                  value: productDetails.quantity.toString(),
                ),
                const SizedBox(height: 16),
                _buildDetail(
                  label: "تاريخ الإنتاج",
                  value: DateFormat(
                    'yyyy-MM-dd',
                  ).format(productDetails.startDate!),
                ),
                const SizedBox(height: 8),
                _buildDetail(
                  label: "تاريخ الانتهاء",
                  value: DateFormat(
                    'yyyy-MM-dd',
                  ).format(productDetails.expirationDate!),
                ),
                const SizedBox(height: 8),
                _buildDetail(
                  label: "إرسال تنبيه قبل الانتهاء",
                  value: productDetails.sendNotification! ? "نعم" : "لا",
                ),
                const SizedBox(height: 16),
                Text(
                  "الأيام المتبقية: $remainingDays يوم",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
       productDetails.image ?? "",
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildDetail({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
      ],
    );
  }
}
