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
  dynamic formKey = GlobalKey<FormState>();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPwd = TextEditingController();
  bool isEmptyUsername = false;
  bool isEmptyEmail = false;
  bool isEmptyPassword = false;
  bool isEmptyConfirmPwd = false;


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

  Future<void> validateSignUp() async {
    setState(() {
      isEmptyUsername = controllerUsername.text.isEmpty;
      isEmptyEmail = controllerEmail.text.isEmpty;
      isEmptyPassword = controllerPassword.text.isEmpty;
      isEmptyConfirmPwd = controllerConfirmPwd.text.isEmpty;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    var currentView = MobileView(
      context: context,
      isLoading: isLoading,
      formKey: formKey,
      validateSignUp: validateSignUp,
      controllerUsername: controllerUsername,
      controllerEmail: controllerEmail,
      controllerPassword: controllerPassword,
      controllerConfirmPwd: controllerConfirmPwd,
      isEmptyUsername: isEmptyUsername,
      isEmptyEmail: isEmptyEmail,
      isEmptyPassword: isEmptyPassword,
      isEmptyConfirmPwd: isEmptyConfirmPwd
    );

    return currentView.render();
  }
}