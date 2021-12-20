import 'package:f8n/locales.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'ErrorSnackBar.dart';
import 'WarnSnackBar.dart';

abstract class StateEx<T extends StatefulWidget> extends State<T> {
  final IIntl intl;

  late bool _busy;

  set busy(bool value) {
    if (_busy != value) {
      setState(() => _busy = value);
    }
  }

  bool get busy => _busy;

  bool get notBusy => !busy;

  StateEx(this.intl, {bool startBusy = false}) {
    _busy = startBusy;
  }

  Widget buildProgress() {
    final screenSize = MediaQuery.of(context).size;
    return Align(
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.8),
        alignment: Alignment.center,
        width: screenSize.width,
        height: screenSize.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Container(
              margin: EdgeInsets.only(top: 24.0),
            ),
            Text(
              intl['wait_please'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showError(String message, {Duration duration = const Duration(seconds: 5)}) {
    dev.log(message);
    final snackBar = ErrorSnackBar(
      message.toString(),
      duration: duration,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void showWarn(String message, {Duration duration = const Duration(seconds: 5)}) {
    dev.log(message);
    final snackBar = WarnSnackBar(
      message.toString(),
      duration: duration,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

