import 'package:flutter/material.dart';
import 'view.dart';

class Layout extends StatefulWidget {
  final Widget body;

  const Layout({
    required this.body,
    super.key,
  });

  @override
  LayoutState createState() {
    return LayoutState();
  }
}

class LayoutState extends State<Layout> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentView = MobileView(
      context: context,
      body: widget.body
    );

    return currentView.render();
  }
}
