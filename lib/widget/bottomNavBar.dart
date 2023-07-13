import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../model/local.dart';

//底部导航
class BottomNav extends StatefulWidget {
  final List<BottomTabBarData> bottomTabBarList;
  final int initialIndex;
  final ValueChanged<int>? onTap;

  const BottomNav(
      {super.key,
      required this.bottomTabBarList,
      required this.initialIndex,
      this.onTap});

  @override
  State<StatefulWidget> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: widget.bottomTabBarList
          .map((data) => BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(data.src)), label: data.label))
          .toList(),
      currentIndex: _selectedIndex,
      selectedItemColor: scaffoldBg,
      onTap: (index) => setState(() {
        _selectedIndex = index;
        widget.onTap?.call(index);
      }),
    );
  }
}
