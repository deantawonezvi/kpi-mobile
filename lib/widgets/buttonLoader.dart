import 'package:flutter/material.dart';

class ButtonLoader extends StatefulWidget {
  @override
  _ButtonLoaderState createState() => _ButtonLoaderState();
}

class _ButtonLoaderState extends State<ButtonLoader> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ));
  }
}
