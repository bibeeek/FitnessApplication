import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'First_AppPage.dart';
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
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(137, 245, 228, 0.8,),
              primary: Color.fromRGBO(80, 212, 225, 1.0,) ),


        fontFamily: 'Lora',

        textTheme:TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black87,
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
home: StartUpPage(),
    );
  }
}
