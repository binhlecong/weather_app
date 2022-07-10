import 'package:flutter/material.dart';

class AnimatedBox extends AnimatedWidget {
  const AnimatedBox({
    Key? key,
    required Animation<double> animation,
    required this.maxHeight,
    required this.child,
    this.reverse = false,
  }) : super(key: key, listenable: animation);

  // Make the Tweens static because they don't change.
  final double maxHeight;
  final Widget child;
  final bool reverse;
  static final _heightTween = Tween<double>(begin: 0, end: 40);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    return Center(
      child: Container(
        color: Color(0xffF2756D),
        height: _heightTween.evaluate(animation),
        child: child,
      ),
    );
  }
}

class AnimatedBoxFlat extends AnimatedWidget {
  const AnimatedBoxFlat({
    Key? key,
    required Animation<double> animation,
    required this.maxHeight,
    required this.child,
    this.reverse = false,
  }) : super(key: key, listenable: animation);

  // Make the Tweens static because they don't change.
  final double maxHeight;
  final Widget child;
  final bool reverse;
  static final _heightTween = Tween<double>(begin: 40, end: 0);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    return Center(
      child: Container(
        color: Color(0xffF2756D),
        height: _heightTween.evaluate(animation),
        child: child,
      ),
    );
  }
}
