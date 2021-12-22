import 'dart:io';

abstract class IFileSystem
{
  Directory get documentsDir;

  bool isDocumentsFolder(Directory dir);
}
