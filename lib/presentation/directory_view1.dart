import 'dart:io';
import 'package:flutter/material.dart';
import 'package:f8n/locales.dart';

import 'widgets/StateEx.dart';

class DirectoryView1 extends StatefulWidget {
  final IIntl _intl;
  final Directory _dir;

  DirectoryView1(this._intl, this._dir);

  @override
  State<StatefulWidget> createState() => DirectoryView1State(_intl, _dir);
}

class DirectoryView1State<V extends DirectoryView1> extends StateEx<V> {
  final Directory _dir;
  final List<DirectoryView1> _subdirs = <DirectoryView1>[];

  bool _expandedView = false;

  DirectoryView1State(IIntl intl, this._dir) : super(intl);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildTile(context),
        _buildSubdirs(context),
      ],
    );
  }

  Widget _buildTile(BuildContext context) {
    return InkWell(
      onTap: () => _onClickExpandButton(),
      child: Row(
        children: [
          _buildExpandButton(context),
          _buildIcon(context),
          _buildName(context),
        ],
      ),
    );
  }

  Widget _buildExpandButton(BuildContext context) {
    final icon = _expandedView ? Icons.expand_more : Icons.chevron_right;
    return Container(
      padding: EdgeInsets.all(
        0.0,
      ),
      child: busy
          ? CircularProgressIndicator(key: Key('loadingSubdirs'))
          : Icon(icon),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Icon(Icons.storage);
  }

  Widget _buildName(BuildContext context) {
    var dirname = '/';
    if (_dir.path != '/') {
      dirname = File(_dir.path).uri.pathSegments.last;
    }
    return Text(dirname);
  }

  Widget _buildSubdirs(BuildContext context) {
    return Column(
      children: _subdirs,
    );
  }

  void _onClickExpandButton() {
    _expandedView = !_expandedView;
    loadSubdirectories();
  }

  void loadSubdirectories() {
    Future.delayed(Duration.zero).then((_) => _loadSubdirs());
  }

  /// TODO To use cache.
  void _loadSubdirs() {
    busy = true;
    _subdirs.clear();
    final list = Directory(_dir.path).listSync(recursive: false);
    for (var dir in list) {
      if (dir is Directory) {
        _subdirs.add(DirectoryView1(intl, _dir));
      }
    }
    busy = false;
  }
}
