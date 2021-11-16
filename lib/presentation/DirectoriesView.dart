import 'package:fex/domain/models/directory.dart';
import 'package:flutter/material.dart';

class DirectoryView extends StatefulWidget {
  final Directory _dir;

  DirectoryView(this._dir);

  @override
  State<StatefulWidget> createState() => _State(_dir);
}

class _State extends State<DirectoryView> {
  final Directory _dir;

  bool _expandedView = false;

  _State(this._dir);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: _buildDirectory(context),
      ),
    );
  }

  Widget _buildDirectory(BuildContext context) {
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
    setState(() => _expandedView = !_expandedView);
  }

  Widget _buildIcon(BuildContext context) {
    return Icon(Icons.storage);
  }

  Widget _buildName(BuildContext context) {
    return Text(_dir.name);
  }
}
