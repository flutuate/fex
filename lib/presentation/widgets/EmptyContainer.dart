import 'package:flutter/material.dart';

@immutable
class EmptyContainer
extends Container
{
	EmptyContainer() : super(width:0.0, height:0.0 );
}

@immutable
class TransparentContainer
		extends Container
{
  TransparentContainer()
      : super(width: 0.0, height: 0.0, color: Colors.transparent);
}

