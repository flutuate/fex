import 'package:flutter/material.dart';

class ViewTestApp extends StatelessWidget
{
  final Widget child;

  ViewTestApp(this.child);

  @override
  Widget build(BuildContext context) {
    /*
    final view = ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
          ),
          child: DirectoryView(intl, tempDir),
        ),
      ),
    );
    */

    final body = SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: child,
    );

    /*
    final view =
    ListView(
      children: [
        DirectoryView3(intl, tempDir),
      ],
    );
    */

    return MaterialApp(
      title: 'FEX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('ViewTestApp'),
        ),
        body: body,
      )
    );
  }
}

