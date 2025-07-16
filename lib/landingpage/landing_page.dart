import 'package:fitnessapp/DashBoard_page/dashboard.dart';
import 'package:fitnessapp/DashBoard_page/homepage.dart';
import 'package:fitnessapp/FirstPage/First_AppPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../FoodApi/food-providerclass/foodprovider.dart';
import '../Inputs_wt_age_sex/Genderselection.dart';
import '../LoginRegs/LoginPage.dart' show LoginPage;
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

    if (user == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => StartUpPage()));
    } else if (hasUserData) {

      await loadSavedDataIntoProviders(context);
      await Provider.of<MealProvider>(context, listen: false).loadMealsFromPrefs();

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainDashboardWithTabs()));
    } else {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => GenderSelectionPage()));
    }
    await Provider.of<MealProvider>(context, listen: false).loadMealsFromPrefs();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainDashboardWithTabs()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}


