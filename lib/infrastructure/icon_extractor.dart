import 'dart:io';

import 'dart:typed_data';

// Incomplete, missing generate png from extract icons.
// To extract icons, use https://redketchup.io/icon-editor

class IconExtractor {
  static const headerSize = 6;

  Future<List<File>> extractAll(Uint8List content, Directory outputDir, String filenamePrefix) async {
    final files = <File>[];
    final header = readHeader(content);
    for (var index = 0; index < header.imagesCount; index++) {
      final dir = readDirectory(content, index);
      final file = await _extractImage(content, dir, outputDir, filenamePrefix);
      files.add(file);
    }
    return files;
  }

  IcoHeader readHeader(Uint8List content) {
    final byteData = content.buffer.asByteData(0, 6);
    final imageTypeIndex = byteData.getUint16(2, Endian.little);
    if (imageTypeIndex < 0 && imageTypeIndex > 1) {
      throw Exception('Invalid image type');
    }
    return IcoHeader(
      byteData.getUint16(0, Endian.little),
      ImageType.values[imageTypeIndex - 1],
      byteData.getUint16(4, Endian.little),
    );
  }

  IcoDirectory readDirectory(Uint8List content, int index) {
    final offset = headerSize + (index * 16);
    final byteData = content.buffer.asByteData(offset);
    var width = byteData.getUint8(0);
    var height = byteData.getUint8(1);
    width = width == 0 ? 256 : width;
    height = height == 0 ? 256 : height;
    final colorCount = byteData.getUint8(2);
    final reserved = byteData.getUint8(3);
    final colorPlanes = byteData.getUint16(4, Endian.little);
    final bitsPerPixel = byteData.getUint16(6, Endian.little);
    final sizeInBytes = byteData.getUint32(8, Endian.little);
    final offsetInFile = byteData.getUint32(12, Endian.little);
    return IcoDirectory(width, height, colorCount, reserved, colorPlanes,
        bitsPerPixel, sizeInBytes, offsetInFile);
  }

  Future<File> _extractImage(Uint8List content, IcoDirectory dir, Directory outputDir, String filenamePrefix) async {
    final bytes = content.buffer.asUint8List(dir.offsetInFile, dir.sizeInBytes);
    final path = outputDir.path + Platform.pathSeparator + filenamePrefix + '${dir.width}x${dir.height}.png';
    final file = File(path);
    await file.writeAsBytes(bytes.toList());
    return file;
  }
}

class IcoHeader {
  final int reserved;
  final ImageType imageType;
  final int imagesCount;

  IcoHeader(this.reserved, this.imageType, this.imagesCount);
}

enum ImageType { Icon, Cursor }

class IcoDirectory {
  final int width;
  final int height;
  final int colorCount;
  final int reserved;
  final int colorPlanes;
  final int bitsPerPixel;
  final int sizeInBytes;
  final int offsetInFile;

  IcoDirectory(this.width, this.height, this.colorCount, this.reserved,
      this.colorPlanes, this.bitsPerPixel, this.sizeInBytes, this.offsetInFile);
}
