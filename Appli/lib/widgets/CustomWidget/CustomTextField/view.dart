import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_velo_app_mobile/global.dart' as global;

class MobileView {
  BuildContext context;
  bool isLoading;
  String hintText;
  Icon? icon;
  TextEditingController controller;
  bool isError;
  FocusNode focusNode;
  String errorType;

  MobileView({
    required this.context,
    required this.isLoading,
    required this.hintText,
    this.icon,
    required this.controller,
    required this.isError,
    required this.focusNode,
    required this.errorType
  });

  render() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return !isError ? Container(
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white
          ),
          child: TextField(
            controller: controller,
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
            border: focusNode.hasFocus ? Border.all(
              color: global.tertiary,
              width: 2
            ) : const Border(),
            borderRadius: BorderRadius.circular(30),
            color: Colors.white
          ),
          child: Column(
            children: [
              TextField(
                focusNode: focusNode,
                controller: controller,
                cursorColor: global.secondary,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: GoogleFonts.ptSans(
                    textStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  prefixIcon: icon,
                  border: InputBorder.none
                ),
              ),
              Container(
                height: 1,
                width: constraints.maxWidth - 2,
                color: global.deleteColor
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    errorType == "Empty" ? "Veuillez remplir ce champ" : errorType == "Email" ? "Adresse Email invalide" : errorType == "Password" ? "Les mots de passe ne sont pas identiques" : "",
                    style: TextStyle(
                      color: global.deleteColor
                    ),
                  ),
                ],
              )
            ],
          )
        );
      },
    );
  }
}