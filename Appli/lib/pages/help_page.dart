import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_velo_app_mobile/widgets/Layout/view_model.dart';
<<<<<<<< HEAD:Appli/lib/pages/help_page.dart
import 'package:projet_velo_app_mobile/widgets/Render/Help/view_model.dart';
========
import 'package:projet_velo_app_mobile/widgets/Render/Page3/view_model.dart';
>>>>>>>> develop:Appli/lib/pages/page3_page.dart

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

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
                    body: Help(),
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