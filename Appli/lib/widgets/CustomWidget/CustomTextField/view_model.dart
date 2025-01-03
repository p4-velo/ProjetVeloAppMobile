import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'view.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon? icon;
  final bool isError;
  final String errorType;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.icon,
    required this.isError,
    required this.errorType,
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
  FocusNode focusNode = FocusNode();


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
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    var currentView = MobileView(
      context: context,
      isLoading: isLoading,
      hintText: widget.hintText,
      icon: widget.icon,
      controller: widget.controller,
      isError: widget.isError,
      focusNode: focusNode,
      errorType: widget.errorType
    );

    return currentView.render();
  }
}