import 'package:flutter/material.dart';

class LastUpdatedView extends StatelessWidget {
  final DateTime lastUpdatedOn;

  LastUpdatedView({required this.lastUpdatedOn});

  @override
  Widget build(BuildContext context) {
    var timeUpdated =
        TimeOfDay.fromDateTime(this.lastUpdatedOn).format(context);

    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.access_time,
            color: Colors.black45,
            size: 15,
          ),
          SizedBox(width: 10),
          Text(
            'Last updated at $timeUpdated',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black45,
            ),
          )
        ],
      ),
    );
  }
}
