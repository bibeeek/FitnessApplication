import 'package:fitnessapp/DashBoard_page/Futurepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../FoodApi/food-providerclass/foodprovider.dart';
import '../provider_classes/Inputs_provider/Genderselection_provider.dart';
import '../provider_classes/Inputs_provider/activitylevel_provider.dart';
import '../provider_classes/Inputs_provider/all_inputs_provider.dart';
import '../provider_classes/Inputs_provider/goal_level_provider.dart';
import 'DashBoard.dart';
import 'foodlogpage.dart'; // Your existing dashboard page


class MainDashboardWithTabs extends StatefulWidget {
  const MainDashboardWithTabs({Key? key}) : super(key: key);

  @override
  State<MainDashboardWithTabs> createState() => _MainDashboardWithTabsState();

}


class _MainDashboardWithTabsState extends State<MainDashboardWithTabs> {
  int _selectedIndex = 0;


  List<Widget> getPages(BuildContext context) {
    final inputProvider = Provider.of<AllInputsProvider>(context);
    final goalProvider = Provider.of<GoalSelectionProvider>(context);
    final activityProvider = Provider.of<ActivityLevelProvider>(context);
    final genderProv = Provider.of<genderProvider>(context);

    return [
      DashBoard(),
      FoodLogPage(),
      BmiResultPage(
        sex: genderProv.getGender.toString(),
        age: inputProvider.getSelectedAge,
        height: inputProvider.getCurrentHeight,
        currentWeight: inputProvider.getCurrentWeight,
        activityLevel: activityProvider.getSelectedLevel.toString(),
        goal: goalProvider.getSelectedGoal.toString(),
        targetWeight: goalProvider.getSelectedGoal == 'gain' || goalProvider.getSelectedGoal == 'lose'
            ? inputProvider.getTargetWeight
            : null,
        goalAchieveTime: goalProvider.getSelectedGoal == 'gain' || goalProvider.getSelectedGoal == 'lose'
            ? inputProvider.getGoalAchieveTime
            : null,
      ),
    ];
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPages(context)[_selectedIndex],

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
