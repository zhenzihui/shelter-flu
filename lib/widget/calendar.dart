import 'package:flutter/material.dart';
import 'dart:math' as math;

//单个日期
class CalendarItem extends StatelessWidget {
  final bool selected;
  final Color backgroundColor;
  final Color borderColor;
  final Text dateText;
  final Size size;
  final List<Widget> upperMarks;
  final List<Widget> beneathMarks;

  const CalendarItem({
    super.key,
    required this.selected,
    required this.backgroundColor,
    required this.dateText,
    required this.size,
    required this.borderColor,
    this.upperMarks = const [],
    this.beneathMarks = const [],
  });

  @override
  Widget build(BuildContext context) {
    final border = BorderRadius.circular(6);
    final double borderWidth = 2;

    return Container(
      width: size.width + borderWidth,
      height: size.height + borderWidth,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
          borderRadius: border,
          border: selected
              ? Border.all(color: borderColor, width: borderWidth)
              : null),
      child: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: border,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            upperMarks.isEmpty
                ? const Spacer()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: upperMarks,
                  ),
            dateText,
            // Spacer()
            beneathMarks.isEmpty
                ? const Spacer()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: beneathMarks,
                  ),
          ],
        ),
      ),
    );
  }
}

class MonthView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MonthViewState();
  }
}

class MonthViewState extends State<MonthView> {
  double top = 0;
  double formOffset = 0;
  double calendarOffset = 0;
  Size itemSize = Size(60, 60);

  double moveRangeY = double.infinity;
  double titleHeight = 10;
  late double calendarHeight = itemSize.height * 6;

  late double calendarTop = titleHeight;

  int selectedDay = 9;

  List<int> daysOfMonths() =>
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17];
  Map<int, GlobalKey> dayKeyMap = {};

  Offset _getItemLocalUpConstraint(BuildContext context, int day) {
    final key = dayKeyMap[day];
    if (key == null) {
      return Offset.zero;
    }
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    final globalPos = box?.localToGlobal(Offset.zero) ?? Offset.zero;
    return (context.findRenderObject() as RenderBox?)
            ?.globalToLocal(globalPos) ??
        Offset.zero;
  }

  // 生成widget列表并记录
  _getDayItems() {
    return daysOfMonths().map((d) {
      final itemKey = GlobalKey();
      dayKeyMap.addAll({d: itemKey});
      final selected = d == selectedDay;
      return CalendarItem(
        key: itemKey,
        size: itemSize,
        selected: selected,
        backgroundColor: Colors.blueAccent,
        borderColor: Colors.redAccent,
        dateText: Text(
          d.toString(),
          style: TextStyle(fontSize: itemSize.height / 4, color: Colors.white),
        ),
        beneathMarks: [
          Text(selected ? "今天" : '',
              style:
                  TextStyle(fontSize: itemSize.height / 6, color: Colors.white))
        ],
        upperMarks: [
          0,
          1,
          2,
        ]
            .map((e) => Icon(
                  Icons.heart_broken_sharp,
                  size: itemSize.width / 3.5,
                ))
            .toList(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double calendarHeight = itemSize.height * 6;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;

    return Stack(children: [
      //先渲染calendar
      Positioned(
        top: titleHeight + top + calendarOffset,
        child: Container(
          decoration: BoxDecoration(color: Colors.greenAccent.withOpacity(0.7)),
          height: calendarHeight,
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: GridView(
              children: _getDayItems(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
            ),
          ),
        ),
      ),
      //再渲染form
      Positioned(
        top: titleHeight + top + calendarHeight + formOffset,
        child: GestureDetector(
            onTapDown: (TapDownDetails details) {
              debugPrint("tap global ${details.globalPosition}");
            },
            onVerticalDragEnd: (DragEndDetails details) {
              setState(() {
                calendarOffset = 0;
                formOffset = 0;
              });
            },
            onVerticalDragStart: (DragStartDetails details) {
              final itemPos = _getItemLocalUpConstraint(context, selectedDay);

              setState(() {
                moveRangeY = itemPos.dy - calendarTop;
                // debugPrint("init item pos: $itemPos");
                // debugPrint("init move range: $moveRangeY");
              });
            },
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                final moveSpeed = 4.5;
                final offset = details.delta.dy <=0 ?-moveSpeed: moveSpeed ;

                if (calendarOffset.abs() >= moveRangeY) {
                  calendarOffset = -moveRangeY;
                } else {
                  calendarOffset += offset;
                }

                formOffset += offset;
                // debugPrint("item offset left: ${realOffset}");
                // debugPrint("DragUpdateDetails: ${offset}");
                // debugPrint("move range: ${moveRangeY}");
                debugPrint("drag delta: ${details.delta.dy}");
                debugPrint("drag local position: ${details.localPosition}");
                // debugPrint("up constraint local: $localSelectedItemPos");
              });
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.redAccent),
              width: MediaQuery.sizeOf(context).width,
              height: 500,
              child: FlutterLogo(),
            )),
      ),
      //最后渲染title，不被遮挡
      Positioned(
        top: top,
        child: Container(
          height: titleHeight,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(color: Colors.yellow),
        ),
      ),
    ]);
  }
}
