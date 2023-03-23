import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartProperties {
  Widget leftTitles(double value, TitleMeta meta) {
    // Switch case can also be used for this
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 6) {
      text = '2K';
    } else if (value == 13) {
      text = '4K';
    } else if (value == 19) {
      text = '6K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }
  
}