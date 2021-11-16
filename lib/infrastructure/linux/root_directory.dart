import 'dart:io' as io;

import 'package:fex/domain/models/directory.dart';

class RootDirectory extends Directory
{
  RootDirectory() : super(io.Directory('/'));
}