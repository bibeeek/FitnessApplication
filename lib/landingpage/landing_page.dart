import 'package:fitnessapp/DashBoard_page/dashboard.dart';
import 'package:fitnessapp/FirstPage/Onboardingscreen.dart';
import 'package:fitnessapp/Inputs_wt_age_sex/Genderselection.dart';
import 'package:fitnessapp/LoginRegs/LoginPage.dart';
import 'package:fitnessapp/provider_classes/Inputs_provider/healthdataprovider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../DashBoard_page/homepage.dart';
import '../FoodApi/food-providerclass/foodprovider.dart';
import '../Shared_pref_help/load_provider_from_pref.dart';
import '../Shared_pref_help/shared_prefs.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    _decideNextScreen();
  }

  Future<void> _decideNextScreen() async {
    final user = FirebaseAuth.instance.currentUser;
    final hasUserData = await SharedPrefsHelper.hasUserData();

    final mealProvider = Provider.of<MealProvider>(context, listen: false);
    final healthProvider = Provider.of<HealthLevelProvider>(context, listen: false);

    await mealProvider.loadMealsFromPrefs();
    await healthProvider.loadWaterFromPrefs();

    if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnboardingScreen()),
      );
    } else if (hasUserData) {
      await loadSavedDataIntoProviders(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainDashboardWithTabs()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => GenderSelectionPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
