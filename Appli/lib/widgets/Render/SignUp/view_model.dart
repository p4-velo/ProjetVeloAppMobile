import 'package:flutter/material.dart';
import 'view.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  SignUpState createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
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