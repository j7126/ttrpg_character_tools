import 'dart:math';

import 'package:flutter/material.dart';

class AdaptiveInfo {
  AdaptiveInfo({
    required this.isLandscape,
    required this.isLarge,
  });

  static AdaptiveInfo of(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isLandscape = size.width > size.height;
    var longEdge = max(size.width, size.height);
    var isLarge = longEdge > 1200;
    return AdaptiveInfo(isLandscape: isLandscape, isLarge: isLarge);
  }

  final bool isLandscape;
  final bool isLarge;
}
