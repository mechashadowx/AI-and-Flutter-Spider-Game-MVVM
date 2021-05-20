import 'package:flutter/material.dart';
import 'package:spider/src/ui/ui.dart';

// Text
final titleStyle = TextStyle(
  color: primary200,
  fontSize: headerFontSize,
  fontWeight: FontWeight.w700,
);

final largeBodyTextStyle = TextStyle(
  color: primary200,
  fontSize: headerFontSize,
  fontWeight: FontWeight.w700,
);

final normalTextStyle = TextStyle(
  color: primary100,
  fontSize: normalFontSize,
);

final pointsTextStyle = TextStyle(
  color: accent,
  fontSize: largeFontSize,
  fontWeight: FontWeight.w700,
);

// Buttons Text
final buttonTextStyle = TextStyle(
  color: primary300,
  fontSize: smallFontSize,
);

final activeButtonTextStyle = buttonTextStyle.copyWith(
  fontWeight: FontWeight.w700,
);

// Buttons
final buttonStyle = BoxDecoration(
  color: primary100,
  borderRadius: BorderRadius.circular(normalRadius),
);

final activeButtonStyle = buttonStyle.copyWith(
  color: accent,
);

final fabStyle = BoxDecoration(
  color: accent,
  borderRadius: BorderRadius.circular(fabSize),
);

// Grid
final cellStyle = BoxDecoration(
  borderRadius: BorderRadius.circular(normalRadius),
);
