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
    Center(child: Text('Coming Soon')), // Placeholder page
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Food Log'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}
