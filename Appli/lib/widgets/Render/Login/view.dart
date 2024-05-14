import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MobileView {
  BuildContext context;
  bool isLoading;

  MobileView({
    required this.context,
    required this.isLoading,
  });

  render() {
    return Align(
      alignment: Alignment.topCenter,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              const Text('login'),
              ElevatedButton(
                onPressed: () {
                  context.go('/page1');
                },
                child: const Text('Page1')
              )
            ],
          );
        },
      ),
    );
  }
}