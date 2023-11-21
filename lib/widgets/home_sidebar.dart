import 'package:flutter/material.dart';
import 'package:palette_generator/controllers/controllers.dart';
import 'package:palette_generator/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeSidebar extends StatelessWidget {
  const HomeSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final paletteController = Provider.of<PaletteGeneratorController>(context);

    return SizedBox(
      width: 260,
      child: DecoratedBox(
        decoration: const BoxDecoration(border: Border(right: BorderSide())),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              ListTile(
                onTap: () => onChangeColorTap(
                  context: context,
                  initialValue: paletteController.primaryColor,
                  onColorChanged: (newValue) =>
                      paletteController.primaryColor = newValue,
                ),
                leading: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: paletteController.primaryColor,
                  ),
                ),
                title: const Text('Primary Color'),
                subtitle: const Text('Acts as custom source color'),
                trailing: IconButton(
                  onPressed: () =>
                      paletteController.primaryColor = generateRandomColor(),
                  icon: const Icon(Icons.replay_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onChangeColorTap({
    required BuildContext context,
    required Color initialValue,
    required ValueSetter<Color> onColorChanged,
  }) async {
    final newColor = await showAdaptiveDialog<Color>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: const Text('Pick a new color'),
        content: ColorPickerWidget(initialValue: initialValue),
      ),
    );

    if (newColor != null) {
      onColorChanged(newColor);
    }
  }
}
