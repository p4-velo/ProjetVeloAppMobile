import 'package:flutter/material.dart';
import 'view.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  SignInState createState() {
    return SignInState();
  }
}

class SignInState extends State<SignIn> {
  bool isLoading = false;
  dynamic emailKey = GlobalKey<FormState>();
  dynamic passwordKey = GlobalKey<FormState>();

  void startLoading() async {
    setState(() {
      isLoading = true;
    });
  }

  void stopLoading() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    var currentView = MobileView(
      context: context,
      isLoading: isLoading,
      emailKey: emailKey,
      passwordKey: passwordKey,
    );

    return currentView.render();
  }
}