import 'package:flutter/material.dart';

import 'LoginPage.dart';

class StartUpPage extends StatelessWidget {
  const StartUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyanAccent.shade100,Colors.white],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [

              SizedBox(height: 20),
              Center(
                child: Text(
                  "ActiveCal",
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Spacer(flex: 7),

              TextButton(onPressed: (){
                print("Button Pressed");

                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginRegistrationPage()));



              }, child: Container(
                width: double.infinity,
                height: 60,


                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.green], // Define your colors
                    begin: Alignment.centerLeft,         // Start point
                    end: Alignment.centerRight,         // End point
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text("Start Your Fitness Journey", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),


              ),
              ),
              Spacer(flex: 1,)

            ],
          ),
        ),
      ),
    );
  }
}