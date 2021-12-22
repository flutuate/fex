import 'package:flutter/material.dart';

class Images {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  Images._();

  static const Image folder = Image(
    image: AssetImage('assets/icons/folder.ico'),
    width: 18,
    height: 18,
  );

  static const Image documents = Image(
    image: AssetImage('assets/icons/documents.ico'),
    width: 18,
    height: 18,
  );
}
