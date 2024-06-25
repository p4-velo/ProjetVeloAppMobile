import 'package:flutter/material.dart';
import 'view.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  HelpState createState() {
    return HelpState();
  }
}

class HelpState extends State<Help> {
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