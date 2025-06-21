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
      backgroundColor: Colors.blueGrey[50],
      body: Container(
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [



            Center(
              child: Image.asset("assets/girl.png",width: media.width,fit: BoxFit.fitWidth,),
            ),
            SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(

                alignment: Alignment.centerLeft,
                child: Text('"Fuel Your Journey,\n Track Every Bite,\n Crush Every Rep"',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 130, 83, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text( " Your fitness companion for smarter nutrition\n and stronger results. ",
                style: TextStyle(color: Colors.grey[700],  fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Spacer(flex: 1),

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