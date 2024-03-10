
import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {

  int counter = 1000;
  List<String> names = ["Elvis", "Ramón", "Luis"];
  bool isLoading = false;

  void changeCounter(){
    counter++;
    notifyListeners();
  }
  void setValues(){

  }

}