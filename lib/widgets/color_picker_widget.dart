import 'package:flutter/material.dart';
import 'package:palette_generator/utils/utils.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({
    required this.initialValue,
    super.key,
  });

  final Color initialValue;

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  late Color color = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.theme.colorScheme.onBackground,
                ),
                color: color,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixText: '#',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    color = _tryParseColorFromString(value) ?? color;
                  });
                },
                initialValue: widget.initialValue.value
                    .toRadixString(16)
                    .substring(2)
                    .toUpperCase(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(color),
              child: const Text('Save'),
            ),
          ],
        ),
      ],
    );
  }

  Color? _tryParseColorFromString(String? value) {
    final color = int.tryParse('FF${value ?? ''}', radix: 16);

    return Color(color ?? 0);
  }
}
