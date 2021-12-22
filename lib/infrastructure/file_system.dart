import 'dart:io';

import 'package:fex/domain/ifile_system.dart';
import 'package:path_provider/path_provider.dart';

class FileSystem implements IFileSystem
{
  late Directory _documentsDir;

  Future initialize() async {
    _documentsDir = await getApplicationDocumentsDirectory();
  }

  @override
  Directory get documentsDir => _documentsDir;

  @override
  bool isDocumentsFolder(Directory dir) => documentsDir.path == dir.path;
}





