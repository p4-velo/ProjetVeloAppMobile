import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_velo_app_mobile/widgets/Render/SignUp/view_model.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: const Column(
            children: [
              Expanded(
                child: Center(
                  child: SignUp(),
                )
              ),
            ]
          )
        )
      )
    );
  }
}