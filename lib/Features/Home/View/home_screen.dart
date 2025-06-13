import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widgets/grid_view_widget.dart';
import '../Widgets/search_textfield_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: .05.sh),
            child: SearchFieldWidget(),
          ),
          ImageGridScreen(),
        ],
      ),
    );
  }
}
