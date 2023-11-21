import 'package:flutter/material.dart';
import 'package:palette_generator/controllers/controllers.dart';
import 'package:palette_generator/utils/utils.dart';
import 'package:palette_generator/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeShowcase extends StatelessWidget {
  const HomeShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Provider.of<PaletteGeneratorController>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Color variants'),
          ColorSwatchItem(
            value: palette.primaryColor,
            label: 'Primary Base',
          ),
          ColorSwatchItem(
            value: palette.primaryColor.hoverVariant,
            label: 'Primary Hover',
          ),
          ColorSwatchItem(
            value: palette.primaryColor.highlightVariant,
            label: 'Primary Pressed',
          ),
          const SizedBox(height: 44),
          Material(
            color: palette.primaryColor,
            textStyle: context.theme.textTheme.bodyLarge?.copyWith(
              color: palette.primaryColor.textColor(),
            ),
            child: InkWell(
              onTap: () {},
              splashColor: Colors.transparent,
              hoverColor: palette.primaryColor.hoverVariant,
              highlightColor: palette.primaryColor.highlightVariant,
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 4,
                ),
                child: Text('Button'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
