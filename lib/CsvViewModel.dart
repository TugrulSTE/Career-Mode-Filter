import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'player.dart';
import 'favoriteService.dart';
import 'package:flutter/services.dart' show rootBundle;

class CsvViewModel extends ChangeNotifier {
  // Filtreleme için parametreler
  int minValue, maxValue;
  int minOverall, maxOverall;
  int minPotential, maxPotential;
  List<String> position;
  int minAge, maxAge;
  String name;
  final String game;

  List<Player> filteredData = [];
  List<Player> favoritePlayers = [];

  int currentPage = 0;
  final int itemsPerPage = 10;

  bool isLoading = false;

  CsvViewModel({
    required this.game,
    required this.minAge,
    required this.maxAge,
    required this.minPotential,
    required this.maxPotential,
    required this.minOverall,
    required this.maxOverall,
    required this.position,
    required this.minValue,
    required this.maxValue,
    required this.name,
  }) {
    loadCsvData();
  }

  String _getCsvPath() {
    switch (game.toLowerCase()) {
      case 'fifa 22':
        return 'lib/assets/fifa22.csv';
      
      default:
        return 'lib/assets/fifa22.csv';
    }
  }

  // CSV verisini yükle ve filtrele
  Future<void> loadCsvData() async {
    isLoading = true;
    notifyListeners();

    try {

      final byteData = await rootBundle.load(_getCsvPath());
final String rawData = utf8.decode(byteData.buffer.asUint8List(), allowMalformed: true);


      List<List<dynamic>> csvData;

        csvData = CsvToListConverter(fieldDelimiter: ',').convert(rawData);
      

      List<String> headers = csvData.first.cast<String>();

      List<Player> tempFilteredData = [];

      for (var row in csvData.skip(1)) {
        int age = int.tryParse(row[9].toString()) ?? 0;
        int overall = int.tryParse(row[5].toString()) ?? 0;
        int potential = int.tryParse(row[6].toString()) ?? 0;
        String plname = row[2].toString();
        int skills = int.tryParse(row[29].toString()) ?? 0;
        double value =
            row[7] is double ? row[7] : double.tryParse(row[7].toString()) ?? 0;

        

        bool matchesFilters = age >= minAge &&
            age <= maxAge &&
            overall >= minOverall &&
            overall <= maxOverall &&
            potential >= minPotential &&
            potential <= maxPotential &&
            value >= minValue &&
            value <= maxValue &&
            (name.isEmpty || plname.toLowerCase().contains(name.toLowerCase()));

        bool matchesPosition = position.isEmpty
            ? true
            : row[4]
                .toString()
                .split(", ")
                .map((e) => e.trim())
                .toList()
                .any((pos) => position.contains(pos));

        if (matchesFilters && matchesPosition) {
          Player player = Player(
          name: plname,
          age: age,
          potential: potential,
          overall: overall,
          value: value,
          club: row[14].toString(),
          skills: skills,
        );
          tempFilteredData.add(player);
        }
      }

      filteredData = tempFilteredData;
    } catch (e) {
      print("Error reading CSV: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  // Sayfa sayısı
  int get totalPages => (filteredData.length / itemsPerPage).ceil();

  // Sayfaya göre veriyi getir
  List<Player> get currentItems {
    return filteredData
        .skip(currentPage * itemsPerPage)
        .take(itemsPerPage)
        .toList();
  }

  // Sayfa değiştir
  void nextPage() {
    if (currentPage < totalPages - 1) {
      currentPage++;
      notifyListeners();
    }
  }

  void prevPage() {
    if (currentPage > 0) {
      currentPage--;
      notifyListeners();
    }
  }

  Future<void> addToFavorites(Player player) async {
    await Favoriteservice().addFavorite(player);
    favoritePlayers.add(player);
    notifyListeners();
  }
}
