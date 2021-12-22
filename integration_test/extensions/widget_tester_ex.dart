import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterEx on WidgetTester {
  Future doubleTap(Finder finder) async {
    await tap(finder);
    await pump(kDoubleTapMinTime);
    await tap(finder);
  }
}