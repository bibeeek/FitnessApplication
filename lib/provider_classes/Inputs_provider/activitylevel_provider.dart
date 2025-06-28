import 'package:flutter/foundation.dart';

class ActivityLevelProvider with ChangeNotifier{

String? _selectedLevel;

String? get getSelectedLevel => _selectedLevel;

void setSelectedLevel(String? value){

  _selectedLevel=value;
  notifyListeners();


}

void reset(){
  _selectedLevel=null;
  notifyListeners();
}


}
