import 'package:flutter/material.dart';
import 'package:weather_app/views/settings/brightnesss_witch.dart';
import 'package:weather_app/views/settings/speed_unit_dialog.dart';
import 'package:weather_app/views/settings/temp_unit_dialog.dart';
import 'package:weather_app/widgets/setting_section_widget.dart';

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
          SettingSection(
            title: 'Units',
            settings: [
              TempUnitDialog(),
              SpeedUnitDialog(),
            ],
          ),
        ],
      ),
    );
  }
}
