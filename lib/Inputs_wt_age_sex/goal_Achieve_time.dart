import 'package:fitnessapp/Inputs_wt_age_sex/Height_input.dart';
import 'package:fitnessapp/LoginRegs/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider_classes/Inputs_provider/all_inputs_provider.dart';
import 'Current_weight.dart';
import 'TargetWeight.dart' show Targetweight;

class GoalAchieveTime extends StatefulWidget {
  const GoalAchieveTime({super.key});

  @override
  State<GoalAchieveTime> createState() => _GoalAchieveTimeState();
}

class _GoalAchieveTimeState extends State<GoalAchieveTime> {



  @override
  Widget build(BuildContext context) {


    final weight= Provider.of<AllInputsProvider>(context);


    return Scaffold(

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
      backgroundColor:  Colors.blueGrey[50],


      body: Column(

        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.02,),

          Align(
              alignment: Alignment.center,
              child: Text(" How Much Weight\n You Wanna lose or gain \n per week?", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),)),

          SizedBox(height: MediaQuery.of(context).size.height*0.2,),

          Slider(

              min: 0.25,
              max:1.0,
              value: weight.getGoalAchieveTime,
              divisions: 3,
              label:  weight.getGoalAchieveTime.toString(),
              thumbColor: Colors.blueAccent,

              activeColor: Colors.green,
              inactiveColor: Colors.grey,
              onChanged: (value) {

                weight.setGoalAchieveTime(value);

              }
          ),
          Text("${weight.getGoalAchieveTime} kg per week",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),

          SizedBox(height: MediaQuery.of(context).size.height*0.1,),


          ElevatedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CurrentHeight( )));
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
              Text('Next',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),


          ),
        ],
      ),








    );
  }
}
