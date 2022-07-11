import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatetimeView extends StatelessWidget {
  final DateTime datetime;
  final color;

  DatetimeView({required this.datetime, this.color});

  @override
  Widget build(BuildContext context) {
    String day = toBeginningOfSentenceCase(
            DateFormat('EEE, MMM d, y').format(datetime)) ??
        '__:__:__';

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10),
          Icon(
            Icons.calendar_today,
            color: color,
            size: 15,
          ),
          SizedBox(width: 5),
          Text(
            day,
            style: TextStyle(
              fontSize: 15,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
