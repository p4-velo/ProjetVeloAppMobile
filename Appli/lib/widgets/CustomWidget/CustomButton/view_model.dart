import 'package:flutter/material.dart';

import 'view.dart';

class CustomButton extends StatelessWidget {
  final dynamic callbackFunction;
  final dynamic text;
  final Color? textColor;
  final Color? backgroundColor;
  final Widget? icon;
  final Color? borderColor;
  final double height;
  final double width;
  

  const CustomButton({
    super.key,
    required this.callbackFunction,
    this.text = '',
    this.textColor,
    this.backgroundColor,
    this.icon,
    this.borderColor,
    required this.height,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    var currentView = MobileView(
      callbackFunction: callbackFunction,
      text: text,
      textColor: textColor,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      icon: icon,
      height: height,
      width: width
    );

    return currentView.render();
  }
}
