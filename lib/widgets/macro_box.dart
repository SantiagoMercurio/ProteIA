import 'package:flutter/material.dart';

class MacroBox extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  const MacroBox({
    required this.label,
    required this.value,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$value',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 16,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
