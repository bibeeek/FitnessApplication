import 'package:fitnessapp/LoginRegs/Registration_Page.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';




class AgePicker extends StatefulWidget {
  @override
  _AgePickerState createState() => _AgePickerState();
}

class _AgePickerState extends State<AgePicker> {
  int _selectedAge = 18;
  double progress=0.4;

  @override
  Widget build(BuildContext context) {
    Image boyimg = Image.asset('assets/AgeGenderImages/boy.png', height: 45, width: 45);
    Image teenimg = Image.asset('assets/AgeGenderImages/adult.png', height: 45, width: 45);
    Image oldimg = Image.asset('assets/AgeGenderImages/old-man.png', height: 45, width: 45);
    Image dadimg = Image.asset('assets/AgeGenderImages/dad.png', height: 45, width: 45);

    return Scaffold(

      backgroundColor: Colors.blueGrey[50],

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor:  Color.fromRGBO(0, 130, 83, 1),
        title:  Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset("assets/AgeGenderImages/finallogo.png",height: 200,width: 450),
        ),
        centerTitle: true,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 5,),



            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Select Your  Age",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(width: 10),

                _selectedAge < 26
                    ? boyimg
                    : _selectedAge < 35
                    ? teenimg
                    : _selectedAge < 60
                    ? dadimg
                    : oldimg,
              ],
            ),

            SizedBox(height: 20),

            Text(
              "We personalize your workouts based on your age.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),


            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Icon(
                  Icons.arrow_right,
                  size: 40,
                  color:Colors.black54,
                ),

                NumberPicker(
                  itemWidth: 70,
                  minValue: 18,

                  maxValue: 60,
                  value: (_selectedAge),
                  onChanged: (value) {
                    setState(() {
                      _selectedAge = value;
                    });
                  },
                  axis: Axis.vertical,
                  selectedTextStyle: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 170, 100, 1),
                  ),
                  textStyle: TextStyle(
                      fontSize: 13,
                    color: Color.fromRGBO(0, 130, 83, 1),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(0, 130, 83, 1),),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 130, 83, 1),
                        blurRadius: 2,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Icon(
                  Icons.arrow_left,
                  size: 40,
                  color: Colors.black54,
                ),

              ],
            ),
            SizedBox(height: 40,),

             ElevatedButton(onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationPage()));
              },

                  style: ElevatedButton.styleFrom(

                    backgroundColor: Color.fromRGBO(0, 130, 83, 1),
                    shadowColor: Color.fromRGBO(0, 130, 83, 1),
                    minimumSize: Size(200, 50),
                  ),
                  child:
                  Text('Next',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),)
              ),



            Spacer(flex: 4,),

            Spacer(flex: 1,),


            Spacer(flex: 1,),

          ],
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
}
