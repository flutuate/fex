import 'dart:io';
import 'package:flutter/material.dart';
import 'package:f8n/locales.dart';

import 'widgets/StateEx.dart';

class DirectoryView extends StatefulWidget {
  final IIntl _intl;
  final Directory _dir;

  DirectoryView(this._intl, this._dir);

  @override
  State<StatefulWidget> createState() => DirectoryViewState(_intl, _dir);
}

class DirectoryViewState<V extends DirectoryView> extends StateEx<V> {
  final Directory _dir;
  final List<DirectoryView> _subdirs = <DirectoryView>[];

  bool _expandedView = false;

  DirectoryViewState(IIntl intl, this._dir) : super(intl);

  @override
  Widget build(BuildContext context) {
    /*return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: _buildDirectory(context),
      ),
    );*/
    return _buildDirectory(context);
  }

  Widget _buildDirectory(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildExpandButton(context),
        _buildIcon(context),
        _buildName(context),
        _buildSubdirs(context),
      ],
    );
  }

  Widget _buildExpandButton(BuildContext context) {
    final icon = _expandedView ? Icons.expand_more : Icons.chevron_right;
    return Material(
      child: InkWell(
        key: Key('expandButton'),
        onTap: () => _onClickExpandButton(),
        child: Container(
          padding: EdgeInsets.all(
            0.0,
          ),
          child: busy ? CircularProgressIndicator(key: Key('loadingSubdirs')) : Icon(icon),
        ),
      ),
    );
  }

  void _onClickExpandButton() {
    _expandedView = !_expandedView;
    loadSubdirectories();
  }

  Widget _buildIcon(BuildContext context) {
    return Icon(Icons.storage);
  }

  Widget _buildName(BuildContext context) {
    var dirname = '/';
    if(_dir.path != '/') {
      dirname = File(_dir.path).uri.pathSegments.last;
    }
    return Text(dirname);
  }

  void loadSubdirectories() {
    Future
        .delayed(Duration.zero)
        .then((_) => _loadSubdirs() );
  }

  /// TODO To use cache.
  void _loadSubdirs() {
    busy = true;
    _subdirs.clear();
    final list = Directory(_dir.path).listSync(recursive: false);
    for (var dir in list) {
      if (dir is Directory) {
        _subdirs.add(DirectoryView(intl, _dir));
      }
    }
    busy = false;
  }

  Widget _buildSubdirs(BuildContext context) {
    return Container(
      child: Column(
        children: _subdirs,
      ),
    );
  }
}
