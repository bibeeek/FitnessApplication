import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/FirstPage/First_AppPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../LoginRegs/LoginPage.dart';
import '../provider_classes/Inputs_provider/Genderselection_provider.dart';
import '../provider_classes/Inputs_provider/activitylevel_provider.dart';
import '../provider_classes/Inputs_provider/all_inputs_provider.dart';
import '../provider_classes/Inputs_provider/goal_level_provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    final inputProvider = Provider.of<AllInputsProvider>(context);
    final goalProvider = Provider.of<GoalSelectionProvider>(context);
    final activityProvider = Provider.of<ActivityLevelProvider>(context);
    final genderProv = Provider.of<genderProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Gender: ${genderProv.getGender}"),
            Text("Age: ${inputProvider.getSelectedAge}"),
            Text("Goal: ${goalProvider.getSelectedGoal}"),
            Text("Activity Level: ${activityProvider.getSelectedLevel}"),
            Text("Current Weight: ${inputProvider.getCurrentWeight}"),
            Text("Target Weight: ${inputProvider.getTargetWeight}"),
            Text("Goal Time: ${inputProvider.getGoalAchieveTime} weeks"),
            Text("Height: ${inputProvider.getCurrentHeight} cm"),

            ElevatedButton(
              onPressed: () async {
                // 1. Sign out the user from Firebase
                await FirebaseAuth.instance.signOut();

                // 2. Clear all shared preferences
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear(); // This clears everything stored


                // Provider.of<AllInputsProvider>(context, listen: false).reset();
                Provider.of<GoalSelectionProvider>(context, listen: false).reset();
                Provider.of<ActivityLevelProvider>(context, listen: false).reset();
                Provider.of<genderProvider>(context, listen: false).reset();

                // 3. Navigate to LoginPage and remove all routes
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => StartUpPage()),
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),




          ],
        ),
      ),
    );
  }
}
