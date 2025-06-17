import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:time_food/Core/Const/colors.dart';
import 'package:time_food/Features/Home/Cubit/home_cubit.dart';

import '../../../Core/Shared Widgets/snackBar_widget.dart';
import '../../../routing/routes.dart';

class ImageGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllProducts(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is GetAllProductsErrorState) {
            context.showErrorSnackBar(
              'Failed to get all products: ${state.message}',
            );
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return state is GetAllProductsLoadingState
              ? Center(child: CircularProgressIndicator(color: cPrimaryColor))
              : Padding(
                padding: EdgeInsets.symmetric(horizontal: .05.sw),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cubit.allProductsModel!.products.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      if (index == cubit.allProductsModel!.products.length ) {
                        // Plus container
                        return GestureDetector(
                          onTap: () {
                            context.pushNamed(Routes.addProductScreen.name);
                          },
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade300,
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 32,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'اضافة',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      final item = cubit.allProductsModel?.products[index];
                      return InkWell(
                        onTap: () {
                          context.pushNamed(Routes.productDetailsScreen.name, extra: {
                            "productDetails":cubit.allProductsModel?.products[index]
                          });
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item?.image ?? '',
                                width: double.infinity,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              item?.name ?? "",
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
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
