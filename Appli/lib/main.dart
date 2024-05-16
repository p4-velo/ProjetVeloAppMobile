import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletton_projet_velo/router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      //scrollBehavior: const MaterialScrollBehavior().copyWith(scrollbars: true),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

final GoRouter router = AppRouter.instance.createRouter();
