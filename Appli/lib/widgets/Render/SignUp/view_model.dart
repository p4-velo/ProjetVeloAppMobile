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
  dynamic fNameKey = GlobalKey<FormState>();
  dynamic lNameKey = GlobalKey<FormState>();
  dynamic usernameKey = GlobalKey<FormState>();
  dynamic emailKey = GlobalKey<FormState>();
  dynamic password1 = GlobalKey<FormState>();
  dynamic password2 = GlobalKey<FormState>();


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
      fNameKey: fNameKey,
      lNameKey: lNameKey,
      usernameKey: usernameKey,
      emailKey: emailKey,
      password1: password1,
      password2: password2,
    );

    return currentView.render();
  }
}