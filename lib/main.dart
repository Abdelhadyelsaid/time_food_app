import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_food/Features/Auth/Cubit/auth_cubit.dart';
import 'package:time_food/firebase_options.dart';
import 'package:time_food/routing/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Core/Helper/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();
  runApp(MyApp(appRouter: CustomRouter()));
}

class MyApp extends StatelessWidget {
  final CustomRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
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
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
          );
        },
      ),
    );
  }
}
