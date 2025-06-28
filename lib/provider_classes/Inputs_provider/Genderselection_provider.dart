import 'package:flutter/foundation.dart';
import 'package:gender_picker/source/enums.dart';

class genderProvider with ChangeNotifier{

  Gender? selectedgender;
  Gender? get getGender => selectedgender;

void  setGender(Gender? value){

  selectedgender=value;
  notifyListeners();

}
void reset(){
  selectedgender=null;
  notifyListeners();
}

}
