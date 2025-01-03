import 'package:flutter/material.dart';
import 'package:projet_velo_app_mobile/global.dart' as global;

class MobileView {
  final dynamic callbackFunction;
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final Widget? icon;
  final Color? borderColor;
  final double height;
  final double width;

  MobileView({
    required this.callbackFunction,
    required this.text,
    this.textColor,
    this.backgroundColor,
    this.icon,
    this.borderColor,
    required this.height,
    required this.width
  });

  render() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: textColor ?? global.primary,
              backgroundColor: backgroundColor ?? Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: borderColor != null ? borderColor! : Colors.transparent),
              ),
            ),
            onPressed: callbackFunction,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (text != '')
                  Text(
                    text,
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                if (icon != null && text != '') const SizedBox(width: 10),
                if (icon != null) icon!,
              ],
            ),
          ),
        );
      },
    );
  }
}
