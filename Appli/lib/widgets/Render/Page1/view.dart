import 'package:flutter/material.dart';

class MobileView {
  BuildContext context;
  bool isLoading;

  MobileView({
    required this.context,
    required this.isLoading,
  });

  render() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return const Column(
          children: [
            Text('Page1')
          ],
        );
      },
    );
  }
}