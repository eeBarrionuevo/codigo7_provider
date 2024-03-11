
import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {

  int counter = 1000;
  List<String> names = ["Elvis", "Ramón", "Luis"];
  String selectedName = "Elvis";
  bool isLoading = false;

  void changeCounter(){
    counter++;
    notifyListeners();
  }

  void addName(String name){
    names.add(name);
    notifyListeners();
  }

  void changeName(String value){
    selectedName = value;
    notifyListeners();
  }

  void setValues(){

  }

}