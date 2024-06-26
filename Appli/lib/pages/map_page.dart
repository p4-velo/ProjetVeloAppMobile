import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_velo_app_mobile/widgets/Layout/view_model.dart';
import 'package:projet_velo_app_mobile/widgets/Render/home/view_model.dart';

class MapPage extends StatelessWidget {
  final String? latitude;
  final String? longitude;

  const MapPage({super.key, this.latitude, this.longitude});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Layout(
                    body: Home(latitude: latitude, longitude: longitude),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
