import 'package:flutter/foundation.dart';
import 'package:gender_picker/source/enums.dart';

class genderProvider with ChangeNotifier{

  Gender? _selectedgender;
  Gender? get getGender => _selectedgender;

void  setGender(Gender? value){

  _selectedgender=value;
  notifyListeners();

}
void reset(){
  _selectedgender=null;
  notifyListeners();
}

}
