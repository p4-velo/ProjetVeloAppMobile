import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_velo_app_mobile/pages/fav_address_page.dart';
import 'package:projet_velo_app_mobile/pages/help_page.dart';
import 'package:projet_velo_app_mobile/pages/login_page.dart';
import 'package:projet_velo_app_mobile/pages/map_page.dart';
import 'package:projet_velo_app_mobile/pages/signup_page.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();

  AppRouter._internal();

  final shellNavigatorKey = GlobalKey<NavigatorState>();

  static AppRouter get instance => _instance;

  GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: "/",
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
            child: const LoginPage(),
          ),
        ),
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
            child: const LoginPage(),
          )
        ),
        GoRoute(
          path: '/map',
          pageBuilder: (context, state) {
            final latitude = state.uri.queryParameters['latitude'];
            final longitude = state.uri.queryParameters['longitude'];

            return CustomTransitionPage(
              transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
              child: MapPage(latitude: latitude, longitude: longitude),
            );
          },
        ),


        GoRoute(
          path: '/favaddress',
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
            child: const FavAddressPage(),
          )
        ),
        GoRoute(
          path: '/signup',
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
            child: const SignUpPage(),
          )
        ),
        GoRoute(
          path: '/help',
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
            child: const HelpPage(),
          )
        ),
      ]
    );
  }
}