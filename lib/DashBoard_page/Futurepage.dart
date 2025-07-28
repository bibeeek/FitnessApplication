import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/LoginRegs/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FirstPage/First_AppPage.dart';
import '../FoodApi/food-providerclass/foodprovider.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
            child: Text("Logout"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure you want to log out?"),
        content: const Text("You'll lose your progress."),
        actions: [
          TextButton(
            onPressed: () async {
              // Sign out from Firebase
              await FirebaseAuth.instance.signOut();

              // Clear shared preferences
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              // Reset provider data
              Provider.of<MealProvider>(context, listen: false).resetMeals();

              // Navigate to the startup page
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginPaage()),
                    (route) => false,
              );
            },
            child: const Text(
              "Yes",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: const Text(
              "No",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
