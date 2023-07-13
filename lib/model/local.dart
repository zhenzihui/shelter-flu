
import 'package:flutter/material.dart';
import 'dart:ui';

class BottomTabBarData {
  final String src;
  final String label;

  BottomTabBarData(this.src, this.label);
}
//绘图数据
class PiePart {
  final double startAngle;
  final double sweepAngle;
  final Color color;

  PiePart(this.startAngle, this.sweepAngle, this.color);
}
//用于计算的数据
class PieData {
  double flex;
  final Color color;
  final String name;


  PieData(this.flex, this.name, this.color);

  @override
  String toString() {
    return name;
  }
}

class PieAnimationData {

}
