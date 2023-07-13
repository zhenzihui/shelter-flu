import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../model/local.dart';

class PieChartsPainter extends CustomPainter {
  final List<PieData> pieList;

  //点击位置
  final Offset tapDownPos;

  //控制饼状图绘制进程(0-1)
  final double progress;

  //控制饼状图点击项目增大的值
  final double itemAscendValue;

  //全局开始角度
  final _globalAngle = math.pi * -0.5;

  //一共需要绘制的角度=360度
  final _totalAngle = math.pi * 2;

  //绘制线条的宽度
  final double _strokeWidth = 35;

  //圆的半径
  double calRadius(Size size) => math.min(size.width, size.height) / 3;

  //得到圆心座标
  Offset getCenter(Size size) => Offset(size.width / 2, size.height / 2);

  get totalValue => pieList.map((p) => p.flex).reduce((a, b) => a + b);

  double getPercentOfTotal(double flex) => flex / totalValue;

  double getSweepAngle(double flex) =>
      _totalAngle * progress * getPercentOfTotal(flex);

  double distanceToCenter(Offset offset, Size size) {
    final center = getCenter(size);
    return math.sqrt(math.pow(offset.dx - center.dx, 2) +
        math.pow(offset.dy - center.dy, 2));
  }

  bool isInRange(double distance, Size size) {
    final stroke = _strokeWidth / 2;
    return calRadius(size) - stroke < distance &&
        calRadius(size) + stroke > distance;
  }

  PiePart? getTappedAngleData(Size size) {
    final angle = getTapAngle(size);
    //否则计算之前的角度
    var start = _globalAngle;
    for (final data in pieList) {
      final sweep = getSweepAngle(data.flex);
      final endAngle = start + sweep;
      // debugPrint("${data.name} 开始弧度: $start 结束弧度: $endAngle");
      if (angle >= start &&
          angle < endAngle &&
          isInRange(distanceToCenter(tapDownPos, size), size)) {
        return PiePart(start, sweep, data.color);
      }
      start = endAngle;
    }
    return null;
  }

  getTapAngle(Size size) {
    var center = getCenter(size);
    var angle =
        math.atan2(tapDownPos.dy - center.dy, tapDownPos.dx - center.dy);
    // debugPrint("点击点与中心点夹角: ${angle * (180 / math.pi)} 弧度：$angle");
    if (angle < -math.pi / 2) {
      //如果夹角小于-90度（同时大于-180度）， 需要用360度-夹角的绝对值获得真实的夹角
      angle = 2 * math.pi - angle.abs();
    }
    return angle;
  }

  PieChartsPainter(this.pieList,
      {required this.progress,
      required this.itemAscendValue,
      required this.tapDownPos});

  @override
  void paint(Canvas canvas, Size size) {
    drawCircle(canvas, size);
    drawAscend(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void drawCircle(Canvas canvas, Size size) {
    var startAngle = _globalAngle;
    // 确定圆的半径
    final double radius = calRadius(size);
    // 定义中心点
    //绘制线条的宽度
    final double strokeWidth = _strokeWidth;

    //把data中的flex加起来
    for (final data in pieList) {
      // 定义圆形的绘制属性
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..color = data.color
        ..strokeWidth = strokeWidth;
      var sweep = getSweepAngle(data.flex);

      // 使用 Canvas 的 drawCircle 绘制
      canvas.drawArc(Rect.fromCircle(center: getCenter(size), radius: radius),
          startAngle, sweep, false, paint);
      startAngle += sweep;
    }
  }

  drawAscend(Canvas canvas, Size size) {
    //计算出被触摸的部分的开始角度，覆盖角度
    final part = getTappedAngleData(size);
    if (part == null) {
      return;
    }
    // debugPrint("ascend value: $itemAscendValue");

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = part.color
      ..strokeWidth = _strokeWidth + (itemAscendValue * 10);
    canvas.drawArc(
        Rect.fromCircle(center: getCenter(size), radius: calRadius(size)),
        part.startAngle,
        part.sweepAngle,
        false,
        paint);
  }
}
