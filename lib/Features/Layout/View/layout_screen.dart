import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_food/Core/Const/colors.dart';
import '../../../Core/Helper/cache_helper.dart';
import '../../../routing/routes.dart';
import '../Cubit/layout_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        var layoutCubit = LayoutCubit.get(context);
        return Scaffold(
          body: layoutCubit.screens[layoutCubit.selectedIndex],
          floatingActionButton: Container(
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            // Padding at the bottom
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    if (CacheHelper.getData(key: "token") != null) {
                      layoutCubit.changeIndex(3);
                    } else {
                      context.pushNamed(Routes.loginScreen.name);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color:
                          layoutCubit.selectedIndex == 3
                              ? cPrimaryColor.withOpacity(0.3)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: SizedBox(
                      child: Icon(
                        Icons.person,
                        color:
                            layoutCubit.selectedIndex == 3
                                ? Colors.white
                                : Colors.grey,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (CacheHelper.getData(key: "token") != null) {
                      layoutCubit.changeIndex(2);
                    } else {
                      context.pushNamed(Routes.loginScreen.name);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color:
                          layoutCubit.selectedIndex == 2
                              ? cPrimaryColor.withOpacity(0.3)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: SizedBox(
                      child: Icon(
                        Icons.save_alt_rounded,
                        color:
                            layoutCubit.selectedIndex == 2
                                ? Colors.white
                                : Colors.grey,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (CacheHelper.getData(key: "token") != null) {
                      layoutCubit.changeIndex(1);
                    }
                    else {
                      context.pushNamed(Routes.loginScreen.name);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color:
                      layoutCubit.selectedIndex == 1
                          ? cPrimaryColor.withOpacity(0.3)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: SizedBox(
                      child: Icon(
                        Icons.video_collection,
                        color:
                        layoutCubit.selectedIndex == 1
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    layoutCubit.changeIndex(0);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color:
                          layoutCubit.selectedIndex == 0
                              ? cPrimaryColor.withOpacity(0.3)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: SizedBox(
                      child: Icon(
                        Icons.home_filled,
                        color:
                            layoutCubit.selectedIndex == 0
                                ? Colors.white
                                : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
