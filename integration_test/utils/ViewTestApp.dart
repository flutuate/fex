import 'package:flutter/material.dart';

class ViewTestApp extends StatelessWidget
{
  final Widget view;

  ViewTestApp(this.view);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FEX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: view
    );
  }
}

