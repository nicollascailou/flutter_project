import 'dart:io';

import 'package:flutter/material.dart';

class image_picker extends StatelessWidget {
  final File image;

  image_picker(this.image);

  @override
  Widget build(BuildContext context) {
    return image != null ? Container(child: Image.asset(image.path),) : Container();
  }
}
