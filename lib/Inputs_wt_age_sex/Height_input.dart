import 'package:fitnessapp/DashBoard_page/dashboard.dart';
import 'package:fitnessapp/LoginRegs/LoginPage.dart';
import 'package:fitnessapp/provider_classes/Inputs_provider/all_inputs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ruler_picker/simple_ruler_picker.dart';

import '../Shared_pref_help/shared_prefs.dart';
import '../provider_classes/Inputs_provider/Genderselection_provider.dart';
import '../provider_classes/Inputs_provider/activitylevel_provider.dart';
import '../provider_classes/Inputs_provider/goal_level_provider.dart';

class CurrentHeight extends StatefulWidget {
  const CurrentHeight({super.key});

  @override
  State<CurrentHeight> createState() => _CurrentHeightState();
}

class _CurrentHeightState extends State<CurrentHeight> {
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

      body: Consumer<AllInputsProvider>(builder: (context, provider, child) {
        bool isCm = provider.getIsCm;
        double currentHeight = provider.getCurrentHeight;

        return Column(
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
                    ? '${currentHeight.toStringAsFixed(1)} cm'
                    : '${feetPart(currentHeight).toInt()} ft ${inchPart(currentHeight).toInt()} in',
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),

            SimpleRulerPicker(
              key: ValueKey(isCm),
              height: 130,
              minValue: isCm ? 100 : 39,
              maxValue: isCm ? 220 : 86,
              initialValue: isCm
                  ? currentHeight.clamp(100.0, 220.0).round()
                  : (cmToFeet(currentHeight).floor() * 12 + inchPart(currentHeight).round())
                  .clamp(39, 86),
              scaleItemWidth: 16,
              lineStroke: 4,
              longLineHeight: 40,
              shortLineHeight: 25,
              selectedColor: Colors.green,
              scaleLabelSize: 17,
              onValueChanged: (val) {
                if (isCm) {
                  provider.setSelectedHeight(val.toDouble());
                } else {
                  double feet = (val ~/ 12).toDouble();
                  double inches = (val % 12).toDouble();
                  provider.setSelectedHeight(feetToCm(feet, inches));
                }
              },
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.025),

            ToggleButtons(
              isSelected: [isCm, !isCm],
              color: Colors.black,
              onPressed: (index) {
                provider.setIsCm(index == 0);
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
              onPressed: () async {

                final inputProvider = Provider.of<AllInputsProvider>(context, listen: false);
                final goalProvider = Provider.of<GoalSelectionProvider>(context, listen: false);
                final activityProvider = Provider.of<ActivityLevelProvider>(context, listen: false);
                final genderprovider = Provider.of<genderProvider>(context, listen: false);

                await SharedPrefsHelper.saveUserInput(
                  gender: genderprovider.getGender.toString(),
                  age: inputProvider.getSelectedAge,
                  goal: goalProvider.getSelectedGoal.toString(),
                  activityLevel: activityProvider.getSelectedLevel.toString(),
                  currentWeight: inputProvider.getCurrentWeight,
                  targetWeight: goalProvider.getSelectedGoal == 'gain' || goalProvider.getSelectedGoal == 'lose'
                      ? inputProvider.getTargetWeight
                      : null,
                  goalTime: goalProvider.getSelectedGoal == 'gain' || goalProvider.getSelectedGoal == 'lose'
                      ? inputProvider.getGoalAchieveTime.toInt()
                      : null,
                  height: inputProvider.getCurrentHeight,
                );







                Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoard()));
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
        );
      }),
    );
  }
}
