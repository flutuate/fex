/*import 'dart:async';
import 'dart:io';
import 'package:fex/fex.dart' as fex;

abstract class FileSystem {
  Stream<fex.Directory> directoriesFromPath(String path) async* {
    var stream = Directory(path).list(recursive: false);
    await for (final file in stream) {
      if (file is Directory) {
        yield fex.Directory(file);
      }
    }
  }

  void initialize();
}
*/