import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/theme.dart';
import 'package:weather_app/providers/units.dart';
import 'package:weather_app/screens/homepage.dart';
import 'package:weather_app/utils/storagemanager.dart';

void main() async {
  // var brightness = await StorageManager.readData('brightness');
  // var temp_unit = await StorageManager.readData('temp_unit');

  // if (brightness == null) brightness = 'light';
  // if (temp_unit == null) temp_unit = 'C';

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => new ThemeNotifier(themeData: ThemeData.dark()),
        ),
        ChangeNotifierProvider<TempUnitNotifier>(
          create: (_) => new TempUnitNotifier(tempUnit: 'C'),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
        title: 'Open Weather API client',
        debugShowCheckedModeBanner: false,
        theme: theme.getTheme,
        home: SafeArea(
          child: HomePage(),
        ),
      ),
    );
  }
}
