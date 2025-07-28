import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/FirstPage/First_AppPage.dart';
import 'package:fitnessapp/Inputs_wt_age_sex/Genderselection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'Registration_Page.dart';

class LoginPaage extends StatefulWidget {
  const LoginPaage({super.key});

  @override
  State<LoginPaage> createState() => _LoginPaageState();
}

class _LoginPaageState extends State<LoginPaage> {
  bool isPasswordVisible = false;

  var emailController= TextEditingController();
  var passwordController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image.asset(
                "assets/try2.png",
                height: MediaQuery.of(context).size.height * 0.50, //
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 10,),

              Text(
                "Enter Valid Email & Password To Login",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
           SizedBox(height: 5),

              // Email TextField
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(

                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],


                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.email, color: Colors.black),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Enter your email",
                    hintStyle: TextStyle(
                      fontSize: 11,
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

              //SizedBox(height: 10),

              // Password TextField
              Padding(


                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: passwordController,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
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
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Enter your password",
                    hintStyle: TextStyle(
                      fontSize: 11,
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




              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:5 ,horizontal: 80),
                child: ElevatedButton(onPressed: () async {

                  String email=emailController.text.trim();
                  String pass=passwordController.text.trim();

                  if(email.isEmpty){

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Email")));
                  }
                  else if(pass.isEmpty){

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Password")));
                  }

                  else{


                    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass).then((value) {

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful")));
                      debugPrint("Login Successful");

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => GenderSelectionPage()),
                            (route) => false, // removes all previous routes
                      );


                    }).onError((error, stackTrace) {

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));

                    });

                  }


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
              ),
              ),

            ],

          ),
        ),
      ),

    );
  }
}