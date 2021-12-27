import 'package:flutter/material.dart';

class Images {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  Images._();

  static const Image folder = Image(
    image: AssetImage('assets/icons/folder.png'),
    fit: BoxFit.cover,
    //width: 18,
    //height: 18,
  );

  static const Image desktop = Image(
    image: AssetImage('assets/icons/desktop.png'),
    fit: BoxFit.cover,
    //width: 18,
    //height: 18,
  );

  static const Image documents = Image(
    image: AssetImage('assets/icons/documents.png'),
    fit: BoxFit.cover,
    //width: 18,
    //height: 18,
  );

  static const Image downloads = Image(
    image: AssetImage('assets/icons/downloads.png'),
    fit: BoxFit.fill,
    //width: 18,
    //height: 18,
  );

  static const Image music = Image(
    image: AssetImage('assets/icons/music.png'),
    fit: BoxFit.cover,
    //width: 18,
    //height: 18,
  );

  static const Image videos = Image(
    image: AssetImage('assets/icons/videos.png'),
    fit: BoxFit.cover,
    //width: 18,
    //height: 18,
  );

  static const Image pictures = Image(
    image: AssetImage('assets/icons/pictures.png'),
    fit: BoxFit.cover,
    //width: 18,
    //height: 18,
  );
}
