import 'package:flutter/material.dart';

class SettingSection extends StatelessWidget {
  const SettingSection({
    Key? key,
    required this.title,
    this.settings = const [],
  }) : super(key: key);
  final String title;
  final List<Widget> settings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0x20ffffff),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 10,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...settings,
        ],
      ),
    );
  }
}
