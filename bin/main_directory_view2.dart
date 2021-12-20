import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'package:f8n/locales.dart';
import 'package:f8n/externals.dart';
import 'package:f8n/services.dart';
import 'package:fex/core/AssetsDart.dart';
import 'package:fex/presentation/directory_view2.dart';
import 'package:flutter/material.dart';
import '../integration_test/utils/ViewTestApp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tempDir = io.Directory.systemTemp.createTempSync();
  tempDir.createTempSync('bla');
  tempDir.createTempSync('ble');
  tempDir.createTempSync('bli');
  tempDir.createTempSync('blo');
  tempDir.createTempSync('blu');

  final locale = Locale('pt', 'BR');
  final assets = AssetsDart();
  final intl = IntlFromAssets(assets, locale);
  await intl.load();

  final view = SingleChildScrollView(
    padding: const EdgeInsets.symmetric(
      horizontal: 16.0,
    ),
    child: DirectoryView2(intl, tempDir),
  );

  runApp(ViewTestApp(view));
}
