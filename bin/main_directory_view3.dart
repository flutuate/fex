import 'dart:io';
import 'package:f8n/locales.dart';
import 'package:f8n/externals.dart';
import 'package:fex/core/AssetsDart.dart';
import 'package:fex/infrastructure/file_system.dart';
import 'package:fex/presentation/directory_view3.dart';
import 'package:flutter/material.dart';
import '../integration_test/utils/ViewTestApp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tempDir = Directory('/');

  final locale = Locale('pt', 'BR');
  final assets = AssetsDart();
  final intl = IntlFromAssets(assets, locale);
  await intl.load();
  final fs = FileSystem();
  await fs.initialize();

  runApp(ViewTestApp(DirectoryView3(intl, fs, tempDir)));
}
