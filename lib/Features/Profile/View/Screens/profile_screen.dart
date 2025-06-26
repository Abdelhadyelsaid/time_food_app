import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:time_food/Core/Const/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Core/Helper/cache_helper.dart';
import '../../../../routing/routes.dart';
import '../Widgets/profile_widget.dart';

class HomeAccountScreen extends StatelessWidget {
  const HomeAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: .05.sw),
              child: Column(
                children: [
                  SizedBox(height: .02.sh),
                  Image.asset("assets/icons/appIcon.png"),
                  SizedBox(height: .04.sh),
                  ProfileWidget(
                    title: " خدمة العملاء",
                    svgIcon: 'assets/icons/arrow_icon.svg',
                    onTap: () async {
                      await launchUrl(Uri.parse("https://wa.me/201159746957"));
                    },
                  ),
                  SizedBox(height: .02.sh),
                  ProfileWidget(
                    title: " السياسات",
                    svgIcon: 'assets/icons/arrow_icon.svg',
                    onTap: () {},
                  ),
                  SizedBox(height: .02.sh),
                  ProfileWidget(
                    title: " عن التطبيق",
                    svgIcon: 'assets/icons/arrow_icon.svg',
                    onTap: () {},
                  ),
                  SizedBox(height: .044.sh),
                  ProfileWidget(
                    title: "  تقييم التطبيق",
                    svgIcon: 'assets/icons/arrow_icon.svg',
                    onTap: () {},
                  ),
                  SizedBox(height: .02.sh),
                  ProfileExitWidget(
                    title: 'تسجيل خروج',
                    svgIcon: 'assets/icons/arrow_icon.svg',
                    onTap: () {
                      CacheHelper.clear();
                      context.goNamed(Routes.loginScreen.name);
                    },
                  ),
                  SizedBox(height: .15.sh),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
