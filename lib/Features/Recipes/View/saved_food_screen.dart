import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:time_food/Core/Const/colors.dart';
import 'package:time_food/Core/Shared%20Widgets/snackBar_widget.dart';
import 'package:time_food/Features/Home/Cubit/home_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routing/routes.dart';

class SavedFoodScreen extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      'youtubeImage':
          'https://housefood.africa/wp-content/uploads/2022/04/beef.webp',
      'thumbnail': 'https://img.youtube.com/vi/VIDEO_ID/0.jpg',
      'url': 'https://www.youtube.com/watch?v=VIDEO_ID',
    },
    {
      'youtubeImage':
          'https://housefood.africa/wp-content/uploads/2022/04/beef.webp',
      'thumbnail': 'https://img.youtube.com/vi/VIDEO_ID/0.jpg',
      'url': 'https://www.youtube.com/watch?v=VIDEO_ID',
    },
    {
      'youtubeImage':
          'https://housefood.africa/wp-content/uploads/2022/04/beef.webp',
      'thumbnail': 'https://img.youtube.com/vi/VIDEO_ID/0.jpg',
      'url': 'https://www.youtube.com/watch?v=VIDEO_ID',
    },
    {
      'youtubeImage':
          'https://housefood.africa/wp-content/uploads/2022/04/beef.webp',
      'thumbnail': 'https://img.youtube.com/vi/VIDEO_ID/0.jpg',
      'url': 'https://www.youtube.com/watch?v=VIDEO_ID',
    },
  ];

  SavedFoodScreen({super.key});

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("المحفوظات"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: cPrimaryColor,
      ),
      body: BlocProvider(
        create: (context) => HomeCubit()..getAllProducts(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is DeleteProductsErrorState) {
              context.showErrorSnackBar("${state.message}حدث خظأ اثناء المسح:");
            }
            if (state is DeleteProductSuccessState) {
              context.showErrorSnackBar("تم المسح بنجاح", color: Colors.green);
              context.pushReplacementNamed(Routes.layoutScreen.name);
            }
          },
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = cubit.allProductsModel?.products[index];
                return state is DeleteProductsLoadingState
                    ? Center(
                      child: CircularProgressIndicator(color: cPrimaryColor),
                    )
                    : InkWell(
                      onTap: () {
                        context.pushNamed(Routes.productScreen.name);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade200,
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                cubit.deleteProduct(id: item?.id ?? "");
                              },
                              child: Icon(Icons.delete),
                            ),
                            SizedBox(width: 20.w),
                            InkWell(
                              onTap: () {
                                context.pushNamed(Routes.productScreen.name);
                              },
                              child: Icon(Icons.edit),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: .02.sw),
                              child: Text(
                                item?.name ?? "",
                                style: TextStyle(fontSize: 20.sp),
                              ),
                            ),
                            Image.network(
                              item?.image ?? "",
                              width: 100.w,
                              height: 80.w,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    );
              },
            );
          },
        ),
      ),
    );
  }
}
