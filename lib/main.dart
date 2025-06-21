import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:time_food/Core/Const/colors.dart';
import 'package:time_food/Core/Helper/dio_helper.dart';
import 'package:time_food/Features/Auth/Cubit/auth_cubit.dart';
import 'package:time_food/Features/Layout/Cubit/layout_cubit.dart';
import 'package:time_food/Features/Profile/Cubit/account_cubit.dart';
import 'package:time_food/firebase_options.dart';
import 'package:time_food/routing/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'Core/Helper/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Features/Notifications/Helper/local_notification.dart';
import 'Features/Notifications/Helper/notification_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();
  await DioHelper.init();
  tz.initializeTimeZones();
  if (Platform.isAndroid) {
    final plugin = FlutterLocalNotificationsPlugin();
    final androidImpl = plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await androidImpl?.requestNotificationsPermission();
  }

  await initLocalNotifications();
  runApp(MyApp(appRouter: CustomRouter()));
}

class MyApp extends StatelessWidget {
  final CustomRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => AccountCubit()),
        BlocProvider(create: (context) => LayoutCubit()),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(428, 926),
        builder: (_, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: CustomRouter.router,
            title: 'Flutter Demo',
            theme: ThemeData(
              useMaterial3: false,
              colorScheme: ColorScheme.fromSeed(
                seedColor: cPrimaryColor.withAlpha(120),
              ),
            ),
          );
        },
      ),
    );
  }
}
