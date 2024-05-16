import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_velo_app_mobile/widgets/Layout/view_model.dart';
import 'package:projet_velo_app_mobile/widgets/Render/Page3/view_model.dart';

class Page3page extends StatelessWidget {
  const Page3page({super.key});

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
                    body: Page3(),
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