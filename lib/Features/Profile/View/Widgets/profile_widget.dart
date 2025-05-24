import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:time_food/Core/Const/colors.dart';



class ProfileWidget extends StatelessWidget {
  final String title;
  final String svgIcon;
  final VoidCallback onTap;
  final Color? color;

   ProfileWidget({
    super.key,
    required this.title,
    required this.svgIcon,
    required this.onTap, this.color= const Color(0xFF5E5E5E),
  });

  @override
  Widget build(BuildContext context ) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: width * .9,
          height: height * .06,
          decoration:  BoxDecoration(
            color:  Colors.white ,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  title,
                  style:  TextStyle(
                    color: color  ,
                    fontSize: 13,
                    fontFamily: "Readex Pro",
                  ),
                ),
                Spacer(),
                SvgPicture.asset(
                  svgIcon,
                  width: 15,
                  height: 15,
                  color:  cSecondaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



///******* Profile Exit Widget *************
class ProfileExitWidget extends StatelessWidget {
  final String title;
  final String svgIcon;
  final VoidCallback onTap;

  const ProfileExitWidget({
    super.key,
    required this.title,
    required this.svgIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context ) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * .9,
        height: height * .06,
        decoration:  BoxDecoration(
          color:  Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Text(
                title,
                style:  TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                  // fontWeight: FontWeight.w500,
                  fontFamily: "Readex Pro",
                ),
              ),
              Spacer(),
              SvgPicture.asset(
                svgIcon,
                width: 15,
                height: 15,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

