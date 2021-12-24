import 'dart:io';

abstract class IFileSystem
{
  Directory get desktopDir;
  Directory get documentsDir;
  Directory get downloadsDir;
  Directory get musicDir;
  Directory get videosDir;
  Directory get picturesDir;

  bool isDesktopDir(Directory dir);

  bool isDocumentsDir(Directory dir);

  bool isDownloadsDir(Directory dir);

  bool isMusicDir(Directory dir);

  bool isVideosDir(Directory dir);

  bool isPicturesDir(Directory dir);
}
