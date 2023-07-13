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
  late AnimationController _animationController;
  late AnimationController _ascendAnimationController;
  late Animation<double> _pieValueAnimation;
  late CurvedAnimation _pieDrawingCurvedAnimation;
  late Animation<double> _pieAscendAnimation;
  late CurvedAnimation _pieAscendCurvedAnimation;
  Offset _tapDownPos = Offset(0, 0);

  StatisticsWidgetState();

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: 1.seconds, vsync: this);
    _ascendAnimationController = AnimationController(duration: 0.5.seconds, vsync: this);
    _pieValueAnimation =
        Tween<double>(begin: 0, end: 1.0).animate(_animationController);
    _pieDrawingCurvedAnimation = CurvedAnimation(
        parent: _pieValueAnimation, curve: Curves.fastEaseInToSlowEaseOut);

    _pieAscendAnimation =
        Tween<double>(begin: 0, end: 1).animate(_ascendAnimationController);
    _pieAscendCurvedAnimation =
        CurvedAnimation(parent: _pieAscendAnimation, curve: Curves.fastEaseInToSlowEaseOut);
    _animationController.addListener(() {
      setState(() {});
    });
    _ascendAnimationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();
    _ascendAnimationController.dispose();
    _pieDrawingCurvedAnimation.dispose();
    _pieAscendCurvedAnimation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    _ascendAnimationController.forward();
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
              painter: PieChartsPainter(widget.dataList,
                  progress: _pieDrawingCurvedAnimation.value,
                  itemAscendValue: _pieAscendCurvedAnimation.value,
                  tapDownPos: _tapDownPos),
            )),
      ),
    );
  }
}
