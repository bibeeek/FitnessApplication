import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  bool  isPasswordVisible = false;
  @override


  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:  Color.fromRGBO(0, 130, 83, 1),



      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // child: Image.asset("assets/gym1.png",width: double.infinity,height: 600,),
                ),

                SizedBox(height: 20,),

                // Text("Sign Up",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black)),

                SizedBox(height: 40,),

                Text("Enter Valid Email & Password" ,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black54)),
                SizedBox(height: 20,),




                TextField(
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black54),

                  decoration: InputDecoration(

                    prefixIcon: Icon(Icons.email,color: Colors.black54,),
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.grey),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Email",

                    hintStyle: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),

                    ),
                  ),

                ),

                SizedBox(height: 20,),

                TextField(
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black54),
                  obscureText: !isPasswordVisible,

                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: (){

                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });

                    }, icon: Icon(Icons.remove_red_eye,color: Colors.black54,size: 20,)),

                    prefixIcon: Icon(Icons.password,color: Colors.black54,),
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.grey),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Password",

                    hintStyle: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),

                    ),
                  ),
                ),

                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical:5 ,horizontal: 80),
                  child: ElevatedButton(onPressed: (){

                  },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        elevation: 5,
                        backgroundColor: Colors.blue,
                        side: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                    ),

                    child: Text("Register",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),),
                ),
                SizedBox(height: 15,),


                RichText(text: TextSpan(
                  children: [
                    TextSpan(text: 'Already have an account? ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black54)),

                    TextSpan(text: 'Sign In',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.blue.shade900)
                        ,recognizer: TapGestureRecognizer()..onTap = (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        }
                    ),

                  ],
                ))
              ],

            ),
          ),
        ),
      ),

    );
  }
}
