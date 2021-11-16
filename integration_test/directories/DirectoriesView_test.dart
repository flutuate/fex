import 'dart:async';

import 'package:fex/infrastructure/linux/root_directory.dart';
import 'package:fex/presentation/DirectoriesView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../utils/ViewTestApp.dart';

Future main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Given the view \n'
    'When show it with a directory \n'
    'Then the expand button and icon is showed \n',
          (WidgetTester tester) async
  {
    final rootDir = RootDirectory();
    final view = DirectoryView(rootDir);

    await tester.pumpWidget(ViewTestApp(view));
    await tester.pumpAndSettle();
    await tester.pump();

    var finder = find.byIcon(Icons.expand_more, skipOffstage: false);
    expect(finder, findsWidgets);

    finder = find.byIcon(Icons.storage, skipOffstage: false);
    expect(finder, findsWidgets);

    finder = find.text(rootDir.name, skipOffstage: false);
    expect(finder, findsWidgets);
  });
}

