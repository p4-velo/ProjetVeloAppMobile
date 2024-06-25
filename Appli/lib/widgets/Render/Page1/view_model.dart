import 'package:flutter/material.dart';
import 'view.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  Page1State createState() {
    return Page1State();
  }
}

class Page1State extends State<Page1> {
  bool isLoading = false;

  void startLoading() async {
    setState(() {
      isLoading = true;
    });
  }

  void stopLoading() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    var currentView = MobileView(
      context: context,
      isLoading: isLoading,
    );

    return currentView.render();
  }
}
