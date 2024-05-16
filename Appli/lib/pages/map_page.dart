import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletton_projet_velo/widgets/Layout/view_model.dart';
import 'package:skeletton_projet_velo/widgets/Render/home/view_model.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

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
                    body: Home(),
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