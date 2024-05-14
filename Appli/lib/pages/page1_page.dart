import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletton_projet_velo/widgets/Layout/view_model.dart';
import 'package:skeletton_projet_velo/widgets/Render/Page1/view_model.dart';

class Page1page extends StatelessWidget {
  const Page1page({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Expanded(
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Layout(
                  body: Page1(),
                )
              ),
            ),
          ],
        )
      )
    );
  }
}