import 'package:flutter/material.dart';

class StaticSpacer extends Container {
  StaticSpacer([double width = 15.0])
      : super(
          width: width,
          child: Text(''),
        );
}
