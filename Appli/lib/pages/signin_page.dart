import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_velo_app_mobile/widgets/Layout/view_model.dart';
import 'package:projet_velo_app_mobile/widgets/Render/SignIn/view_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: const Column(
            children: [
              Expanded(
                child: Center(
                  child: Layout(
                    body: SignIn(),
                  )
                ),
              )
            ]
          )
        )
      )
    );
  }
}