import 'package:firebase_core/firebase_core.dart';
import 'package:fitnessapp/Activity_level/activity_level.dart';
import 'package:fitnessapp/DashBoard_page/dashboard.dart';
import 'package:fitnessapp/Inputs_wt_age_sex/Current_weight.dart';
import 'package:fitnessapp/Inputs_wt_age_sex/Goal_Selection.dart';
import 'package:fitnessapp/Inputs_wt_age_sex/goal_Achieve_time.dart';
import 'package:fitnessapp/LoginRegs/Registration_Page.dart';
import 'package:fitnessapp/provider_classes/Inputs_provider/Genderselection_provider.dart';
import 'package:fitnessapp/provider_classes/Inputs_provider/activitylevel_provider.dart';
import 'package:fitnessapp/provider_classes/Inputs_provider/all_inputs_provider.dart';
import 'package:fitnessapp/provider_classes/Inputs_provider/goal_level_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../FirstPage/First_AppPage.dart';
import '../FirstPage/Animation/SplashScreen.dart';
import '../Inputs_wt_age_sex/Genderselection.dart';
import '../firebase_options.dart';
import '../landingpage/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(FitnessApplication());
}

class FitnessApplication extends StatelessWidget {
  const FitnessApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(


      providers: [
        ChangeNotifierProvider(create: (_) => genderProvider()),
        ChangeNotifierProvider(create: (_) => AllInputsProvider()),
        ChangeNotifierProvider(create: (_) => GoalSelectionProvider()),
        ChangeNotifierProvider(create: (_) => ActivityLevelProvider()),
      ],
      child: MaterialApp(



        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}