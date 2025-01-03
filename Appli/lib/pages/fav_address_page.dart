import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_velo_app_mobile/widgets/Layout/view_model.dart';
import 'package:projet_velo_app_mobile/widgets/Render/favAddress/view_model.dart';

class FavAddressPage extends StatelessWidget {
  const FavAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: const Layout(
                  body: FavAddress(),
                )
              ),
            ),
          ],
        )
      )
    );
  }
}