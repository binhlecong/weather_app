import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weather_app/models/onecallapi/weather.dart';

class TempChartView extends StatelessWidget {
  final List<HourlyWeather> data;
  TempChartView(this.data);

  final List<Color> gradientColors = [
    Color(0xffffa500),
    Color(0xffffff4c),
    Color(0xff3cb371),
    Color(0xff23b6e6),
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
            vertical: 10,
            horizontal: 20,
          ),
          child: LineChart(
            mainData(),
          ),
        ),
      ),
    );
  }

  LineChartData mainData() {
    DateTime today = data[0].date;
    double base = today.day * 24.0 + today.hour.toDouble();
    List<FlSpot> spots = data
        .map((e) => FlSpot(
              e.date.day * 24.0 + e.date.hour.toDouble() - base,
              e.temp - 273.0,
            ))
        .toList();

    var lineBarsData = [
      LineChartBarData(
        spots: spots,
        isCurved: false,
        colors: [Colors.red],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          gradientColorStops: [0.25, 0.5, 0.75, 1.0],
          gradientFrom: Offset(0, 0),
          gradientTo: Offset(0, 1),
          show: true,
          colors:
              gradientColors.map((color) => color.withOpacity(0.7)).toList(),
        ),
      ),
    ];

    var tooltipsOnBar = lineBarsData[0];
    var showIndexes = [for (var i = 0; i < 24; i++) i];

    return LineChartData(
      gridData: FlGridData(
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0x00000000),
            strokeWidth: 0,
          );
        },
        drawVerticalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 0,
          );
        },
      ),
      showingTooltipIndicators: showIndexes.map(
        (index) {
          return ShowingTooltipIndicators([
            LineBarSpot(
              tooltipsOnBar,
              lineBarsData.indexOf(tooltipsOnBar),
              tooltipsOnBar.spots[index],
            ),
          ]);
        },
      ).toList(),
      lineTouchData: LineTouchData(
        enabled: false,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: Colors.red,
              ),
              FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 8,
                  strokeWidth: 2,
                  strokeColor: Colors.black,
                ),
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(4),
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
            return lineBarsSpot.map((lineBarSpot) {
              return LineTooltipItem(
                lineBarSpot.y.toStringAsFixed(1),
                const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              );
            }).toList();
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: SideTitles(
          showTitles: false,
        ),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 12,
          interval: 2,
          margin: 8,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            var time = (today.hour + value.toInt()) % 24;
            return '${time.toString()}:00';
          },
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 23,
      minY: -30,
      maxY: 60,
      lineBarsData: lineBarsData,
    );
  }
}
