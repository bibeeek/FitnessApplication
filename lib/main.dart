import 'package:firebase_core/firebase_core.dart';
import 'package:fitnessapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


import 'Firebase/firebase_options.dart';
import 'features/screens/onboarding/FirstPage/Animation/SplashScreen.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

  runApp(const FitnessApplication());
}

class FitnessApplication extends StatelessWidget {
  const FitnessApplication({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     themeMode: ThemeMode.system,
  theme: TAppTheme.lightTheme,
  home: const SplashScreen(),
debugShowCheckedModeBanner: false,

    );
  }
}
