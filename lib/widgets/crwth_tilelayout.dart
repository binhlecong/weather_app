import 'package:flutter/material.dart';

class CRWThTileLayout extends StatelessWidget {
  final Widget child;
  final BoxDecoration decoration;

  CRWThTileLayout({Key? key, required this.child, required this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 20,
      ),
      decoration: decoration,
      height: 220,
      child: child,
    );
  }
}
