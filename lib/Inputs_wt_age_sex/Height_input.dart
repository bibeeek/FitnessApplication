import 'package:fitnessapp/LoginRegs/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:simple_ruler_picker/simple_ruler_picker.dart';

class CurrentHeight extends StatefulWidget {
  const CurrentHeight({super.key});

  @override
  State<CurrentHeight> createState() => _CurrentHeightState();
}

class _CurrentHeightState extends State<CurrentHeight> {
  bool isCm = true;

  double heightCm = 170;

  double cmToFeet(double cm) => cm / 30.48;
  double feetToCm(double feet, double inches) => (feet * 30.48) + (inches * 2.54);
  double feetPart(double cm) => cmToFeet(cm).floorToDouble();
  double inchPart(double cm) => ((cmToFeet(cm) % 1) * 12).roundToDouble();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: const Color.fromRGBO(0, 130, 83, 1),
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset("assets/AgeGenderImages/finallogo.png", height: 230, width: 450),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.07),

          const Text(
            "Input Your Current Height",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.1),

          Align(
            alignment: Alignment.topLeft,
            child: Text(
              isCm
                  ? '${heightCm.toStringAsFixed(1)} cm'
                  : '${feetPart(heightCm).toInt()} ft ${inchPart(heightCm).toInt()} in',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),

          SimpleRulerPicker(
            key: ValueKey(isCm),
            height: 130,
            minValue: isCm ? 100 : 39, // 100 cm ≈ 3.2 ft
            maxValue: isCm ? 220 : 86,  // 220 cm ≈ 7.2 ft
            initialValue: isCm
                ? heightCm.clamp(100.0, 220.0).round()
                : (cmToFeet(heightCm).floor() * 12 + inchPart(heightCm).round())
                .clamp(39, 86),
            scaleItemWidth: 16,
            lineStroke: 4,
            longLineHeight: 40,
            shortLineHeight: 25,
            selectedColor: Colors.green,
            scaleLabelSize: 17,
            onValueChanged: (value) {
              setState(() {
                if (isCm) {
                  heightCm = value.toDouble();
                } else {
                  double feet = (value ~/ 12).toDouble();
                  double inches = (value % 12).toDouble();
                  heightCm = feetToCm(feet, inches);
                }
              });
            },
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.025),

          ToggleButtons(
            isSelected: [isCm, !isCm],
            color: Colors.black,
            onPressed: (index) {
              setState(() {
                isCm = index == 0;
              });
            },
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("CM"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("FT/IN"),
              ),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.1),

          ElevatedButton(
            onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 130, 83, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              minimumSize: const Size(200, 50),
            ),
            child: const Text(
              'Next',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
