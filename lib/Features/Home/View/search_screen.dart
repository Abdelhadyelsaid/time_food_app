import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:time_food/Core/Const/colors.dart';
import 'package:time_food/Features/Home/Cubit/home_cubit.dart';

import '../../../routing/routes.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return SafeArea(
            child: BlocProvider(
              create: (context) => HomeCubit(),
              child: BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {},
                builder: (context, state) {
                  var cubit = HomeCubit.get(context);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              onChanged: (value) {
                                cubit.searchProduct(name: value);
                              },
                              controller: cubit.controller,
                              enabled: true,
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
                        SizedBox(height: 20),
                        state is SearchSuccessState
                            ? Directionality(
                              textDirection: TextDirection.rtl,
                              child: SizedBox(
                                height: 720.h,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (context, index) => GestureDetector(
                                        onTap: () async {
                                          context.pushNamed(Routes.productDetailsScreen.name,extra: {
                                            "productDetails":cubit.allProductsModel?.products[index]
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 16,
                                          ),
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            color: Colors.grey.shade200,
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: .02.sw,
                                                ),
                                                child: Text(
                                                  cubit
                                                          .allProductsModel
                                                          ?.products[index]
                                                          .name ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 20.sp,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Image.network(
                                                cubit
                                                        .allProductsModel
                                                        ?.products[index]
                                                        .image ??
                                                    "",
                                                width: 100.w,
                                                height: 80.w,
                                                fit: BoxFit.cover,
                                                errorBuilder: (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) {
                                                  return Container(
                                                    width: 100.w,
                                                    height: 80.w,
                                                    color: Colors.grey.shade200,
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      Icons.broken_image,
                                                      size: 40,
                                                      color: Colors.grey,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  separatorBuilder:
                                      (context, index) => SizedBox(height: 10.h),
                                  itemCount:
                                      cubit.allProductsModel!.products.length,
                                ),
                              ),
                            )
                            : cubit.allProductsModel?.products == null
                            ? Center(
                              child: Text(
                                "لايوجد نتائج",
                                style: TextStyle(
                                  color: cPrimaryColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Readex Pro",
                                ),
                              ),
                            )
                            : SizedBox(),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
