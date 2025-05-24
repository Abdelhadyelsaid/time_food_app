import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_food/Features/Auth/View/Screens/login_screen.dart';
import 'package:time_food/Features/Auth/View/Screens/splash_screen.dart';
import 'package:time_food/Features/Layout/View/layout_screen.dart';
import 'package:time_food/routing/routes.dart';

import '../Features/Home/View/product_screen.dart';

class CustomRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GoRouter _router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.splashScreen.path,
    routes: _routes,
  );

  static GoRouter get router => _router;
  static final List<GoRoute> _routes = [splashScreen, loginScreen,layoutScreen,productScreen];

  static final splashScreen = GoRoute(
    path: Routes.splashScreen.path,
    name: Routes.splashScreen.name,
    builder: (context, state) {
      return SplashScreen();
    },
  );
  static final loginScreen = GoRoute(
    path: Routes.loginScreen.path,
    name: Routes.loginScreen.name,
    builder: (context, state) {
      return LoginScreen();
    },
  );
  static final layoutScreen = GoRoute(
    path: Routes.layoutScreen.path,
    name: Routes.layoutScreen.name,
    builder: (context, state) {
      return LayoutScreen();
    },
  );

  static final productScreen = GoRoute(
    path: Routes.productScreen.path,
    name: Routes.productScreen.name,
    builder: (context, state) {
      return ProductEditorScreen();
    },
  );
}

class RouterTransitions {
  static CustomTransitionPage getFadeTransitionPage({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) => CustomTransitionPage(
    // transitionDuration: Duration(seconds: 3)
    child: child,
    key: state.pageKey,
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
  );

  static CustomTransitionPage getSlideTransitionPage({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) => CustomTransitionPage(
    child: child,
    key: state.pageKey,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const offsetBegin = Offset(1.0, 0.0);
      const offsetEnd = Offset.zero;

      var slideAnimation = Tween<Offset>(
        begin: offsetBegin,
        end: offsetEnd,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));

      return SlideTransition(position: slideAnimation, child: child);
    },
  );
}
