import 'dart:io';
import 'package:path/path.dart' as path;

class Directory
{
  final FileSystemEntity entity;

  Directory(this.entity);

  String get name => path.basename(entity.path);
}