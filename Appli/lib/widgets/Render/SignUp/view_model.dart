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
  dynamic password1Key = GlobalKey<FormState>();
  dynamic password2Key = GlobalKey<FormState>();


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
      password1Key: password1Key,
      password2Key: password2Key,
    );

    return currentView.render();
  }
}