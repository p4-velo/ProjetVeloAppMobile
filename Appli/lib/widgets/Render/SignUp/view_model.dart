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
  bool isErrorUsername = false;
  bool isErrorEmail = false;
  bool isErrorPassword = false;
  bool isErrorConfirmPwd = false;
  String errorTypeUsername = "None";
  String errorTypeEmail = "None";
  String errorTypePassword = "None";
  String errorTypeConfirmPwd = "None";


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
      isErrorUsername = controllerUsername.text.isEmpty;
      isErrorEmail = controllerEmail.text.isEmpty;
      isErrorPassword = controllerPassword.text.isEmpty;
      isErrorConfirmPwd = controllerConfirmPwd.text.isEmpty;
    });

    if(!isErrorUsername & !isErrorEmail & !isErrorPassword & !isErrorConfirmPwd){
      String pattern = r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
      RegExp regex = RegExp(pattern);
      if(regex.hasMatch(controllerEmail.text)) {
        if(controllerPassword.text == controllerConfirmPwd.text) {
          print("HAHAHAHAHAHHAHAHAHAHAHAHAHHAHAHAHAHHAHAHAHAHAHAHAHAHAHAHAHAHAH");
        }
        else {
          setState(() {
            isErrorPassword = true;
            isErrorConfirmPwd  = true;
            errorTypePassword = "Password";
            errorTypeConfirmPwd = "Password";
          });
        }
      }
      else {
        setState(() {
          isErrorEmail = true;
          errorTypeEmail = "Email";
        });
      }
    }
    else {
      setState(() {
        errorTypeUsername = "Empty";
        errorTypeEmail = "Empty";
        errorTypePassword = "Empty";
        errorTypeConfirmPwd = "Empty";
      });
    }
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
      isErrorUsername: isErrorUsername,
      isErrorEmail: isErrorEmail,
      isErrorPassword: isErrorPassword,
      isErrorConfirmPwd: isErrorConfirmPwd,
      errorTypeUsername: errorTypeUsername,
      errorTypeEmail: errorTypeEmail,
      errorTypePassword: errorTypePassword,
      errorTypeConfirmPwd: errorTypeConfirmPwd
    );

    return currentView.render();
  }
}