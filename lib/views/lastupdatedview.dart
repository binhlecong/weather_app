import 'package:flutter/material.dart';

class LastUpdatedView extends StatelessWidget {
  final DateTime lastUpdatedOn;
  final color;

  LastUpdatedView({required this.lastUpdatedOn, required this.color});

  @override
  Widget build(BuildContext context) {
    var timeUpdated =
        TimeOfDay.fromDateTime(this.lastUpdatedOn).format(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.access_time,
            color: color,
            size: 15,
          ),
          SizedBox(width: 10),
          Text(
            'Last updated at $timeUpdated',
            style: TextStyle(
              fontSize: 16,
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
