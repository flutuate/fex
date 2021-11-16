import 'package:fex/infrastructure/linux/root_directory.dart';
import 'package:fex/presentation/DirectoriesView.dart';
import 'package:flutter/material.dart';
import '../integration_test/utils/ViewTestApp.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();

  final rootDir = RootDirectory();
  final view = DirectoryView(rootDir);

  runApp(ViewTestApp(view));
}