import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'spiderchart.dart';
import 'label_painter.dart';

class LabelWidget extends StatelessWidget {
  int index;
  int nbSides;
  Color lineColor, activeLabelColor;
  SpiderChartStatModel statModel;

  LabelWidget({
    required this.index,
    required this.nbSides,
    required this.lineColor,
    required this.activeLabelColor,
    required this.statModel,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SpiderChartLabelDrawer(
        roundSize: statModel.roundSize + statModel.roundSize,
        lineColor: Colors.red,
        activeLabelColor: this.activeLabelColor,
        sideIndex: index,
        label: statModel.label,
        nbSides: nbSides,
      ),
    );
  }
}
