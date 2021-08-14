import 'package:flutter/material.dart';
import 'package:weather_app/views/settingsection.dart';

class SettingList extends StatefulWidget {
  const SettingList({Key? key}) : super(key: key);

  @override
  _SettingListState createState() => _SettingListState();
}

class _SettingListState extends State<SettingList> {
  bool erasethis = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff5f5f7),
      ),
      child: ListView(
        children: [
          SettingSection(
            title: 'Appearance',
            settings: [
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: ListTile(
                  title: Text(
                    'Dark mode',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Switch(
                    value: erasethis,
                    onChanged: (value) {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
