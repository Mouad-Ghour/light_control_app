import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final bool disabled;

  const CustomSlider({
    Key? key,
    required this.value,
    required this.onChanged,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      onChanged: disabled ? null : onChanged,
      min: 0.0,
      max: 1.0,
      divisions: 100,
      label: '${(value * 100).round()}%',
    );
  }
}
