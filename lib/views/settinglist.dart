import 'package:flutter/material.dart';
import 'package:weather_app/views/settings/brightnessswitch.dart';
import 'package:weather_app/views/settingsection.dart';

class SettingList extends StatefulWidget {
  const SettingList({Key? key}) : super(key: key);

  @override
  _SettingListState createState() => _SettingListState();
}

class _SettingListState extends State<SettingList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          SettingSection(
            title: 'Appearance',
            settings: [
              BrightnessSwitch(),
            ],
          ),
        ],
      ),
    );
  }
}
