import 'package:firebase_core/firebase_core.dart';
import 'package:fitnessapp/DashBoard_page/dashboard.dart';
import 'package:fitnessapp/DashBoard_page/homepage.dart';
import 'package:fitnessapp/landingpage/landing_page.dart';

import 'package:fitnessapp/provider_classes/Inputs_provider/Genderselection_provider.dart';
import 'package:fitnessapp/provider_classes/Inputs_provider/activitylevel_provider.dart';
import 'package:fitnessapp/provider_classes/Inputs_provider/all_inputs_provider.dart';
import 'package:fitnessapp/provider_classes/Inputs_provider/goal_level_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../FirstPage/Animation/SplashScreen.dart';
import '../FoodApi/food-providerclass/foodprovider.dart';
import '../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(FitnessApplication());
}

class FitnessApplication extends StatelessWidget {
  const FitnessApplication(
      {
    Key? key
      }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(


      providers: [
        ChangeNotifierProvider(create: (_) => genderProvider()),
        ChangeNotifierProvider(create: (_) => AllInputsProvider()),
        ChangeNotifierProvider(create: (_) => GoalSelectionProvider()),
        ChangeNotifierProvider(create: (_) => ActivityLevelProvider()),
        ChangeNotifierProvider(create: (_) => MealProvider()),

      ],
      child: MaterialApp(



        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
  }
}