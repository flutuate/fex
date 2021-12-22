import 'dart:io';
import 'package:fex/domain/ifile_system.dart';
import 'package:flutter/material.dart';
import 'package:f8n/locales.dart';
import 'package:collection/collection.dart';

import 'widgets/EmptyContainer.dart';
import 'widgets/StateEx.dart';
import 'widgets/StaticSpacer.dart';
import 'widgets/images.dart';

class DirectoryView3 extends StatefulWidget {
  final IIntl _intl;
  final IFileSystem _fs;
  final Directory directory;
  final int _spacing;

  DirectoryView3(this._intl, this._fs, this.directory, [this._spacing = 0]);

  @override
  State<StatefulWidget> createState() =>
      DirectoryView3State(_intl, _fs, directory, name, _spacing);

  String get name {
    var dirname = '/';
    if (directory.path != '/') {
      dirname = File(directory.path).uri.pathSegments.last;
    }
    return dirname;
  }
}

class DirectoryView3State<V extends DirectoryView3> extends StateEx<V> {
  final IFileSystem _fs;
  final Directory _dir;
  final String _name;
  final int _spacing;

  final List<DirectoryView3> _subdirs = <DirectoryView3>[];
  bool _expandedView = false;

  DirectoryView3State(IIntl intl, this._fs, this._dir, this._name, this._spacing) : super(intl);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DirectoryView3>>(
      future: _loadSubdirs(),
      builder: (contextFuture, AsyncSnapshot<List<DirectoryView3>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildDirectory(
              contextFuture, snapshot.data ?? <DirectoryView3>[]);
        }
        return _buildDirectoryLoading(contextFuture);
      },
    );
/*
    final subdirsBuilder = FutureBuilder<List<DirectoryView3>>(
      future: _loadSubdirs(),
      builder: (contextFuture, AsyncSnapshot<List<DirectoryView3>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildSubdirs(context, snapshot.data ?? <DirectoryView3>[]);
        }
        return EmptyContainer();
      },
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTile(context),
        subdirsBuilder,
      ],
    );*/
  }

  Widget _buildDirectory(
      BuildContext contextFuture, List<DirectoryView3> subdirs) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // mainAxisSize: MainAxisSize.max,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTile(contextFuture),
        _buildSubdirs(contextFuture, subdirs),
      ],
    );
  }

  Widget _buildDirectoryLoading(BuildContext contextFuture) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTileLoading(contextFuture),
      ],
    );
  }

  Widget _buildTile(BuildContext context) {
    final children = <Widget>[];
    var spacing = _spacing;
    while (spacing > 0) {
      spacing--;
      children.add(StaticSpacer());
    }

    children.addAll([
      _buildExpander(context),
      _buildIcon(context),
      SizedBox(width: 4, child: EmptyContainer()),
      _buildName(context),
    ]);

    final row = Row(
      children: children,
    );

    final child = Container(
      height: 28,
      child: row,
    );

    return InkWell(
      onDoubleTap: () => _onChangeExpansion(),
      child: child,
    );
  }

  Widget _buildTileLoading(BuildContext context) {
    final children = <Widget>[];
    var spacing = _spacing;
    while (spacing > 0) {
      spacing--;
      children.add(StaticSpacer());
    }

    children.addAll([
      SizedBox(width: 14, height: 14, child: EmptyContainer()),
      _buildIcon(context),
      SizedBox(width: 4, child: EmptyContainer()),
      _buildName(context),
    ]);

    final row = Row(
      children: children,
    );

    return Container(
      height: 28,
      child: row,
    );
  }

  Widget _buildExpander(BuildContext context) {
    Widget icon = EmptyContainer();
    if (_subdirs.isNotEmpty) {
      icon = Icon(
        _expandedView ? Icons.expand_more_rounded : Icons.chevron_right_rounded,
        size: 14,
      );
    }
    return SizedBox(
      width: 14,
      height: 14,
      child: icon,
    );
  }

  Widget _buildIcon(BuildContext context) {
    if( _fs.isDocumentsFolder(_dir) ) {
      return Images.documents;
    }
    else {
      return Images.folder;
    }
  }

  Widget _buildName(BuildContext context) {
    return Text(_name, style: TextStyle(fontSize: 14),);
  }

  Widget _buildSubdirs(BuildContext context, List<DirectoryView3> subdirs) {
    final key = Key(_dir.path);
    if (_expandedView) {
      return Column(
        key: key,
        children: subdirs,
      );
    }
    return Column(
      key: key,
      children: <DirectoryView3>[],
    );
  }

  void _onChangeExpansion() {
    setState(() => _expandedView = !_expandedView);
  }

  /// TODO To use cache.
  Future<List<DirectoryView3>> _loadSubdirs() async {
    if (_subdirs.isEmpty) {
      var stream;
      try {
        // FileSystemException: Directory listing failed, path = '/lost+found/' (OS Error: Permission denied, errno = 13)
        stream = Directory(_dir.path).list(recursive: false);
      } catch (e) {
        stream = Stream<FileSystemEntity>.empty();
      }
      await for (var entity in stream) {
        if (entity is Directory) {
          _subdirs.add(DirectoryView3(intl, _fs, entity, _spacing + 1));
        }
      }
      _subdirs.sort((a, b) => compareAsciiLowerCase(a.name, b.name));
    }
    return _subdirs;
  }
}
