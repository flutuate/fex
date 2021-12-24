import 'dart:io';

import 'package:fex/core/AssetsDart.dart';
import 'package:fex/infrastructure/icon_extractor.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final assets = AssetsDart();
  final icoPath = 'test/assets/ico/folder.ico';
  var ico = await assets.load(icoPath);
  final extractor = IconExtractor();

  test('Given a ico file \n'
      'When read its header \n'
      'Then must be successful', () async
  {
    final header = extractor.readHeader(ico);
    expect(header.reserved, equals(0));
    expect(header.imageType, equals(ImageType.Icon));
    expect(header.imagesCount, equals(8));
  });

  test('Given a ico file \n'
      'When read first directory \n'
      'Then must be successful', () async
  {
    final dir = extractor.readDirectory(ico, 0);
    expect(dir.width, equals(256));
    expect(dir.height, equals(256));
    expect(dir.colorCount, equals(0));
    expect(dir.reserved, equals(0));
    expect(dir.colorPlanes, equals(1));
    expect(dir.bitsPerPixel, equals(32));
    expect(dir.sizeInBytes, equals(0x589b));
    expect(dir.offsetInFile, equals(0x86));
  });

  test('Given a ico file \n'
      'When run icon extractor'
      'Then its all icons must be extracted to specified directory', () async
  {
    final outputDir = Directory.systemTemp;
    final filenamePrefix = 'folder-';
    final files = await extractor.extractAll(ico, outputDir, filenamePrefix);
    expect(files.length, equals(8));
    for( var file in files ) {
      print(file.path);
      expect(file.existsSync(), equals(true));

      var png = File(file.path).readAsBytesSync().buffer.asByteData(0, 6);
      //expect( png.getUint8(0), equals(0x89));
      //expect( png.getUint8(1), 'P'.codeUnitAt(0));
      //expect( png.getUint8(2), 'N'.codeUnitAt(0));
      //expect( png.getUint8(3), 'G'.codeUnitAt(0));
      //expect( png.getUint8(4), '\r'.codeUnitAt(0));
      //expect( png.getUint8(5), '\n'.codeUnitAt(0));
    }
  });
}
