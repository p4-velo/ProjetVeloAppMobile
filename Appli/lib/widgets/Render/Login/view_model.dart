import 'package:flutter/material.dart';
import 'view.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
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
