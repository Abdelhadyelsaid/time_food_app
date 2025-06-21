import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Notifications/Helper/notification_helper.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () async{
        WidgetsBinding.instance.addPostFrameCallback((_) {
          NotificationHelper.scheduleNotificationAfter24Hours(context,"الاسماك",12);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            enabled: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "ابحث عن منتج",
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: Colors.grey,
                ), // Changed to grey color
              ),
            ),
          ),
        ),
      ),
    );
  }
}
