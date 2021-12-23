import 'dart:io';

import 'package:fex/domain/ifile_system.dart';
import 'package:path_provider/path_provider.dart';

class FileSystem implements IFileSystem
{
  late Directory _documentsDir;
  late Directory _downloadsDir;

  Future initialize() async {
    _documentsDir = await getApplicationDocumentsDirectory();
    _downloadsDir = await getDownloadsDirectory() ?? Directory('/');
  }

  @override
  Directory get documentsDir => _documentsDir;

  @override
  Directory get downloadsDir => _downloadsDir;

  @override
  bool isDocumentsFolder(Directory dir) => documentsDir.path == dir.path;

  @override
  bool isDownloadsFolder(Directory dir) => downloadsDir.path == dir.path;
}





