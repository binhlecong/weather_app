import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weather_app/data/models/api/weather.dart';

class HourlyUvChart extends StatelessWidget {
  final List<HourlyWeather> data;
  HourlyUvChart(this.data);

  final List<Color> gradientColors = [
    Color(0xffff2500),
    Color(0xffffa500),
    Color(0xffffff4c),
    Color(0xff3cb371),
    Color(0xff1376e6),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white38,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
          child: BarChart(
            mainData(),
          ),
        ),
      ),
    );
  }

  BarChartData mainData() {
    DateTime today = data[0].date;
    int base = today.day * 24 + today.hour;

    List<BarChartGroupData> spots = data
        .map(
          (e) => BarChartGroupData(
            showingTooltipIndicators: [0],
            x: (e.date.day * 24 + e.date.hour - base),
            barRods: [
              BarChartRodData(
                y: e.uvi + 1,
                width: 20,
                borderRadius: BorderRadius.zero,
                colors: [getBarColor(e.uvi)],
              ),
            ],
          ),
        )
        .toList();

    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 16,
      minY: 0,
      barTouchData: BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(8),
          tooltipMargin: 0,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              (rod.y - 1).toStringAsFixed(1),
              TextStyle(
                color: Colors.black45,
                fontSize: 12,
              ),
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          interval: 2,
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            var time = (today.hour + value.toInt()) % 24;
            return '${time.toString()}:00';
          },
        ),
        leftTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(show: false),
      barGroups: spots,
    );
  }

  Color getBarColor(double uvi) {
    if (uvi < 3) {
      return const Color(0xff289500);
    } else if (uvi >= 3.0 && uvi < 6) {
      return const Color(0xfff7e400);
    } else if (uvi >= 6.0 && uvi < 8) {
      return const Color(0xfff85900);
    } else if (uvi >= 8.0 && uvi < 11) {
      return const Color(0xffd8001d);
    } else if (uvi >= 11) {
      return const Color(0xff6b49c9);
    }
    return Colors.white;
  }
}
