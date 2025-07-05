import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  // Arama filtreleri
  String name = '';
  List<String> selectedPositions = [];

  int minOverall = 40;
  int maxOverall = 99;

  int minPotential = 40;
  int maxPotential = 99;

  int minAge = 16;
  int maxAge = 50;

  int minValue = 0;
  int maxValue = 1000000000;

  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }

  void updatePosition(String position, bool isSelected) {
    if (isSelected) {
      selectedPositions.add(position);
    } else {
      selectedPositions.remove(position);
    }
    notifyListeners();
  }

  void updateMinOverall(int value) {
    minOverall = value;
    notifyListeners();
  }

  void updateMaxOverall(int value) {
    maxOverall = value;
    notifyListeners();
  }

  // Aynı şekilde diğer update metodları da eklenebilir...
}
