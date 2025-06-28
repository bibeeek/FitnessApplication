import 'package:fitnessapp/Inputs_wt_age_sex/goal_Achieve_time.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ruler_picker/simple_ruler_picker.dart';

import '../provider_classes/Inputs_provider/all_inputs_provider.dart';
import '../provider_classes/Inputs_provider/goal_level_provider.dart';

class Targetweight extends StatefulWidget {
  const Targetweight({super.key});

  @override
  State<Targetweight> createState() => _TargetweightState();
}

class _TargetweightState extends State<Targetweight> {
  double kgToLbs(double kg) => kg * 2.20462;
  double lbsToKg(double lbs) => lbs / 2.20462;

  String? _lastGoal;

  @override
  Widget build(BuildContext context) {
    final inputProvider = Provider.of<AllInputsProvider>(context);
    final goalProvider = Provider.of<GoalSelectionProvider>(context);

    final isKg = inputProvider.getcurrentInput;
    final currentWeight = inputProvider.getCurrentWeight;
    final currentGoal = goalProvider.getSelectedGoal;
    final storedTarget = inputProvider.getTargetWeight;
    final sliderMoved = inputProvider.targetSliderMoved;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_lastGoal != currentGoal) {
        _lastGoal = currentGoal;

        double newTarget;
        if (currentGoal == 'lose') {
          newTarget = (currentWeight - 2).clamp(30.0, currentWeight - 1);
        } else if (currentGoal == 'gain') {
          newTarget = (currentWeight + 2).clamp(currentWeight + 1, 180.0);
        } else {
          newTarget = currentWeight;
        }

        inputProvider.setTargetWeight(newTarget);
        inputProvider.setTargetSliderMoved(false); // Reset text when goal changes
        return;
      }

      // Validate storedTarget again
      if (storedTarget == null) {
        inputProvider.setTargetWeight(currentWeight);
        inputProvider.setTargetSliderMoved(false);
      } else {
        if ((currentGoal == 'lose' && storedTarget >= currentWeight) ||
            (currentGoal == 'gain' && storedTarget <= currentWeight)) {
          final corrected = currentGoal == 'lose'
              ? (currentWeight - 2).clamp(30.0, currentWeight - 1)
              : (currentWeight + 2).clamp(currentWeight + 1, 180.0);

          inputProvider.setTargetWeight(corrected);
          inputProvider.setTargetSliderMoved(false);
        }
      }
    });

    final targetWeight = inputProvider.getTargetWeight ?? currentWeight;

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.07),
          const Text(
            "Input Your Target Weight",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),

          /// Display selected weight
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              sliderMoved
                  ? (isKg
                  ? '${targetWeight.toStringAsFixed(1)} kg'
                  : '${kgToLbs(targetWeight).toStringAsFixed(1)} lbs')
                  : '', // blank if slider not moved
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),

          if (currentGoal == 'lose' || currentGoal == 'gain')
            Builder(builder: (context) {
              double minVal, maxVal, initialVal;

              if (currentGoal == 'lose') {
                minVal = isKg ? 30 : 66;
                maxVal = isKg
                    ? (currentWeight - 1).clamp(31.0, 180.0)
                    : kgToLbs(currentWeight - 1).clamp(67.0, 400.0);
                initialVal = isKg
                    ? targetWeight.clamp(minVal, maxVal)
                    : kgToLbs(targetWeight).clamp(minVal, maxVal);
              } else {
                minVal = isKg
                    ? (currentWeight + 1).clamp(31.0, 179.0)
                    : kgToLbs(currentWeight + 1).clamp(67.0, 399.0);
                maxVal = isKg ? 180 : 400;
                initialVal = isKg
                    ? targetWeight.clamp(minVal, maxVal)
                    : kgToLbs(targetWeight).clamp(minVal, maxVal);
              }

              return SimpleRulerPicker(
                key: ValueKey('slider-$currentGoal-$isKg'),
                height: 130,
                minValue: minVal.toInt(),
                maxValue: maxVal.toInt(),
                initialValue: initialVal.round(),
                scaleItemWidth: 16,
                lineStroke: 4,
                longLineHeight: 40,
                shortLineHeight: 25,
                selectedColor: Colors.green,
                scaleLabelSize: 17,
                onValueChanged: (newValue) {
                  final realVal = isKg ? newValue.toDouble() : lbsToKg(newValue.toDouble());
                  inputProvider.setTargetWeight(realVal);

                  if (!inputProvider.targetSliderMoved) {
                    inputProvider.setTargetSliderMoved(true);
                  }
                },
              );
            }),

          SizedBox(height: MediaQuery.of(context).size.height * 0.025),

          /// KG / LBS Toggle
          ToggleButtons(
            isSelected: [isKg, !isKg],
            color: Colors.black,
            onPressed: (index) {
              inputProvider.setIskg(index == 0);

              inputProvider.setTargetSliderMoved(true);
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

          /// NEXT
          ElevatedButton(
            onPressed: () {
              print('CurrentWeight: $currentWeight');
              print('TargetWeight: ${inputProvider.getTargetWeight}');
              print('Unit: ${isKg ? "kg" : "lbs"}');
              if(sliderMoved==false){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select a Weight")));

              }

              else{  Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const GoalAchieveTime()),
              );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 130, 83, 1),
              shadowColor: const Color.fromRGBO(0, 130, 83, 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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