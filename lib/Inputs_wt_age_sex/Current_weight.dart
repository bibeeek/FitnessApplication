import 'package:fitnessapp/Inputs_wt_age_sex/TargetWeight.dart';
import 'package:flutter/material.dart';
import 'package:simple_ruler_picker/simple_ruler_picker.dart';

import 'Height_input.dart';

class CurrentWeight extends StatefulWidget {
  const CurrentWeight({super.key});

  @override
  State<CurrentWeight> createState() => _CurrentWeightState();
}

class _CurrentWeightState extends State<CurrentWeight> {

  bool iskg=true;

  double selectedWeightkg=70;
  double kgToLbs(double kg) => kg * 2.20462;
  double lbsToKg(double lbs) => lbs / 2.20462;


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
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [

         SizedBox(height: MediaQuery.of(context).size.height*0.07,),

         Text("Input Your Current Weight",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),

         SizedBox(height: MediaQuery.of(context).size.height*0.1,),

         Align(
           alignment: Alignment.topLeft,
           child: Text(
             iskg
                 ? ' ${selectedWeightkg.toStringAsFixed(1)} kg'
                 : '${kgToLbs(selectedWeightkg).toStringAsFixed(1)} lbs',
             style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),
           ),
         ),

         SimpleRulerPicker(
           key: ValueKey(iskg),
           height: 130,
           minValue: iskg? 30:66,
           maxValue: iskg? 180:400,
           initialValue: iskg? selectedWeightkg.round():kgToLbs(selectedWeightkg).round(),
           scaleItemWidth: 16,
           lineStroke: 4,
           longLineHeight: 40,
           shortLineHeight: 25,

           selectedColor: Colors.green,
           scaleLabelSize: 17,
          onValueChanged: (value){

             setState(() {
             selectedWeightkg=iskg?value.toDouble():lbsToKg(value.toDouble());

             });
          },


         ),
         SizedBox(height: MediaQuery.of(context).size.height*0.025,),

         ToggleButtons( isSelected:[iskg,!iskg], color: Colors.black,onPressed: (index){
           setState(() {
             iskg=index==0;
           });

         }, children: [
                  Padding(
                     padding: EdgeInsets.symmetric(horizontal: 16),
                       child: Text("KG"),
                         ),
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 16),
                   child: Text("LBS"),
                 ),
               ], ),

         SizedBox(height: MediaQuery.of(context).size.height*0.1,),

         ElevatedButton(onPressed: (){

          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Targetweight(currentWeight: selectedWeightkg,)));


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

   );
  }
}
