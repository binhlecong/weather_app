import 'package:flutter/material.dart';

const BoxDecoration _decoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black54,
      spreadRadius: 3,
      blurRadius: 7,
      offset: Offset(0, 4),
    ),
  ],
  color: Colors.white70,
  borderRadius: const BorderRadius.all(
    const Radius.circular(16),
  ),
);

class CRWThTileLayout extends StatelessWidget {
  final Widget child;
  final BoxDecoration decoration;

  CRWThTileLayout({required this.child, this.decoration = _decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: decoration,
        height: 220,
        child: child,
      ),
    );
  }
}
