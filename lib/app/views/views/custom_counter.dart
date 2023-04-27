import 'package:flutter/material.dart';

import 'package:get/get_utils/src/extensions/context_extensions.dart';

class CustomCounter extends StatefulWidget {
  final double percentage;
  const CustomCounter({Key? key, required this.percentage}) : super(key: key);

  @override
  _CustomCounterState createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  double val = 0.0;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: widget.percentage.toDouble()),
      duration: const Duration(seconds: 1),
      builder: (BuildContext context, double _val, Widget? child) {
        return Text(
          _val.toInt().toString(),
          style: context.theme.textTheme.displayMedium,
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
