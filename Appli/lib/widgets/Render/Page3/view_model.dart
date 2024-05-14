import 'package:flutter/material.dart';
import 'view.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  Page3State createState() {
    return Page3State();
  }
}

class Page3State extends State<Page3> {
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
