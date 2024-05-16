import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_velo_app_mobile/widgets/Render/Login/view_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: const Column(
            children: [
              SafeArea(
                child: Expanded(
                  child: Center(
                    child: LoginForm()
                  ),
                ),
              )
            ]
          )
        )
      )
    );
  }
}