import 'dart:io';
import 'package:fex/presentation/widgets/EmptyContainer.dart';
import 'package:flutter/material.dart';
import 'package:f8n/locales.dart';

import 'widgets/StateEx.dart';
import 'widgets/StaticSpacer.dart';
import 'widgets/images.dart';

class DirectoryView1 extends StatefulWidget {
  final IIntl _intl;
  final Directory _dir;
  final int _spacing;

  DirectoryView1(this._intl, this._dir, [this._spacing = 0]);

  @override
  State<StatefulWidget> createState() =>
      DirectoryView1State(_intl, _dir, _spacing);
}

class DirectoryView1State<V extends DirectoryView1> extends StateEx<V> {
  final Directory _dir;
  final List<DirectoryView1> _subdirs = <DirectoryView1>[];
  final int _spacing;

  bool _expandedView = false;

  DirectoryView1State(IIntl intl, this._dir, this._spacing) : super(intl);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTile(context),
        _buildSubdirs(context),
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
      _buildExpandButton(context),
      _buildIcon(context),
      SizedBox(width: 4, child:EmptyContainer()),
      _buildName(context),
    ]);

    final row = Row(
      children: children,
    );

    final child = Container(height: 28,child: row,);

    return InkWell(
      onTap: () => _onChangeExpansion(),
      child: child,
    );
  }

  Widget _buildExpandButton(BuildContext context) {
    final icon = _expandedView ? Icons.expand_more_rounded : Icons.chevron_right_rounded;
    return Container(
      padding: EdgeInsets.all(
        0.0,
      ),
      child: busy
          ? CircularProgressIndicator(key: Key('loadingSubdirs'))
          : Icon(icon, size: 14,),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Images.folder;
  }

  Widget _buildName(BuildContext context) {
    var dirname = '/';
    if (_dir.path != '/') {
      dirname = File(_dir.path).uri.pathSegments.last;
    }
    return Text(dirname);
  }

  Widget _buildSubdirs(BuildContext context) {
    if( _expandedView ) {
      return Column(
        children: _subdirs,
      );
    }
    return Column(
      children: <DirectoryView1>[]
    );
  }

  void _onChangeExpansion() {
    _expandedView = !_expandedView;
    if( _expandedView ) {
      loadSubdirectories();
    }
    else {
      setState(() {});
    }
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
        _subdirs.add(DirectoryView1(intl, dir, _spacing + 1));
      }
    }
    busy = false;
  }
}
