import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'First_AppPage.dart';
import 'SplashScreen.dart';
import 'firebase_options.dart';



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
    return MaterialApp(
      theme: ThemeData(

          colorScheme: ColorScheme.dark(),




        //fontFamily: 'Lora',

        textTheme:TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.normal
          ),

          bodyLarge: TextStyle(
              color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),

        )

      ),
debugShowCheckedModeBanner: false,
home: SplashScreen(),
    );
  }
}
