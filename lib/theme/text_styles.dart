import 'package:flutter/material.dart';

class TextStyles {
  BuildContext _context;

  TextStyle? get headline0 => Theme.of(_context).textTheme.headlineSmall;

  TextStyle? get headline1 => Theme.of(_context).textTheme.headlineSmall?.copyWith(
        fontSize: 20,
      );

  TextStyle? get headline2 => Theme.of(_context).textTheme.headlineSmall?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  TextStyle? get headline3 => Theme.of(_context).textTheme.headlineSmall?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      );

  TextStyle? getHeadline(int? header) {
    return switch (header) {
      null => headline1,
      0 => headline0,
      1 => headline1,
      2 => headline2,
      3 => headline3,
      _ => headline3,
    };
  }

  static TextStyle? withAlpha(TextStyle? textStyle, int alpha) {
    return textStyle?.copyWith(color: textStyle.color?.withAlpha(alpha));
  }

  TextStyles(this._context);

  factory TextStyles.of(BuildContext context) {
    return TextStyles(context);
  }
}
