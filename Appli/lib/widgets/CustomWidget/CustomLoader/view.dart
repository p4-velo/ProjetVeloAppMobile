import 'package:flutter/material.dart';

class LoaderView {
  final BuildContext context;
  final double size;
  final Color color;


  LoaderView({
    required this.context,
    required this.size,
    required this.color,
  });

  render() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) { 
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: color
            )
          )
        );
      }
    );
  }
}