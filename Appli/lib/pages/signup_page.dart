import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletton_projet_velo/widgets/Layout/view_model.dart';
import 'package:skeletton_projet_velo/widgets/Render/SignUp/view_model.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                    body: SignUp(),
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