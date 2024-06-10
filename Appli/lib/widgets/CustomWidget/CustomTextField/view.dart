import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_velo_app_mobile/global.dart' as global;

class MobileView {
  BuildContext context;
  bool isLoading;
  String hintText;
  Icon? icon;
  Function(String?) customValidator;
  bool isValid;
  String? message;

  MobileView({
    required this.context,
    required this.isLoading,
    required this.hintText,
    this.icon,
    required this.customValidator,
    required this.isValid,
    required this.message
  });

  render() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return isValid ? Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(30),
          child: TextFormField(
            validator: (value) {
              customValidator(value);
              return null;
            },
            cursorColor: global.secondary,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.ptSans(
                textStyle: const TextStyle(color: Colors.grey, fontSize: 18),
              ),
              prefixIcon: icon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: global.tertiary,
                  width: 2,
                ),
              ),
            ),
          ),
        ) : Container(
          height: 80,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white
          ),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  customValidator(value);
                  return null;
                },
                cursorColor: global.secondary,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: GoogleFonts.ptSans(
                    textStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  prefixIcon: icon,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: global.tertiary,
                      width: 2,
                    ),
                  ),
                ),
              ),
              Text(
                message ?? ""
              )
            ],
          )
        );
      },
    );
  }
}