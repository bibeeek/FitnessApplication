import 'package:flutter/foundation.dart';

//inputs like height wt current wt and target wt here


class AllInputsProvider with ChangeNotifier{



  double cmToFeet(double cm) => cm / 30.48;
  double feetToCm(double feet, double inches) => (feet * 30.48) + (inches * 2.54);
  double feetPart(double cm) => cmToFeet(cm).floorToDouble();
  double inchPart(double cm) => ((cmToFeet(cm) % 1) * 12).roundToDouble();


  double kgToLbs(double kg) => kg * 2.20462;
  double lbsToKg(double lbs) => lbs / 2.20462;


 int _selectedAge=25;

 int get getSelectedAge => _selectedAge;

 double _currentWeight=70;

 bool _iskg=true;


 bool get getcurrentInput => _iskg;

 double get getCurrentWeight=> _currentWeight;


 double? _targetWeight;
 double? get getTargetWeight => _targetWeight;


 bool _targetSliderMoved = false;
 bool get targetSliderMoved => _targetSliderMoved;

 void setTargetSliderMoved(bool value) {
   _targetSliderMoved = value;
   notifyListeners();
 }



 double _goalAchieveTime=0.25;
 double get getGoalAchieveTime => _goalAchieveTime;


  double _currentHeight=170;
  double get getCurrentHeight => _currentHeight;

  bool _isCm=true;
  bool get getIsCm => _isCm;

  void setIsCm(bool value){
    _isCm=value;
    notifyListeners();
  }

  void setSelectedHeight(double value){
    _currentHeight=value;
    notifyListeners();
  }



 void setGoalAchieveTime(double value){
   _goalAchieveTime=value;
   notifyListeners();
 }

 void setTargetWeight(double value) {
   _targetWeight=value;
   notifyListeners();
 }


 void setCurrentWeight(double value){

   _currentWeight=_iskg?value.toDouble():lbsToKg(value.toDouble());
   notifyListeners();

 }

 void setIskg(bool value){

   _iskg=value;
   notifyListeners();


 }



 void setSelectedAge(int value){

   _selectedAge=value;
   notifyListeners();


  }

  void reset() {
    _selectedAge = 18;
    _currentWeight = 0.0;
    _targetWeight = null;
    _goalAchieveTime = 0;
    _currentHeight = 0.0;
    _iskg = true;
    _targetSliderMoved = false;
    notifyListeners();
  }





}