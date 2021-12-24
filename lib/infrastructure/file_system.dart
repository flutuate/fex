import 'dart:io';

import 'package:fex/domain/ifile_system.dart';
import 'package:path_provider/path_provider.dart';

class FileSystem implements IFileSystem
{
  late Directory _homeDir;
  late Directory _desktopDir;
  late Directory _documentsDir;
  late Directory _downloadsDir;
  late Directory _musicDir;
  late Directory _videosDir;
  late Directory _picturesDir;

  Future initialize() async {
    final homePath = Platform.environment['HOME'] ?? '/home';
    _homeDir = Directory(homePath);
    _desktopDir = Directory(homePath + Platform.pathSeparator + 'Desktop');
    _documentsDir = await getApplicationDocumentsDirectory();
    _downloadsDir = await getDownloadsDirectory() ?? Directory('/');
    _musicDir = Directory(homePath + Platform.pathSeparator + 'Music');
    _videosDir = Directory(homePath + Platform.pathSeparator + 'Videos');
    _picturesDir = Directory(homePath + Platform.pathSeparator + 'Pictures');
  }

  @override
  Directory get desktopDir => _desktopDir;

  @override
  Directory get documentsDir => _documentsDir;

  @override
  Directory get downloadsDir => _downloadsDir;

  @override
  Directory get musicDir => _musicDir;

  @override
  Directory get videosDir => _videosDir;

  @override
  Directory get picturesDir => _picturesDir;

  @override
  bool isDocumentsDir(Directory dir) => documentsDir.path == dir.path;

  @override
  bool isDesktopDir(Directory dir) => desktopDir.path == dir.path;

  @override
  bool isDownloadsDir(Directory dir) => downloadsDir.path == dir.path;

  @override
  bool isMusicDir(Directory dir) => musicDir.path == dir.path;

  @override
  bool isVideosDir(Directory dir) => videosDir.path == dir.path;

  @override
  bool isPicturesDir(Directory dir) => picturesDir.path == dir.path;
}





