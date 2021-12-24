import 'package:flutter/material.dart';

class Images {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  Images._();

  static const Image folder = Image(
    image: AssetImage('assets/icons/folder.png'),
    width: 18,
    height: 18,
  );

  static const Image desktop = Image(
    image: AssetImage('assets/icons/desktop.png'),
    width: 18,
    height: 18,
  );

  static const Image documents = Image(
    image: AssetImage('assets/icons/documents.png'),
    width: 18,
    height: 18,
  );

  static const Image downloads = Image(
    image: AssetImage('assets/icons/downloads.png'),
    width: 18,
    height: 18,
  );

  static const Image music = Image(
    image: AssetImage('assets/icons/music.png'),
    width: 18,
    height: 18,
  );

  static const Image videos = Image(
    image: AssetImage('assets/icons/videos.png'),
    width: 18,
    height: 18,
  );

  static const Image pictures = Image(
    image: AssetImage('assets/icons/pictures.png'),
    width: 18,
    height: 18,
  );
}
