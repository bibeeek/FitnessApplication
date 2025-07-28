import 'package:fitnessapp/DashBoard_page/Futurepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../FoodApi/food-providerclass/foodprovider.dart';
import 'DashBoard.dart';
import 'foodlogpage.dart'; // Your existing dashboard page


class MainDashboardWithTabs extends StatefulWidget {
  const MainDashboardWithTabs({Key? key}) : super(key: key);

  @override
  State<MainDashboardWithTabs> createState() => _MainDashboardWithTabsState();

}


class _MainDashboardWithTabsState extends State<MainDashboardWithTabs> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    DashBoard(),         // Your existing dashboard
    FoodLogPage(),       // New food log page
    MorePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:  Color.fromRGBO(0, 130, 83, 1),
        selectedLabelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,

        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.white,), label:'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood,color: Colors.white,), label: 'Food Log'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz,color: Colors.white,), label: 'More'),
        ],
      ),
    );
  }
}
