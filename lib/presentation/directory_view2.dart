import 'dart:async';
import 'dart:io';
import 'package:f8n/locales.dart';
import 'package:flutter/material.dart';

import 'widgets/StateEx.dart';

class DirectoryView2 extends StatefulWidget {
  final IIntl _intl;
  final Directory _dir;

  DirectoryView2(this._intl, this._dir);

  @override
  State<StatefulWidget> createState() => DirectoryView2State(_intl, _dir);
}

class DirectoryView2State<V extends DirectoryView2> extends StateEx<V> {
  final Directory _dir;
  final List<DirectoryView2> _subdirs = <DirectoryView2>[];

  bool _expandedView = false;

  DirectoryView2State(IIntl intl, this._dir) : super(intl);

  @override
  Widget build(BuildContext context) {
    final dirname = File(_dir.path).uri.pathSegments.last;
    return ExpansionTile(
      leading: const Icon(Icons.folder),
      title: Text(dirname),
      initiallyExpanded: _expandedView,
      onExpansionChanged: (expanded) {
        if( expanded ) {
          loadSubdirectories();
        }
      },
      children: _buildSubdirectories(context),
    );
  }

  void loadSubdirectories() {
    Future
        .delayed(Duration.zero)
        .then((_) => _loadSubdirs() );
  }

  /// TODO To use cache.
  void _loadSubdirs() async {
    busy = true;
    _subdirs.clear();
    final list = Directory(_dir.path).listSync(recursive: false);
    for (var dir in list) {
      if (dir is Directory) {
        _subdirs.add(DirectoryView2(intl, dir));
      }
    }
    busy = false;
  }

  List<Widget> _buildSubdirectories(BuildContext context) {
    if(busy) {
      return <Widget>[ buildProgress() ];
    }
    return _subdirs;
  }

  /*Widget _buildDirectory(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildExpandButton(context),
        _buildIcon(context),
        _buildName(context),
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
          child: Icon(icon),
        ),
      ),
    );
  }

  void _onClickExpandButton() {
    _expandedView = !_expandedView;
    if (_expandedView) {
      busy = true;
      _loadSubdirectories()
          .then((subdirs) {
            busy = false;
          })
          .onError((error, stackTrace) {
            busy = false;
            showError(error.toString());
          });
    }
  }

  Widget _buildIcon(BuildContext context) {
    return Icon(Icons.storage);
  }

  Widget _buildName(BuildContext context) {
    final dirname = File(_dir.path).uri.pathSegments.last;
    return Text(dirname);
  }
  */

}
