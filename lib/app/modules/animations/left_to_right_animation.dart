import 'package:flutter/material.dart';

class LefttoRightAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  const LefttoRightAnimation(
      {Key? key, required this.child, required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      child: child,
      duration: duration,
      builder: (BuildContext context, double _val, Widget? child) {
        return Padding(
          padding: EdgeInsets.only(left: _val * 10, right: 5),
          child: child,
        );
      },
    );
  }
}
