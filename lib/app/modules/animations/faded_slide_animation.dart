import 'package:flutter/material.dart';

///FadedSlideAnimation is build using FadeTransition and SlideTransition

///fade and slide animation wrapper widget
///just wrap the child with this widget and widget will be animated
///child: the widget to be animated
///durationInMilliSeconds: duration of animation of fade (default: 400)
///slideDurationInMilliSeconds: duration of animation of slide (default: 800)
///curve: curve of the fade animation (default: Curves.decelerate)
///slideCurve: curve of the scale animation (default: Curves.easeInOutSine)
class FadedSlideAnimation extends StatefulWidget {
  final Widget child;
  final Offset beginOffset;
  final Offset endOffset;
  final int durationInMilliseconds;
  final int slideDurationInMilliseconds;
  final Curve curve;
  final Curve slideCurve;

  FadedSlideAnimation(
    this.child, {
    Key? key,
    required this.beginOffset,
    required this.endOffset,
    this.durationInMilliseconds = 400,
    this.slideDurationInMilliseconds = 800,
    this.curve = Curves.decelerate,
    this.slideCurve = Curves.easeInOutSine,
  }) : super(key: key);

  @override
  _FadedSlideAnimationState createState() => _FadedSlideAnimationState();
}

class _FadedSlideAnimationState extends State<FadedSlideAnimation>
    with TickerProviderStateMixin {
  AnimationController? controller;
  late CurvedAnimation animation;
  AnimationController? slideController;
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: widget.durationInMilliseconds),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    animation = CurvedAnimation(parent: controller!, curve: widget.curve);
    controller!.forward();
    slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
    offsetAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: widget.endOffset,
    ).animate(CurvedAnimation(
      parent: slideController!,
      curve: widget.slideCurve,
    ));
  }

  @override
  void dispose() {
    controller?.dispose();
    slideController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: offsetAnimation,
        child: widget.child,
      ),
    );
  }
}
