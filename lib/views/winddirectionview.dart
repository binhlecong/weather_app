import 'package:flutter/material.dart';
import 'dart:math';

class WindDirectionView extends StatelessWidget {
  final double degree;
  WindDirectionView(this.degree);

  @override
  Widget build(BuildContext context) {
    double a = (degree - 45) * pi / 180;

    return Container(
        child: Transform.rotate(
      angle: a,
      child: Image(
        image: AssetImage('assets/images/direction.png'),
        fit: BoxFit.cover,
      ),
    ));
  }
}
