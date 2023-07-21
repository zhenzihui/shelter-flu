import 'package:flutter/material.dart';
import 'package:shelter_client/widget/calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalendarPageState();
  }

}

class CalendarPageState extends State<CalendarPage> {

  @override
  Widget build(BuildContext context) {
    var size = Size(60,60);

    return Scaffold(body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: 50,
            ),
            Expanded(child: MonthView()),
          ],
        )));
  }

}