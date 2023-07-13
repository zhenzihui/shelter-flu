import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shelter_client/model/local.dart';
import 'package:shelter_client/pages/statistics_page/pie_charts_painter.dart';

class StatisticsWidget extends StatefulWidget {
  final List<PieData> dataList;

  const StatisticsWidget({Key? key, required this.dataList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StatisticsWidgetState();
  }
}

class StatisticsWidgetState extends State<StatisticsWidget>
    with TickerProviderStateMixin {
  //绘制饼图动画

  late AnimationController _pieDrawingController;

  //绘制饼图点击弹起动画

  late AnimationController _ascendAnimationController;

  //饼图旋转动画

  late AnimationController _rotateAnimationController;
  late Animation<double> _pieValueAnimation;
  late CurvedAnimation _pieDrawingCurvedAnimation;
  late Animation<double> _pieAscendAnimation;
  late CurvedAnimation _pieAscendCurvedAnimation;
  late Animation<double> _pieRotateAnimation;
  Offset _tapDownPos = Offset(0, 0);

  StatisticsWidgetState();

  @override
  void initState() {
    super.initState();
    //绘制饼图动画
    _pieDrawingController =
        AnimationController(duration: 1.seconds, vsync: this);
    //绘制饼图点击弹起动画
    _ascendAnimationController =
        AnimationController(duration: 0.5.seconds, vsync: this);
    //饼图旋转动画
    _rotateAnimationController =
        AnimationController(vsync: this, duration: 15.seconds);
    _pieValueAnimation =
        Tween<double>(begin: 0, end: 1.0).animate(_pieDrawingController);
    _pieDrawingCurvedAnimation = CurvedAnimation(
        parent: _pieValueAnimation, curve: Curves.fastEaseInToSlowEaseOut);
    _pieRotateAnimation = Tween<double>(begin: 0, end: 1.0).animate(_rotateAnimationController);
    _pieAscendAnimation =
        Tween<double>(begin: 0, end: 1).animate(_ascendAnimationController);
    _pieAscendCurvedAnimation = CurvedAnimation(
        parent: _pieAscendAnimation, curve: Curves.fastEaseInToSlowEaseOut);
    
    _pieDrawingController.addListener(() {
      setState(() {});
    });
    _ascendAnimationController.addListener(() {
      setState(() {});
    });
    _rotateAnimationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {

    _pieDrawingController.dispose();
    _ascendAnimationController.dispose();
    _pieDrawingCurvedAnimation.dispose();
    _pieAscendCurvedAnimation.dispose();
    _rotateAnimationController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    _pieDrawingController.forward();
    _ascendAnimationController.forward();
    _rotateAnimationController.repeat();
    return Center(
      child: SizedBox(
        height: 300,
        width: 300,
        child: GestureDetector(
            onTapDown: (TapDownDetails details) {
              final localPos = details.localPosition;
              setState(() {
                _ascendAnimationController.reset();
                _tapDownPos = localPos;
              });
            },
            child: CustomPaint(
              painter: PieChartsPainter(
                widget.dataList,
                progress: _pieDrawingCurvedAnimation.value,
                itemAscendValue: _pieAscendCurvedAnimation.value,
                tapDownPos: _tapDownPos,
                rotate: _pieRotateAnimation.value
              ),
            )),
      ),
    );
  }
}
