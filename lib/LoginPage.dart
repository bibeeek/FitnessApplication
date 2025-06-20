import 'package:fitnessapp/First_AppPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'Registration_Page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(	253,253,253 ,1.0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image.asset(
                "assets/Frame_eat.png",
                fit: BoxFit.fitWidth,
                height: 499,
                width: double.infinity,
                alignment: Alignment.topCenter,
              ),
              SizedBox(height: 20),
              Text(
                "Enter Valid Email & Password To Login",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),

              // Email TextField
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    prefixIcon: Icon(Icons.email, color: Colors.black),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Enter your email",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              // Password TextField
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black54,
                        size: 20,
                      ),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.black),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Enter your password",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),


              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:5 ,horizontal: 80),
                child: ElevatedButton(onPressed: (){

                },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      elevation: 5,
                      backgroundColor:  Color.fromRGBO(0, 130, 83, 1),
                      side: BorderSide(
                        color:  Color.fromRGBO(0, 130, 83, 1),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )
                  ),

                  child: Text("Login",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),),
              ),
              SizedBox(height: 18,),


              RichText(text: TextSpan(
                children: [
                  TextSpan(text: 'Don\'t have an account? ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black54)),

                  TextSpan(text: 'Sign Up',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.blue.shade900)
                      ,recognizer: TapGestureRecognizer()..onTap = (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                      }
                  ),

                ],
              ))
            ],

          ),
        ),
      ),

    );
  }
}