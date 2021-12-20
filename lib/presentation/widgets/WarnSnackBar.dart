import 'package:fex/presentation/common/app_colors.dart';
import 'package:flutter/material.dart';

class WarnSnackBar extends SnackBar {
  WarnSnackBar(String message, {Duration duration=const Duration(seconds: 5)})
      : super(
    content: Text(
      message,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
    ),
    backgroundColor: AppColors.avisoFundo,
    action: SnackBarAction(
      label: 'OK',
      //textColor: Colors.black,
      onPressed: () {},
    ),
    duration: duration,
  );
}
