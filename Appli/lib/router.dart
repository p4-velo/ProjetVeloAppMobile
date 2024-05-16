import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletton_projet_velo/pages/login_page.dart';
import 'package:skeletton_projet_velo/pages/page1_page.dart';
import 'package:skeletton_projet_velo/pages/map_page.dart';
import 'package:skeletton_projet_velo/pages/page3_page.dart';
import 'package:skeletton_projet_velo/pages/signin_page.dart';
import 'package:skeletton_projet_velo/pages/signup_page.dart';
import 'package:skeletton_projet_velo/pages/help_page.dart';
import 'package:skeletton_projet_velo/pages/favadresses_page.dart';

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
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
            child: const MapPage(),
          )
        ),
        GoRoute(
          path: '/page1',
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
            child: const Page1page(),
          )
        ),
        GoRoute(
          path: '/page3',
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
            child: const Page3page(),
          )
        ),
        GoRoute(
          path: '/signin',
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
            child: const SignInPage(),
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
          path: '/favadresses',
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
            child: const FavAdressesPage(),
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