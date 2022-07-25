import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as mImage;

class MoonUtil {
  static mImage.Image? image;
  static String imagePath = 'assets/lroc_color_poles_2k.png';
  static MoonUtil instance = MoonUtil._internal();
  MoonUtil._internal();
  factory MoonUtil() {
    return instance;
  }

  static Future<bool> setImage(String path) async {
    ByteData byteData = await rootBundle.load(path);
    Uint8List data = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    image = mImage.decodeImage(data);
    return true;
  }

  Future<ByteData> getFileData(String path) async {
    return await rootBundle.load(path);
  }
}
