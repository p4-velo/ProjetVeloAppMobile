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
    );

    return currentView.render();
  }
}