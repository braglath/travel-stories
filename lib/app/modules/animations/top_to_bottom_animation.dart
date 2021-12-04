import 'package:flutter/material.dart';

class ToptoBottomAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  const ToptoBottomAnimation(
      {Key? key, required this.child, required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      child: child,
      duration: duration,
      builder: (BuildContext context, double _val, Widget? child) {
        return Opacity(
          opacity: _val,
          child: Padding(
            padding: EdgeInsets.only(top: _val * 10, bottom: 5),
            child: child,
          ),
        );
      },
    );
  }
}
