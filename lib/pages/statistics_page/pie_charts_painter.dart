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
  final double itemAscendMax = 10;
  final double? rotate;
  get ascendTotal => itemAscendValue * itemAscendMax;

  //全局开始角度
  final _globalAngle = math.pi * -0.5;

  //一共需要绘制的角度=360度
  final _totalAngle = math.pi * 2;

  //绘制线条的宽度
  final double _strokeWidth = 35;

  //计算得出的中心点
  late Offset _center;

  //计算得出的半径
  late double _radius;

  get totalValue => pieList.map((p) => p.flex).reduce((a, b) => a + b);

  get outerRadius => _radius + _strokeWidth / 2;
  get rotateAngle => (rotate??0.0)*math.pi*2;

  get startAngle => _globalAngle + rotateAngle;

      //圆的半径
  double calRadius(Size size) => math.min(size.width, size.height) / 5;

  //得到圆心座标
  Offset getCenter(Size size) => Offset(size.width / 2, size.height / 2);



  double getPercentOfTotal(double flex) => flex / totalValue;

  double getSweepAngle(double flex) =>
      _totalAngle * progress * getPercentOfTotal(flex);

  double distanceToCenter(Offset offset) {
    return math.sqrt(math.pow(offset.dx - _center.dx, 2) +
        math.pow(offset.dy - _center.dy, 2));
  }

  bool isInRange(double distance) {
    final stroke = _strokeWidth / 2;
    return _radius - stroke < distance && _radius + stroke > distance;
  }

  PiePart? getTappedAngleData() {
    final angle = getAngleToCenter(tapDownPos);
    //否则计算之前的角度
    var start = startAngle;
    for (final data in pieList) {
      final sweep = getSweepAngle(data.flex);
      final endAngle = start + sweep;
      // debugPrint("${data.name} 开始弧度: $start 结束弧度: $endAngle");
      if (angle >= start &&
          angle < endAngle &&
          isInRange(distanceToCenter(tapDownPos))) {
        return PiePart(start, sweep, data.color);
      }
      start = endAngle;
    }
    return null;
  }

  getAngleToCenter(Offset pos) {
    var angle = math.atan2(pos.dy - _center.dy, pos.dx - _center.dy);
    if (angle < -math.pi / 2) {
      //如果夹角小于-90度（同时大于-180度）， 需要用360度-夹角的绝对值获得真实的夹角
      angle = 2 * math.pi - angle.abs();
    }
    return angle;
  }

  getPercentage(double flex) {
    final text = "${getPercentOfTotal(flex) * 100}";
    return "${text.substring(0, text.indexOf(".") + 3)}%";
  }

  PieChartsPainter(this.pieList,
      {required this.progress,
      required this.itemAscendValue,
      required this.tapDownPos,
      this.rotate,
      });


  @override
  void paint(Canvas canvas, Size size) {
    _initValues(size);
    drawCircle(canvas, size);
    drawDescription(canvas, size);
    drawAscend(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void _initValues(Size size) {
    _center = getCenter(size);
    _radius = calRadius(size);
  }

  //画基本饼图
  void drawCircle(Canvas canvas, Size size) {
    var start = startAngle;
    // 确定圆的半径
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
      canvas.drawArc(Rect.fromCircle(center: _center, radius: _radius),
          start, sweep, false, paint);
      start += sweep;
    }
  }

  //画浮起来的项目
  drawAscend(Canvas canvas, Size size) {
    //计算出被触摸的部分的开始角度，覆盖角度
    final part = getTappedAngleData();

    if (part == null) {
      return;
    }

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = part.color
      ..strokeWidth = _strokeWidth + ascendTotal;
    canvas.drawArc(Rect.fromCircle(center: _center, radius: _radius),
        part.startAngle, part.sweepAngle, false, paint);
  }

  //画项目文本
  drawDescription(Canvas canvas, Size size) {
    var start = startAngle;
    var indicatorLength = 1.3;
    var horizontalLength = 10;

    for (var data in pieList) {
      final sweep = getSweepAngle(data.flex);
      var originY = math.sin(start + sweep / 2) * outerRadius;
      var originX = math.cos(start + sweep / 2) * outerRadius;
      final x = originX * indicatorLength;
      final y = originY * indicatorLength;
      final posWithCenter = Offset(x, y) + _center;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..color = data.color
        ..strokeWidth = 1;

      final startPos = _center + Offset(originX, originY);
      //画指向饼图的线
      canvas.drawLine(startPos, posWithCenter, paint);
      //画横线
      //转折点的角度
      final clipAngle = getAngleToCenter(posWithCenter);
      final horizontalOffset =
          clipAngle < math.pi / 2 ? horizontalLength : -horizontalLength;
      final horizontalOffsetPos =
          Offset(posWithCenter.dx + horizontalOffset, posWithCenter.dy);
      canvas.drawLine(posWithCenter, horizontalOffsetPos, paint);
      //画文字 上面data.toString()下面percent
      final descSpan =
          TextSpan(text: data.toString(), style: TextStyle(color: data.color));
      final percentSpan = TextSpan(
          text: getPercentage(data.flex), style: TextStyle(color: data.color));
      final descPainter = TextPainter(
          text: descSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      final percentPainter = TextPainter(
        text: percentSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      descPainter.layout();
      percentPainter.layout();
      const double verticalSpace = 2;
      final descOffset = Offset(horizontalOffset > 0? 0: - descPainter.width, -(descPainter.height + verticalSpace));
      final percentOffset = Offset(horizontalOffset > 0? 0: - percentPainter.width, verticalSpace);
      descPainter.paint(canvas, horizontalOffsetPos +  descOffset);
      percentPainter.paint(canvas, horizontalOffsetPos + percentOffset);
      start += sweep;
    }
  }
}
