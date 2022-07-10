import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/speedunit.dart';

class SpeedUnitDialog extends StatefulWidget {
  const SpeedUnitDialog({Key? key}) : super(key: key);

  @override
  _SpeedUnitDialogState createState() => _SpeedUnitDialogState();
}

class _SpeedUnitDialogState extends State<SpeedUnitDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(
          'Wind speed',
          style: TextStyle(fontSize: 20),
        ),
        trailing: Container(
          width: 100,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Consumer<SpeedUnitNotifier>(
            builder: (context, unit, _) => Text(
              unit.getSpeedUnit,
            ),
          ),
        ),
        onTap: () {
          _showMaterialDialog(context);
        },
      ),
    );
  }

  void _showMaterialDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
        content: Consumer<SpeedUnitNotifier>(
          builder: (context, unit, _) {
            String u = unit.getSpeedUnit;
            String metric = SpeedUnit.metric;
            String imperial = SpeedUnit.imperial;

            return SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ListTile(
                    title: Text('Metric (km/h)'),
                    onTap: () {
                      setState(() {
                        u = 'C';
                        unit.setSpeedUnit(metric);
                      });
                    },
                    leading: Radio<String>(
                      value: metric,
                      groupValue: u,
                      onChanged: (value) {
                        setState(() {
                          u = value!;
                          unit.setSpeedUnit(metric);
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Imperial (mph)'),
                    onTap: () {
                      setState(() {
                        u = imperial;
                        unit.setSpeedUnit(imperial);
                      });
                    },
                    leading: Radio<String>(
                      value: imperial,
                      groupValue: u,
                      onChanged: (value) {
                        setState(() {
                          u = value!;
                        });
                        unit.setSpeedUnit(imperial);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
