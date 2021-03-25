import 'package:be_healthy_delivery_app/screens/dashboard/setting_screen.dart';
import 'package:be_healthy_delivery_app/screens/placeholder_screen.dart';
import 'package:be_healthy_delivery_app/utils/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'dashboard/home_screen.dart';
import 'dashboard/profile_screen.dart';

class DashboardScreen extends StatefulWidget {


  final int currentIndex;
  DashboardScreen({this.currentIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    PlaceholderScreen(color: Colors.red,),
    ProfileScreen(),
    SettingScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   _currentIndex = widget.currentIndex;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _children[_currentIndex]
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        color: kOrangeMaterialColor,
        buttonBackgroundColor: kOrangeMaterialColor,
        backgroundColor: kWhiteColor,
        items: [
          Icon(Icons.home, color: kWhiteColor,),
          Icon(Icons.delivery_dining, color: kWhiteColor),
          // Icon(Icons.favorite_border, size: 30, color: kOrangeMaterialColor),
          Icon(Icons.account_circle, color: kWhiteColor),
          Icon(Icons.settings, color: kWhiteColor)
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  void _onTapItem(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
