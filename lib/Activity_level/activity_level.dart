import 'package:fitnessapp/Inputs_wt_age_sex/Current_weight.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ActivityLevel extends StatefulWidget {
  const ActivityLevel({super.key});

  @override
  State<ActivityLevel> createState() => _ActivityLevelState();
}

class _ActivityLevelState extends State<ActivityLevel> {

  double progress=0.9;

  String? selectedLevel;


  Color mainColor=Color.fromRGBO(0, 130, 83, 1);
  TextStyle subTextStyle=TextStyle(fontSize: 12,color: Colors.white);
  TextStyle mainTextStyle=TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white);

  Image veryactiveimg=Image.asset('assets/ActivityLevel/weightlifter.png',height: 60,width: 60);
  Image moderatelyactiveimg=Image.asset('assets/ActivityLevel/training.png',height: 60,width: 60);
  Image lightlyactiveimg=Image.asset('assets/ActivityLevel/walk.png',height: 60,width: 60);
  Image sedentaryimg=Image.asset('assets/ActivityLevel/sedentary.png',height: 60,width: 60);

  @override
  Widget build(BuildContext context) {
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

          SizedBox(height: MediaQuery.of(context).size.height*0.04,),
          Text("Select Your Activity Level",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),

     SizedBox(height: 30,),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.5,
            child: ListView(

              padding: EdgeInsets.all(10),
              physics: NeverScrollableScrollPhysics(),

              children: [

                Card(

                  color: mainColor,
                  child: ListTile(

                    leading: veryactiveimg,
                    title: Text("Very Active"),
                    subtitle: Text("High Intensity Training"),
                    titleTextStyle: mainTextStyle,
                    subtitleTextStyle: subTextStyle,
                    onTap: (){

                      setState(() {
                        selectedLevel = 'very';

                      },

                      );
                    },

                    trailing: Radio(value: 'very', groupValue: selectedLevel, onChanged: (value){

                      setState(() {
                        selectedLevel=value;
                      });


                    } ),

                  ),

                ),
                SizedBox(height: 24,),
                Card(
                  color: mainColor,
                  child: ListTile(
                    leading: moderatelyactiveimg,
                    title: Text("Moderately Active"),
                    subtitle: Text("Moderate Intensity Training"),
                    titleTextStyle: mainTextStyle,
                    subtitleTextStyle: subTextStyle,
                    onTap: (){

                      setState(() {
                        selectedLevel = 'moderate';
                      },
                      );
                    },

                    trailing: Radio(value: 'moderate', groupValue: selectedLevel, onChanged: (value){

                      setState(() {
                        selectedLevel=value;
                      });


                    } ),

                  ),
                ),
                SizedBox(height: 24,),

                Card(
                  color: mainColor,
                  child: ListTile(
                    leading: lightlyactiveimg,
                    title: Text("Lightly Active"),
                    subtitle: Text("Light Intensity Training"),
                    titleTextStyle: mainTextStyle,
                    subtitleTextStyle: subTextStyle,
                    onTap: (){

                      setState(() {
                        selectedLevel = 'light';

                      },
                      );
                    },
                    trailing: Radio(value: 'light', groupValue: selectedLevel, onChanged: (value){

                      setState(() {
                        selectedLevel=value;
                      });


                    } ),

                  ),
                ),
                SizedBox(height: 24,),

                Card(
                  color: mainColor,
                  child: ListTile(
                    leading: sedentaryimg,
                    title: Text("Sedentary"),
                    subtitle: Text("Little or No Exercise"),
                    titleTextStyle: mainTextStyle,
                    subtitleTextStyle: subTextStyle,
                    onTap: (){

                      setState(() {
                        selectedLevel = 'sedentary';

                      },
                      );
                    },

                    trailing: Radio(value: 'sedentary', groupValue: selectedLevel, onChanged: (value){

                      setState(() {
                        selectedLevel=value;
                      });


                    } ),

                  ),
                ),

              ],

            ),
          ),

  SizedBox(height: 20,),
          if(selectedLevel!=null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>CurrentWeight()));


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
        ],

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
}
