import 'package:flutter/foundation.dart';

class GoalSelectionProvider with ChangeNotifier{

String? _selectedGoal;

String? get getSelectedGoal => _selectedGoal;

void setSelectedGoal(String? value){

  _selectedGoal=value;
  notifyListeners();



}
void reset(){
  _selectedGoal=null;
  notifyListeners();

}



}