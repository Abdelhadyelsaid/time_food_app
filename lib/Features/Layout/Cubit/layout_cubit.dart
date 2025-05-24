import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:time_food/Features/Auth/View/Screens/login_screen.dart';
import 'package:time_food/Features/Profile/View/Screens/profile_screen.dart';
import 'package:time_food/Features/Recipes/View/saved_food_screen.dart';
import '../../Home/View/home_screen.dart';
import '../../Recipes/View/receipts_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of<LayoutCubit>(context);

  int selectedIndex = 0;

  void changeIndex(int index) {
    selectedIndex = index;
    emit(LayoutChangeState());
  }

  List<Widget> screens = [
    HomeScreen(),
    YouTubeListScreen(),
    SavedFoodScreen(),
    HomeAccountScreen(),
  ];
}
