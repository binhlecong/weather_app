import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedBackItem extends StatelessWidget {
  const FeedBackItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).hoverColor,
      borderRadius: BorderRadius.all(
        Radius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(
              Icons.add_circle,
              color: Colors.blue,
              size: 28,
            ),
            SizedBox(width: 5),
            Text(
              'Drop to reposition',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
