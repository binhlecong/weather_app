import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/tempunit.dart';

class TempUnitDialog extends StatefulWidget {
  const TempUnitDialog({Key? key}) : super(key: key);

  @override
  _TempUnitDialogState createState() => _TempUnitDialogState();
}

class _TempUnitDialogState extends State<TempUnitDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(
          'Temperature',
          style: TextStyle(fontSize: 20),
        ),
        trailing: Container(
          width: 100,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Consumer<TempUnitNotifier>(
            builder: (context, unit, _) => Text(
              _getUnitName(unit.getTempUnit),
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
        content: Consumer<TempUnitNotifier>(
          builder: (context, unit, _) {
            String u = unit.getTempUnit;

            return SizedBox(
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ListTile(
                    title: Text('Celsius'),
                    onTap: () {
                      setState(() {
                        u = 'C';
                        unit.setTempUnit('C');
                      });
                    },
                    leading: Radio<String>(
                      value: 'C',
                      groupValue: u,
                      onChanged: (value) {
                        setState(() {
                          u = value!;
                          unit.setTempUnit('C');
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Fahrenheit'),
                    onTap: () {
                      setState(() {
                        u = 'F';
                        unit.setTempUnit('F');
                      });
                    },
                    leading: Radio<String>(
                      value: 'F',
                      groupValue: u,
                      onChanged: (value) {
                        setState(() {
                          u = value!;
                        });
                        unit.setTempUnit('F');
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Kevin'),
                    onTap: () {
                      setState(() {
                        u = 'K';
                        unit.setTempUnit('K');
                      });
                    },
                    leading: Radio<String>(
                      value: 'K',
                      groupValue: u,
                      onChanged: (value) {
                        setState(() {
                          u = value!;
                        });
                        unit.setTempUnit('K');
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

  String _getUnitName(unitSymbol) {
    switch (unitSymbol) {
      case 'C':
        return 'Celsius';
      case 'F':
        return 'Fahrenheit';
      case 'K':
        return 'Kevin';
      default:
        return 'Celsius';
    }
  }
}
