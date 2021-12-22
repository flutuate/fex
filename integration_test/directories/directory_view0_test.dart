import 'dart:io';
import 'package:fex/core/AssetsDart.dart';
import 'package:fex/presentation/directory_view0.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:f8n/locales.dart';
import 'package:f8n/externals.dart';

import '../utils/ViewTestApp.dart';

Future main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final locale = Locale('pt', 'BR');
  final assets = AssetsDart();
  final intl = IntlFromAssets(assets, locale);
  await intl.load();

  testWidgets(
      'Given a directory view \n'
      'When show it \n'
      'Then the expand button and icon is showed \n',
      (WidgetTester tester) async {
    final rootDir = Directory('\\');
    final view = DirectoryView0(intl, rootDir);

    await tester.pumpWidget(ViewTestApp(view));
    await tester.pumpAndSettle();
    await tester.pump();

    var finder = find.byIcon(Icons.chevron_right, skipOffstage: false);
    expect(finder, findsOneWidget);

    finder = find.byIcon(Icons.storage, skipOffstage: false);
    expect(finder, findsOneWidget);

    final dirname = File(rootDir.path).uri.pathSegments.last;

    finder = find.text(dirname, skipOffstage: false);
    expect(finder, findsOneWidget);
  });

  testWidgets(
      'Given a directory view \n'
      'When tap on expand button \n'
      'Then a circular progress is showed \n', (WidgetTester tester) async {
    final rootDir = Directory('\\');
    final view = DirectoryViewWithSleep(intl, rootDir);

    await tester.pumpWidget(ViewTestApp(view));
    await tester.pumpAndSettle();
    await tester.pump();

    var finder = find.byIcon(Icons.chevron_right, skipOffstage: false);
    await tester.tap(finder);
    await tester.pump();
    await tester.pump();
    await tester.pump();

    finder = find.byKey(Key('loadingSubdirs'), skipOffstage: false);
    expect(finder, findsOneWidget);

    //TODO --ver se spring usa jackson internamente, para poder usar outra lib, ver exclude--
  });

  testWidgets(
      'Given a directory view \n'
          'When tap on expand button \n'
          'Then icon is changed \n',
          (WidgetTester tester) async
      {
        final rootDir = Directory('/');
        final view = DirectoryView0(intl, rootDir);

        await tester.pumpWidget(ViewTestApp(view));
        await tester.pumpAndSettle();
        await tester.pump();

        var finder = find.byIcon(Icons.chevron_right, skipOffstage: false);
        await tester.tap(finder);
        await tester.pumpAndSettle();

        finder = find.byIcon(Icons.expand_more, skipOffstage: false);
        expect(finder, findsOneWidget);
      });

  testWidgets(
      'Given a directory view \n'
          'When tap expand button \n'
          'Then its subdirectories are showed \n',
          (WidgetTester tester) async
      {
        final tempDir = Directory.systemTemp.createTempSync();
        tempDir.createTempSync('bla');
        tempDir.createTempSync('ble');
        tempDir.createTempSync('bli');
        tempDir.createTempSync('blo');
        tempDir.createTempSync('blu');

        final view = DirectoryView0(intl, tempDir);

        await tester.pumpWidget(ViewTestApp(view));
        await tester.pumpAndSettle();
        await tester.pump();

        var finder = find.byIcon(Icons.chevron_right, skipOffstage: false);
        await tester.tap(finder);
        await tester.pumpAndSettle();

        finder = find.text('bla', skipOffstage: false);
        expect(finder, findsWidgets);
        finder = find.text('ble', skipOffstage: false);
        expect(finder, findsWidgets);
        finder = find.text('bli', skipOffstage: false);
        expect(finder, findsWidgets);
        finder = find.text('blo', skipOffstage: false);
        expect(finder, findsWidgets);
        finder = find.text('blu', skipOffstage: false);
        expect(finder, findsWidgets);
      });
}

class DirectoryViewWithSleep extends DirectoryView0 {
  final IIntl _intl;
  final Directory _dir;

  DirectoryViewWithSleep(this._intl, this._dir) : super(_intl, _dir);

  @override
  State<StatefulWidget> createState() =>
      DirectoryViewStateWithSleep(_intl, _dir);
}

class DirectoryViewStateWithSleep
    extends DirectoryView0State<DirectoryViewWithSleep> {
  DirectoryViewStateWithSleep(IIntl intl, Directory dir) : super(intl, dir);

  @override
  void loadSubdirectories() {
    busy = true;
    // Do nothing
  }
}
