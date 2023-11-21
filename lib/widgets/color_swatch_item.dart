import 'package:flutter/material.dart';

class ColorSwatchItem extends StatefulWidget {
  const ColorSwatchItem({
    required this.value,
    required this.label,
    super.key,
  });

  final Color value;
  final String label;

  @override
  State<ColorSwatchItem> createState() => _ColorSwatchItemState();
}

class _ColorSwatchItemState extends State<ColorSwatchItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          color: widget.value,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          height: 80,
          width: 120,
          child: isHovered
              ? const Center(
                  child: Icon(Icons.copy_rounded),
                )
              : null,
        ),
        const SizedBox(width: 16),
        Text(widget.label),
      ],
    );
  }
}
