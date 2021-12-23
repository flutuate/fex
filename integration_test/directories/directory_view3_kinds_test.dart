import 'dart:io';
import 'package:fex/core/AssetsDart.dart';
import 'package:fex/infrastructure/file_system.dart';
import 'package:fex/presentation/directory_view3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:f8n/locales.dart';
import 'package:f8n/externals.dart';
import 'package:path_provider/path_provider.dart';

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

  final homePath = Platform.environment['HOME'] ?? '/home';
  final homeDir = Directory(homePath);

  testWidgets(
      'Given a directory \n'
      'When it is the Documents \n'
      'Then show with documents icon \n', (WidgetTester tester) async {

    final docsDir = await getApplicationDocumentsDirectory();

    if( docsDir.existsSync() ) {
      final view = DirectoryView3(intl, fs, homeDir);

      await tester.pumpWidget(ViewTestApp(view));
      await tester.pumpAndSettle();
      await tester.pump();

      var finder = find.byIcon(Icons.chevron_right_rounded, skipOffstage: false);
      await tester.doubleTap(finder);
      await tester.pumpAndSettle();

      final gesture = await tester.startGesture(Offset(0, 300)); //Position of the scrollview
      await gesture.moveBy(Offset(0, -300)); //How much to scroll by
      await tester.pump();

      final docsPath = docsDir.path;

      finder = find.byKey(Key(docsPath), skipOffstage: false);
      expect( finder, findsOneWidget );

      finder = find.widgetWithImage(DirectoryView3, AssetImage('assets/icons/documents.ico'));
      expect( finder, findsWidgets );
    }
  });

  testWidgets(
      'Given a directory \n'
          'When it is the Documents \n'
          'Then show with documents icon \n', (WidgetTester tester) async {

    final downloadsDir = await getDownloadsDirectory();

    if( downloadsDir!.existsSync() ) {
      final view = DirectoryView3(intl, fs, homeDir);

      await tester.pumpWidget(ViewTestApp(view));
      await tester.pumpAndSettle();
      await tester.pump();

      var finder = find.byIcon(Icons.chevron_right_rounded, skipOffstage: false);
      await tester.doubleTap(finder);
      await tester.pumpAndSettle();

      final gesture = await tester.startGesture(Offset(0, 300)); //Position of the scrollview
      await gesture.moveBy(Offset(0, -300)); //How much to scroll by
      await tester.pump();

      final downloadsPath = downloadsDir.path;

      finder = find.byKey(Key(downloadsPath), skipOffstage: false);
      expect( finder, findsOneWidget );

      finder = find.widgetWithImage(DirectoryView3, AssetImage('assets/icons/downloads.ico'));
      expect( finder, findsWidgets );
    }
  });
}
