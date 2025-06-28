import 'package:fitnessapp/Inputs_wt_age_sex/TargetWeight.dart';
import 'package:fitnessapp/provider_classes/Inputs_provider/all_inputs_provider.dart';
import 'package:fitnessapp/provider_classes/Inputs_provider/goal_level_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ruler_picker/simple_ruler_picker.dart';

import 'Height_input.dart';

class CurrentWeight extends StatefulWidget {
  const CurrentWeight({super.key});

  @override
  State<CurrentWeight> createState() => _CurrentWeightState();
}

class _CurrentWeightState extends State<CurrentWeight> {
  double kgToLbs(double kg) => kg * 2.20462;
  double lbsToKg(double lbs) => lbs / 2.20462;

  @override
  Widget build(BuildContext context) {
    final goal = Provider.of<GoalSelectionProvider>(context, listen: false);

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
      body: Consumer<AllInputsProvider>(
        builder: (context, value, child) {
          // Define min and max depending on unit
          final minVal = value.getcurrentInput ? 30 : 66;
          final maxVal = value.getcurrentInput ? 180 : 400;

          // Convert current weight to current unit
          final rawWeight = value.getcurrentInput
              ? value.getCurrentWeight
              : kgToLbs(value.getCurrentWeight);

          // Clamp initial value within min and max
          final clampedInitialVal = rawWeight.clamp(minVal.toDouble(), maxVal.toDouble());

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              const Text(
                "Select Your Current Weight",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  value.getcurrentInput
                      ? '${value.getCurrentWeight.toStringAsFixed(1)} kg'
                      : '${kgToLbs(value.getCurrentWeight).toStringAsFixed(1)} lbs',
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              SimpleRulerPicker(
                key: ValueKey(value.getcurrentInput),
                height: 130,
                minValue: minVal,
                maxValue: maxVal,
                initialValue: clampedInitialVal.round(),
                scaleItemWidth: 16,
                lineStroke: 4,
                longLineHeight: 40,
                shortLineHeight: 25,
                selectedColor: Colors.green,
                scaleLabelSize: 17,
                onValueChanged: (newValue) {
                  value.setCurrentWeight(newValue.toDouble());
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              ToggleButtons(
                isSelected: [value.getcurrentInput, !value.getcurrentInput],
                color: Colors.black,
                onPressed: (int index) {
                  value.setIskg(index == 0);
                },
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("KG"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("LBS"),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ElevatedButton(
                onPressed: () {
                  if (goal.getSelectedGoal == 'gain' || goal.getSelectedGoal == 'lose') {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Targetweight()));
                  } else if ([
                    'fit',
                    'track',
                    'eat',
                    'maintain'
                  ].contains(goal.getSelectedGoal)) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CurrentHeight()));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 130, 83, 1),
                  shadowColor: const Color.fromRGBO(0, 130, 83, 1),
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
          );
        },
      ),
    );
  }
}
