import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatetimeView extends StatelessWidget {
  final DateTime datetime;

  DatetimeView({required this.datetime});

  @override
  Widget build(BuildContext context) {
    String day = toBeginningOfSentenceCase(
            DateFormat.yMMMMd('en_US').format(datetime)) ??
        '??:??:??';

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10),
          Icon(
            Icons.calendar_today,
            color: Colors.green.shade900,
            size: 20,
          ),
          SizedBox(width: 5),
          Text(
            day,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
