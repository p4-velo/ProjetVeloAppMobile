import 'package:flutter/material.dart';
import 'view.dart';

class FavAdresses extends StatefulWidget {
  const FavAdresses({super.key});

  @override
  FavAdressesState createState() {
    return FavAdressesState();
  }
}

class FavAdressesState extends State<FavAdresses> {
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