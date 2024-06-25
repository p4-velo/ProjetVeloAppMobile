import 'package:flutter/material.dart';
import 'view.dart';

class CustomLoader extends StatefulWidget {
  final double size;
  final Color color;
  
  const CustomLoader({
    super.key,
    this.size = 30,
    this.color = Colors.blue,
  });

  @override
  CustomLoaderState createState() {
    return CustomLoaderState();
  }
}

class CustomLoaderState extends State<CustomLoader> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentView = LoaderView(
      context: context,
      size: widget.size,
      color: widget.color,
    );

    return currentView.render();
  }
}