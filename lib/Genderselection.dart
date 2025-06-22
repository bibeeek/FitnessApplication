import 'package:flutter/material.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'Ageasker.dart';

class GenderSelectionPage extends StatefulWidget {
  @override
  _GenderSelectionPageState createState() => _GenderSelectionPageState();
}

class _GenderSelectionPageState extends State<GenderSelectionPage> {

  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {

    double progress=0.2;


    return Scaffold(
      backgroundColor: Colors.blueGrey[50],


      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor:  Color.fromRGBO(0, 130, 83, 1),
        title:  Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset("assets/AgeGenderImages/finallogo.png",height: 230,width: 450),
        ),
        centerTitle: true,

      ),

      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Spacer(flex: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Select Your Gender',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.black54)),
                  IconButton(onPressed: (){
                    showDialog(context: context, builder: (context){

                      return AlertDialog(
                        backgroundColor: Colors.blueGrey[50] ,
                        title: Text('Help'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        titleTextStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black54),
                        content: Text(
                          "We ask for your gender to personalize your experience and tailor workout recommendations accordingly.",
                          style: TextStyle(color: Colors.black54,fontSize: 12),
                        ),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text('Close')),
                        ],
                      );
                    },
                    );
                  },
                      icon: Icon(Icons.help_outline_sharp,size: 30,color:Colors.black54 ,)
                  ),
                ],
              ),

              Spacer(flex: 1,),
              genderPick(),


              SizedBox(height: 50,),


              Spacer(flex: 3,),

              ElevatedButton(onPressed: (){

                  if(_selectedGender==null){

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Select Gender',style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),),
                      backgroundColor: Colors.blueGrey[50],
                    ),
                    );
                  }
                  else{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AgePicker()));
                  }
                },

                    style: ElevatedButton.styleFrom(

                      backgroundColor:  Color.fromRGBO(0, 130, 83, 1),
                      shadowColor:  Color.fromRGBO(0, 130, 83, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      minimumSize: Size(200, 50),
                    ),
                    child:
                    Text('Next',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),)
                ),





            ],

          ),




        ),
      ),
      bottomNavigationBar:   Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StepProgressIndicator(
            totalSteps: 4,
            currentStep: (progress * 4).round(), // convert to step count
            size: 10,
            padding: 2,
            selectedColor:Color.fromRGBO(0, 130, 83, 1),
            unselectedColor: Colors.grey.shade300,
            roundedEdges: Radius.circular(8),

            progressDirection: TextDirection.ltr,

          ),
        ),
      ),

    );
  }


  Widget genderPick() {

    return Container(

      alignment: Alignment.center,
      child: GenderPickerWithImage(onChanged:(Gender? gender) {

        setState(() {
          _selectedGender = gender;

        });
        print(_selectedGender);

      },
        showOtherGender: false,
        selectedGender: _selectedGender ,
        selectedGenderTextStyle: TextStyle(

          color: _selectedGender == Gender.Male ? Colors.blueAccent : Colors.pink,
          fontSize: 20,
        ),
        unSelectedGenderTextStyle: TextStyle(
          color: Colors.grey,
          fontSize: 20,
        ),


        size: 90,
        opacityOfGradient: 0.1,
        padding: const EdgeInsets.all(3),
        animationDuration: Duration(milliseconds: 300),
        isCircular: false,


      ),

    );
  }
}

