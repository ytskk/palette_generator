import 'package:flutter/widgets.dart';

/**
 * Problem colors:
 * #AFFDE0
 * #8AFE9A
 * #B5D5EB
 * #B6F9C7
 */

extension ColorX on Color {
  /// Increases the lightness of a color by a given [amount]. The [amount] must be
  /// between -1 and 1. The amount can be negative to darken the color or
  /// positive to lighten the color. -1 will be completely black and 1 will be
  /// completely white.
  Color changeLightness([double amount = 0.1]) {
    final amountValue = amount.clamp(-1, 1);

    final hslColor = HSLColor.fromColor(this);

    final lightness = (hslColor.lightness + amountValue).clamp(0.0, 1.0);

    var newColor = hslColor.withLightness(lightness);
    if (_isBlackColor() || _isWhiteColor()) {
      newColor = newColor.withSaturation(0);
    }

    return newColor.toColor();
  }

  /// Pretty dangerous! Requires some tests.
  bool _isBlackColor() => value == 0xFF000000;

  bool _isWhiteColor() => value == 0xFFFFFFFF;

  /// Decreases the color lightness.
  Color darker([double amount = 0.1]) => changeLightness(-amount);

  /// Increases the color lightness.
  Color lighter([double amount = 0.1]) => changeLightness(amount);

  double _getColorCoefficientBasedOnLightness() {
    final hslColor = HSLColor.fromColor(this);
    final lightness = hslColor.lightness;

    if (lightness > 0.9) return 1.1;
    if (lightness > 0.8) return 0.3;
    if (lightness > _lightnessThreshold) return 0.65;
    if (lightness < 0.2) return 0.6;

    return 1;
  }

  Color _changeLightnessByAmount([double amount = 0.1]) {
    final multiplier = isDarkColor ? 1 : -1;
    final newValue =
        amount * _getColorCoefficientBasedOnLightness() * multiplier;
    return changeLightness(newValue);
  }

  bool get isDarkColor =>
      HSLColor.fromColor(this).lightness < _lightnessThreshold;

  Color get hoverVariant => _changeLightnessByAmount(0.13);

  Color get highlightVariant => _changeLightnessByAmount(0.3);

  static const _lightnessThreshold = 0.45;

  /// Changes the color lightness depending on the brightness of the color.
  ///
  /// If color lightness is less then [_lightnessThreshold], the color is
  /// considered as dark color.
  ///
  /// [isNegative] flag is rarely used in case you need to invert the color.
  /// Make the dark color darker or bright brighter.
  Color adaptiveLightness({
    double amount = 0.1,
    bool isNegative = false,
  }) {
    var isDark = isDarkColor;
    isDark = isNegative ? !isDark : isDark;

    return changeLightness(isDark ? amount : -amount);
  }

  double toYIQ() => ((red * 299) + (green * 587) + (blue * 114)) / 1000;

  Color textColor({int threshold = 128}) => toYIQ() > threshold.clamp(0, 255)
      ? const Color(0xFF000000)
      : const Color(0xFFFFFFFF);
}
