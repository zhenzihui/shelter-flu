import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/strings.dart';
import '../../model/local.dart';
import '../../widget/bottomNavBar.dart';
import '../statistics_page/widget.dart';
import 'logic.dart';
//登录后的主页 底部导航
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());

    var bottomTabBarList = [
    BottomTabBarData("assets/images/tab_folder.png", tabHome.tr),
    BottomTabBarData("assets/images/tab_conn.png", tabConn.tr),
    BottomTabBarData("assets/images/tab_radar.png", tabRadar.tr),
    ];

    return Scaffold(
      body: StatisticsWidget(dataList: [
        PieData(1, "p1", Colors.red),
        PieData(2, "p2", Colors.green),
        PieData(5, "p3", Colors.cyanAccent),
        PieData(6, "p4", Colors.blueAccent),
        PieData(3, "p5", Colors.amberAccent),
      ]),
      bottomNavigationBar: BottomNav(bottomTabBarList: bottomTabBarList, initialIndex: 0,),
    );
  }
}
