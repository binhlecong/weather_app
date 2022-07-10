import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/speedunit.dart';
import 'package:weather_app/providers/theme.dart';
import 'package:weather_app/providers/tempunit.dart';
import 'package:weather_app/screens/home_page.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => new ThemeNotifier(),
        ),
        ChangeNotifierProvider<TempUnitNotifier>(
          create: (_) => new TempUnitNotifier(),
        ),
        ChangeNotifierProvider<SpeedUnitNotifier>(
          create: (_) => new SpeedUnitNotifier(),
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
