import 'package:flutter/material.dart';
import 'dart:math';

extension StringExtension on String {
  bool get isPic {
    if (this.endsWith('jpg') ||
        this.endsWith('JPG') ||
        this.endsWith('png') ||
        this.endsWith('PNG') ||
        this.endsWith('jpeg') ||
        this.endsWith('JPEG') ||
        this.endsWith('bmp') ||
        this.endsWith('BMP') ||
        this.endsWith('webp') ||
        this.endsWith('WEBP') ||
        this.endsWith('GIF') ||
        this.endsWith('gif')) {
      return true;
    }
    return false;
  }

  bool get isVideo {
    if (this.endsWith('mp4') ||
        this.endsWith('MP4') ||
        this.endsWith('avi') ||
        this.endsWith('AVI') ||
        this.endsWith('wmv') ||
        this.endsWith('WMV') ||
        this.endsWith('mov') ||
        this.endsWith('MOV') ||
        this.endsWith('FLV') ||
        this.endsWith('flv')) {
      return true;
    }
    return false;
  }

  bool get isMedia {
    return this.isPic || this.isVideo;
  }

  bool get isAudio {
    if (this.endsWith('mp3') ||
        this.endsWith('wav') ||
        this.endsWith('vma') ||
        this.endsWith('cda') ||
        this.endsWith('ape')) {
      return true;
    }
    return false;
  }
}

extension OffsetExtension on Offset {
  double dot(Offset b) {
    return dx * b.dx + dy * b.dy;
  }

  Offset rotate(double angle) {
    if (angle == 0) {
      return this;
    }
    double cosAngle = cos(angle);
    double sinAngle = sin(angle);
    return Offset(dx * cosAngle + dy * sinAngle, dy * cosAngle - dx * sinAngle);
  }
}

extension doubleExtension on double {
  double get square {
    return this * this;
  }
}
