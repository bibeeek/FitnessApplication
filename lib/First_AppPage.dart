import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'LoginPage.dart';

class StartUpPage extends StatefulWidget {
  const StartUpPage({super.key});

  @override
  State<StartUpPage> createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  @override
  Widget build(BuildContext context) {

    var media= MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(),
        child: Column(
          children: [



            Center(
              child: Image.asset("assets/girl.png",width: media.width,fit: BoxFit.fitWidth,),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text("Fuel Your Journey Track Every Bite, Crush Every Rep",
                style: TextStyle(color: Colors.black , fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text( "Your fitness companion for smarter nutrition and stronger results.",
                style: TextStyle(color: Colors.grey , fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Spacer(flex: 7),

            TextButton(onPressed: (){
              print("Button Pressed");

              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));



            }, child: Container(
              width: double.infinity,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:  Color.fromRGBO(0, 130, 83, 1),
                borderRadius: BorderRadius.circular(30),
              ),

              child: Text("Get Started", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),


            ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}