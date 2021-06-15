import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:interview_project/module/home/home_page.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'setting/setting_page.dart';

class MyNavPage extends StatefulWidget {
  const MyNavPage({Key? key}) : super(key: key);

  @override
  _MyNavPageState createState() => _MyNavPageState();
}

class _MyNavPageState extends State<MyNavPage> {
  int _index = 0;
  final navItems = [];

  @override
  void initState() {
    super.initState();
    navItems
      ..add(NavItem(title: tr('Home'), icon: 'lib/resources/assets/bottom/store.svg'))
      ..add(NavItem(title: tr('Setting'), icon: 'lib/resources/assets/bottom/settings.svg'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigateToScreen(_index),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (index) => setState(() => _index = index),
        items: _listNavItem(),
      ),
    );
  }

  List<BottomNavigationBarItem> _listNavItem() {
    final listWidget = <BottomNavigationBarItem>[];
    for (var i = 0; i < navItems.length; i++) {
      listWidget.add(_buildNavItem(navItems[i], i));
    }
    return listWidget;
  }

  BottomNavigationBarItem _buildNavItem(NavItem item, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        item.icon,
        width: 35,
        height: 35,
      ),
      // ignore: deprecated_member_use
      title: Text(
        item.title,
        style: TextStyle(
          color: _index == index ? AppColor.primaryColor : AppColor.textPrimaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _navigateToScreen(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return SettingPage();
      default:
        return HomePage();
    }
  }
}

class NavItem {
  NavItem({required this.title, required this.icon});

  final String title;
  final String icon;
}
