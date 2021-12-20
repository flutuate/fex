import 'package:flutter/material.dart';
import 'package:fex/presentation/common/app_colors.dart';

class ErrorSnackBar extends SnackBar {
  ErrorSnackBar(String message, {Duration duration=const Duration(seconds: 5)})
    : super(
      content: Text(
        message,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      backgroundColor: AppColors.errorBackground,
      action: SnackBarAction(
        label: 'OK',
        //textColor: Colors.black,
        onPressed: () {},
      ),
      duration: duration,
    );
}
