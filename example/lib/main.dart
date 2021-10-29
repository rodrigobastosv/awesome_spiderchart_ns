import 'package:awesome_spiderchart_ns/chart_painter.dart';
import 'package:awesome_spiderchart_ns/spiderchart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: Chart()),
    );
  }
}

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpiderChartWidget(
      lineColor: Colors.green,
      activeLabelColor: Colors.black,
      nbSides: 5,
      onTap: (index) async {},
      strokeWidth: 2,
      labels: List.generate(
          5,
          (index) =>
              SpiderChartStatModel(roundSize: 4, label: index.toString())),
      valuesList: [
        SpiderChartValue(
          List.generate(5, (index) => index / 100),
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.blue,
            ],
          ),
          strokeColor: Colors.green,
        ),
      ],
    );
  }
}
