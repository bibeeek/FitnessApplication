import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../First_AppPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: AnimatedSplashScreen(splash: SizedBox.expand(
      child: Image.asset(
        "assets/img.png",
        fit: BoxFit.cover, // or BoxFit.fill, BoxFit.fitWidth, etc.
      ),
    ),

    splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.topToBottom,


        nextScreen: StartUpPage(),

        duration:3000,

        backgroundColor: Color.fromRGBO(0, 130, 83, 1),
      
      ),
    );
    
  }
}
