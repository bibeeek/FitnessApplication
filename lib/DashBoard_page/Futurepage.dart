import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../FirstPage/First_AppPage.dart';
import '../LoginRegs/LoginPage.dart';
import '../FoodApi/food-providerclass/foodprovider.dart';

class BmiResultPage extends StatelessWidget {
  final String sex;
  final int age;
  final double height;
  final double currentWeight;
  final String activityLevel;
  final String goal;
  final double? targetWeight;
  final double? goalAchieveTime;

  BmiResultPage({
    required this.sex,
    required this.age,
    required this.height,
    required this.currentWeight,
    required this.activityLevel,
    required this.goal,
    this.targetWeight,
    this.goalAchieveTime,
  });

  double calculateBMI(double weightKg, double heightCm) {
    double heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI(currentWeight, height);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("BMI Result"),
        titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(0, 130, 83, 1),
        toolbarHeight: 70,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// BMI + Info Card
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // BMI Row
                        Row(
                          children: [
                            Text(
                              "Your BMI:",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.help_outline),
                              onPressed: () => _showBMIDefinition(context),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                bmi.toStringAsFixed(1),
                                style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal),
                              ),
                              SizedBox(height: 8),
                              Text(
                                _bmiCategory(bmi),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),

                        Text(
                          "Your Info:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 12),

                        Wrap(
                          spacing: 10,
                          runSpacing: 12,
                          children: [
                            _buildInfoBox("Age", "$age"),
                            _buildInfoBox("Weight",
                                "${currentWeight.toStringAsFixed(1)} kg"),
                            if (goal.toLowerCase() == "gain" ||
                                goal.toLowerCase() == "lose")
                              _buildInfoBox("Target",
                                  "${targetWeight?.toStringAsFixed(1)} kg"),
                            _buildInfoBox("Goal", goal.capitalize()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 5),


                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.info_outline, color: Colors.teal),
                    title: Text(
                      "About Us",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AboutUsPage()),
                      );
                    },
                  ),
                ),

                SizedBox(height: 20),

                /// Logout button below the card
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => _showLogoutConfirmationDialog(context),
                  icon: Icon(Icons.logout),
                  label: Text("Logout"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(String label, String value) {
    return Container(
      width: 140,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  String _bmiCategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 24.9) return "Normal weight";
    if (bmi < 29.9) return "Overweight";
    return "Obese";
  }

  void _showBMIDefinition(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("What is BMI?"),
        content: Text(
          "BMI (Body Mass Index) is a simple index of weight-for-height used to classify underweight, normal weight, overweight, and obesity in adults.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Got it"),
          ),
        ],
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
              await FirebaseAuth.instance.signOut();
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Provider.of<MealProvider>(context, listen: false).resetMeals();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginPaage()),
                    (route) => false,
              );
            },
            child: const Text("Yes", style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
        ],
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        backgroundColor: Color.fromRGBO(0, 130, 83, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "This fitness app helps users track their calories, set personalized goals, "
              "and monitor their BMI for healthier living.\n\n"
              "It aims to provide an easy and effective way to maintain a healthy lifestyle.",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
