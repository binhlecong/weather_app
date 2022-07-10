import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/theme.dart';

class BrightnessSwitch extends StatefulWidget {
  const BrightnessSwitch({Key? key}) : super(key: key);

  @override
  _BrightnessSwitchState createState() => _BrightnessSwitchState();
}

class _BrightnessSwitchState extends State<BrightnessSwitch> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == ThemeData.dark().brightness;

    return Container(
      child: ListTile(
        title: Text(
          'Dark mode',
          style: TextStyle(fontSize: 20),
        ),
        trailing: Consumer<ThemeNotifier>(
          builder: (context, theme, _) => Switch(
            value: isDark,
            onChanged: (value) {
              setState(() {
                isDark = value;
              });
              if (!isDark)
                theme.setLightMode();
              else
                theme.setDarkMode();
            },
          ),
        ),
      ),
    );
  }
}
