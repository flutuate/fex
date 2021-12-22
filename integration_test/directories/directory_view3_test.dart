import 'dart:io';
import 'package:fex/core/AssetsDart.dart';
import 'package:fex/infrastructure/file_system.dart';
import 'package:fex/presentation/directory_view3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:f8n/locales.dart';
import 'package:f8n/externals.dart';

import '../extensions/widget_tester_ex.dart';
import '../utils/ViewTestApp.dart';

Future main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final locale = Locale('pt', 'BR');
  final assets = AssetsDart();
  final intl = IntlFromAssets(assets, locale);
  await intl.load();
  final fs = FileSystem();
  await fs.initialize();

  testWidgets(
      'Given a directory view \n'
      'When show it \n'
      'Then the expand button and icon is showed \n',
      (WidgetTester tester) async {
    final dirname = '/';
    final rootDir = Directory(dirname);
    final view = DirectoryView3(intl, fs, rootDir);

    await tester.pumpWidget(ViewTestApp(view));
    await tester.pumpAndSettle();
    await tester.pump();

    var finder = find.byIcon(Icons.chevron_right_rounded, skipOffstage: false);
    expect(finder, findsOneWidget);

    finder = find.byType(Image);
    expect(finder, findsOneWidget);

    finder = find.text(dirname, skipOffstage: false);
    expect(finder, findsOneWidget);
  });

  testWidgets(
      'Given a directory view \n'
      'When tap to expand it \n'
      'Then expansion icon is changed \n', (WidgetTester tester) async {
    final rootDir = Directory('/');
    final view = DirectoryView3(intl, fs, rootDir);

    await tester.pumpWidget(ViewTestApp(view));
    await tester.pumpAndSettle();
    await tester.pump();

    var finder = find.byIcon(Icons.chevron_right_rounded, skipOffstage: false);
    await tester.doubleTap(finder);
    await tester.pumpAndSettle();

    finder = find.byIcon(Icons.expand_more_rounded, skipOffstage: false);
    expect(finder, findsOneWidget);
  });

  testWidgets(
      'Given a directory view \n'
      'When tap to expand it \n'
      'Then its subdirectories are showed \n', (WidgetTester tester) async {
    final tempDir = Directory.systemTemp.createTempSync();
    const bla='bla-', ble='ble-', bli='bli-', blo='blo-', blu='blu-';
    tempDir.createTempSync(bla);
    tempDir.createTempSync(ble);
    tempDir.createTempSync(bli);
    tempDir.createTempSync(blo);
    tempDir.createTempSync(blu);

    final view = DirectoryView3(intl, fs, tempDir);

    await tester.pumpWidget(ViewTestApp(view));
    await tester.pumpAndSettle();
    await tester.pump();

    var finder = find.byIcon(Icons.chevron_right_rounded, skipOffstage: false);
    await tester.doubleTap(finder);
    await tester.pumpAndSettle();

    finder = find.textContaining(bla, skipOffstage: false);
    expect(finder, findsWidgets);
    finder = find.textContaining(ble, skipOffstage: false);
    expect(finder, findsWidgets);
    finder = find.textContaining(bli, skipOffstage: false);
    expect(finder, findsWidgets);
    finder = find.textContaining(blo, skipOffstage: false);
    expect(finder, findsWidgets);
    finder = find.textContaining(blu, skipOffstage: false);
    expect(finder, findsWidgets);
  });

  testWidgets(
      'Given a directory view \n'
      'When tap to expand it \n'
      'Then subdirs are ordered by name (default) \n', (WidgetTester tester) async {
    final tempDir = Directory.systemTemp.createTempSync();
    const bla='bla-', ble='BLE-', xyz='XyZ-', blo='bLo-', abc='abc-';
    tempDir.createTempSync(bla);
    tempDir.createTempSync(ble);
    tempDir.createTempSync(xyz);
    tempDir.createTempSync(blo);
    tempDir.createTempSync(abc);

    final view = DirectoryView3(intl, fs, tempDir);

    await tester.pumpWidget(ViewTestApp(view));
    await tester.pumpAndSettle();
    await tester.pump();

    var finder = find.byIcon(Icons.chevron_right_rounded, skipOffstage: false);
    await tester.doubleTap(finder);
    await tester.pumpAndSettle();

    finder = find.byKey(Key(tempDir.path));
    final widget = tester.firstWidget(finder) as Column;
    var previousName = '';
    for( var child in widget.children ) {
      final dirView = child as DirectoryView3;
      final name = dirView.name.toLowerCase();
      expect( name.compareTo(previousName), greaterThan(0) );
      previousName = name;
    }
  });
}

