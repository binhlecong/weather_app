import 'package:flutter/material.dart';


class CRWThTileLayout extends StatelessWidget {
  final Widget child;
  final BoxDecoration decoration;

  CRWThTileLayout({required this.child, required this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: decoration,
      height: 220,
      child: child,
    );
  }
}
