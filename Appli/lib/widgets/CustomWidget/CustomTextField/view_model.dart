import 'package:flutter/material.dart';
import 'view.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final Icon? icon;

  const CustomTextField({
    required this.hintText,
    this.icon,
    super.key
  });

  @override
  CustomTextFieldState createState() {
    return CustomTextFieldState();
  }
}

class CustomTextFieldState extends State<CustomTextField> {
  bool isLoading = false;
  dynamic formKey = GlobalKey<FormState>();
  bool isValid = true;
  String? message;


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

  void customValidator(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        isValid = false;
      });
      message = 'Ce champ ne peut pas être vide';
    }
    setState(() {
        isValid = true;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    var currentView = MobileView(
      context: context,
      isLoading: isLoading,
      hintText: widget.hintText,
      icon: widget.icon,
      customValidator: customValidator,
      isValid: isValid,
      message: message
    );

    return currentView.render();
  }
}