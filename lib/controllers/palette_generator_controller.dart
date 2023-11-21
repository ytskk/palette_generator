import 'dart:math';

import 'package:flutter/material.dart';

class PaletteGeneratorController extends ChangeNotifier {
  PaletteGeneratorController() {
    primaryColor = generateRandomColor();
  }

  late Color _primaryColor;

  Color get primaryColor => _primaryColor;

  set primaryColor(Color value) {
    _primaryColor = value;
    notifyListeners();
  }
}

Color generateRandomColor() {
  final random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}
