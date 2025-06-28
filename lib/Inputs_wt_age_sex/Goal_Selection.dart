import 'package:fitnessapp/Activity_level/activity_level.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../provider_classes/Inputs_provider/goal_level_provider.dart';

class GoalSelection extends StatefulWidget {
  const GoalSelection({super.key});

  @override
  State<GoalSelection> createState() => _GoalSelectionState();
}

class _GoalSelectionState extends State<GoalSelection> {



  Color mainColor=Color.fromRGBO(0, 130, 83, 1);
  TextStyle mainTextStyle=TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white);

  Image slimimg=Image.asset('assets/GoalSelectionImg/slim.png',height: 30,width: 40);
  Image gainimg=Image.asset('assets/GoalSelectionImg/gain-weight.png',height: 40,width: 40);
  Image maintainimg=Image.asset('assets/GoalSelectionImg/balance.png',height: 40,width: 40);
  Image fitimg=Image.asset('assets/GoalSelectionImg/muscular.png',height: 40,width: 40);
  Image trackimg=Image.asset('assets/GoalSelectionImg/calories.png',height: 40,width: 40);
  Image eathealthyimg=Image.asset('assets/GoalSelectionImg/diet.png',height: 40,width: 40);

  @override
  Widget build(BuildContext context) {
    double progress=0.8;

    return Scaffold(

      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor:  mainColor,
        title:  Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset("assets/AgeGenderImages/finallogo.png",height: 190,width: 450),
        ),
        centerTitle: true,
      ),

      body: Consumer<GoalSelectionProvider>(builder: (context,value,child){

        return Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SizedBox(height:  MediaQuery.of(context).size.height*0.03,),
            Text("Select Your Goal",style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),

            SizedBox(height:  MediaQuery.of(context).size.height*0.01,),

            Column(
              children: [
                SizedBox(
                  height:  MediaQuery.of(context).size.height*0.6,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: false,
                    padding: EdgeInsets.all(20),
                    children: [

                      //Lose Weight
                      Card(

                        color: mainColor,
                        child: ListTile(


                          onTap: (){
                            value.setSelectedGoal('lose');
                          },
                          title: Text("Lose Weight"),
                          titleTextStyle:mainTextStyle,
                          leading: slimimg,
                          trailing: Radio(
                              value: 'lose',
                              groupValue: value.getSelectedGoal,
                              onChanged:(newValue){

                                value.setSelectedGoal(newValue);
                              }
                          ),
                        ),
                      ),

                      SizedBox(height: 14,),
                      //Gain Weight
                      Card(
                        color: mainColor,
                        child: ListTile(

                          onTap: (){
                            value.setSelectedGoal('gain');
                          },
                          title: Text("Gain Weight"),
                          titleTextStyle:mainTextStyle,
                          leading: gainimg,
                          trailing: Radio(
                              value: 'gain',
                              groupValue: value.getSelectedGoal,
                              onChanged:(newvalue){
                              value.setSelectedGoal(newvalue);
                              }
                          ),
                        ),
                      ),

                      SizedBox(height: 14,),

                      //Maintain Weight
                      Card(
                        color: mainColor,
                        child: ListTile(

                          onTap: (){
                            value.setSelectedGoal('maintain');
                          },
                          title: Text("Maintain Weight"),
                          titleTextStyle:mainTextStyle,
                          leading: maintainimg,
                          trailing: Radio(
                              value: 'maintain',
                              groupValue: value.getSelectedGoal,
                              onChanged:(newvalue){
                                value.setSelectedGoal(newvalue);
                              }
                          ),
                        ),
                      ),

                      SizedBox(height: 14,),

                      //StayFit

                      Card(
                        color: mainColor,
                        child: ListTile(

                          onTap: (){
                            value.setSelectedGoal('fit');
                          },
                          title: Text("Stay Fit"),
                          titleTextStyle:mainTextStyle,
                          leading: fitimg,
                          trailing: Radio(
                              value: 'fit',
                              groupValue: value.getSelectedGoal,
                              onChanged:(newvalue){
                                value.setSelectedGoal(newvalue);
                              }
                          ),
                        ),
                      ),
                      SizedBox(height: 14,),

                      //Track Calories
                      Card(
                        color: mainColor,
                        child: ListTile(
                          onTap: (){
                            value.setSelectedGoal('track');
                          },
                          title: Text("Track Calories"),
                          titleTextStyle:mainTextStyle,
                          leading: trackimg,
                          trailing: Radio(
                              value: 'track',
                              groupValue: value.getSelectedGoal,
                              onChanged:(newvalue){
                                value.setSelectedGoal(newvalue);
                              }
                          ),
                        ),
                      ),
                      SizedBox(height: 14,),
                      //Eat Healthier

                      Card(
                        color: mainColor,
                        child: ListTile(
                          onTap: (){
                            value.setSelectedGoal('eat');
                          },
                          title: Text("Eat Healthier"),
                          titleTextStyle:mainTextStyle,
                          leading: eathealthyimg,
                          trailing: Radio(

                              value: 'eat',
                              groupValue: value.getSelectedGoal,
                              onChanged:(newvalue){
                                value.setSelectedGoal(newvalue);
                              }
                          ),
                        ),
                      ),

                    ],

                  ),
                ),
              ],
            ),



            if(value.getSelectedGoal!=null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(onPressed: (){


                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ActivityLevel()));
                },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                    elevation: 2,
                    backgroundColor: mainColor,
                    shadowColor:  mainColor,

                  ),
                  child: Text("Continue",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),
                ),
              ),
            Spacer(flex: 1,),
          ],
        );


      }),

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
}
