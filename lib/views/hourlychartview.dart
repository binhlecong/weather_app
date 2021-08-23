import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_app/providers/tempunit.dart';
import 'package:weather_app/views/tempchartview.dart';
import 'package:weather_app/views/uvchartview.dart';
import 'package:weather_app/views/windchartview.dart';
import 'package:weather_icons/weather_icons.dart';

class HourlyChartView extends StatefulWidget {
  HourlyChartView({required this.hourlyWeather});

  final List<HourlyWeather> hourlyWeather;

  @override
  State<HourlyChartView> createState() => _HourlyChartViewState();
}

class _HourlyChartViewState extends State<HourlyChartView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Consumer<TempUnitNotifier>(
        builder: (context, unit, _) {
          return Column(
            children: [
              TabBar(
                unselectedLabelColor: Colors.black26,
                labelColor: Colors.white,
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.white38,
                indicatorWeight: 12,
                tabs: [
                  Tab(
                    text: 'Temp' + ' \u1d52${unit.getTempUnit}',
                    icon: Icon(WeatherIcons.thermometer),
                  
                  ),
                  Tab(
                    text: 'UV index',
                    icon: Icon(WeatherIcons.day_sunny),
                  ),
                  Tab(
                    text: 'Wind',
                    icon: Icon(WeatherIcons.strong_wind),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: TempChartView(
                        widget.hourlyWeather,
                        unit.getTempUnit,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: UVChartView(widget.hourlyWeather),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: WindChartView(widget.hourlyWeather),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
