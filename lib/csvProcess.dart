import 'dart:async';
import 'dart:convert';
import 'package:careerfilter/databaseHelper.dart';
import 'package:careerfilter/favoriteService.dart';
import 'package:careerfilter/player.dart';
import 'package:careerfilter/topImage.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'positions.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CsvExample extends StatefulWidget {
  int minvalue;
  int maxvalue;
  int minoverall;
  int maxoverall;
  int minpotential;
  int maxpotential;
  List<String> position;
  int minage;
  int maxage;
  String name;
  final game;

  CsvExample(
    List<String> selectedPositions, {
    super.key,
    required this.game,
    required this.minage,
    required this.maxage,
    required this.minpotential,
    required this.maxpotential,
    required this.minoverall,
    required this.maxoverall,
    required this.position,
    required this.minvalue,
    required this.maxvalue,
    required this.name,
  });
  @override
  _CsvExampleState createState() => _CsvExampleState();
}

class _CsvExampleState extends State<CsvExample> {
  List<Map<String, dynamic>> data = []; // CSV verileri burada saklanacak.
  List<Player> filteredData = [];
  List<Player> favorite_player = [];

  @override
  void initState() {
    super.initState();
    loadCsvData();
  }

  Future<void> _addToFavorites(Player player) async {
    await Favoriteservice().addFavorite(player);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${player.name} favorilere eklendi!")));
  }

  // CSV dosyasını okuma ve verileri işleme
  Future<void> loadCsvData() async {
    try {
      final String rawData;
      // CSV dosyasını yükle
      print(widget.game == "FIFA 16");
      /*
      if (widget.game == "FIFA 16") {
        rawData = await DefaultAssetBundle.of(context)
            .loadString('lib/assets/fifa22.csv');
      
      } else if (widget.game == "FIFA 22") {
        rawData = await DefaultAssetBundle.of(context)
            .loadString('lib/assets/fifa22.csv');
      } else {
        rawData = await DefaultAssetBundle.of(context)
            .loadString('lib/assets/fifa22.csv');
      }
      */
      rawData = await DefaultAssetBundle.of(context)
          .loadString('lib/assets/fifa22.csv');
      // CSV verisini listeye dönüştür
      List<List<dynamic>> csvData =
          CsvToListConverter().convert(rawData, fieldDelimiter: ',');

      // İlk satırı (başlıklar) al
      List<String> headers = csvData.first.cast<String>();
//["id, name, ovr"]
      // Geri kalan satırları işleyip bir listeye dönüştür
      List<Map<String, dynamic>> rows = csvData.skip(1).map((row) {
        return {
          headers[0]: row[0], // ID
          headers[2]: row[2], // Name
          headers[4]: row[4], // Pos
          headers[5]: row[5], // Ovr
          headers[6]: row[6], // Pot
          headers[9]: row[9], // Age
          headers[7]: row[7], // Value
          headers[14]: row[14],
        };
      }).toList();
      print(rows[4]);
      // Sadece belirli sütunları seçmek (örneğin Name ve Age)
      setState(() {
        for (var row in rows) {
          int age = int.tryParse(row["age"]?.toString() ?? '0') ?? 0;
          int overall = int.tryParse(row["overall"]?.toString() ?? '0') ?? 0;
          int potential =
              int.tryParse(row["potential"]?.toString() ?? '0') ?? 0;
          String plname = row["short_name"];
          double value = row["value_eur"] is double
              ? row["value_eur"]
              : double.tryParse(row["value_eur"].toString()) ?? 0;
          Player x = Player(
              name: row["short_name"].toString(),
              age: age,
              potential: potential,
              overall: overall,
              value: value,
              club: row["club_name"]);

          if (age < widget.maxage &&
              value < widget.maxvalue &&
              value > widget.minvalue &&
              age > widget.minage &&
              overall < widget.maxoverall &&
              overall > widget.minoverall &&
              potential < widget.maxpotential &&
              potential > widget.minpotential &&
              plname.contains(widget.name == "" ? "" : widget.name)) {
            if (widget.position.isEmpty) {
              filteredData.add(x);
            } else {
              for (var i = 0; i < widget.position.length; i++) {
                if (row["player_positions"]
                    .toString()
                    .split(", ")
                    .map((s) => s.trim())
                    .toList()
                    .contains(widget.position[i])) {
                  filteredData.add(x);
                }
              }
            }
          }
        }

        // Filtrelenmiş veriyi `data` değişkenine atıyoruz.
      });
    } catch (e) {
      print("Error reading CSV: $e");
    }
  }

  int currentPage = 0;
  final int itemsPerPage = 10;
  @override
  Widget build(BuildContext context) {
    int totalPages = (filteredData.length / itemsPerPage).ceil();

    // Sayfadaki veriyi al
    List<Player> currentItems = filteredData
        .skip(currentPage * itemsPerPage)
        .take(itemsPerPage)
        .toList();

    return SafeArea(
      child: Scaffold(
        body: filteredData.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  topImage(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: currentItems.length,
                      itemBuilder: (context, index) {
                        final row = currentItems[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 252, 252, 252),
                                  Color.fromARGB(255, 51, 34, 164),
                                ],
                              ),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(11.0),
                                bottomRight: Radius.circular(11.0),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Image.asset(
                                    'lib/assets/images/unknown.png',
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        row.name,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text("Age: ${row.age}",
                                              style: TextStyle(fontSize: 18)),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              "Overall: ${row.overall}",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          Text("Potential: ${row.potential}",
                                              style: TextStyle(fontSize: 18)),
                                        ],
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Value: ${NumberFormat('#,##0', 'tr_TR').format(row.value)} €",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            FloatingActionButton(
                                              heroTag: null,
                                              onPressed: () {
                                                favorite_player.add(row);
                                                print(
                                                    favorite_player.toString());
                                                _addToFavorites(row);
                                              },
                                              backgroundColor: Colors.white,
                                              mini: true,
                                              child: Icon(Icons.favorite),
                                            ),
                                            FloatingActionButton(
                                              heroTag: null,
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(row.name),
                                                        content: Text(row.club),
                                                      );
                                                    });
                                              },
                                              backgroundColor: Colors.white,
                                              mini: true,
                                              child: Icon(Icons.info),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Sayfa kontrol butonları
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: currentPage > 0
                            ? () {
                                setState(() {
                                  currentPage--;
                                });
                              }
                            : null,
                        icon: Icon(Icons.arrow_back),
                      ),
                      Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 94, 90, 192),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          child: Text("Page ${currentPage + 1} / $totalPages")),
                      IconButton(
                        onPressed: currentPage < totalPages - 1
                            ? () {
                                setState(() {
                                  currentPage++;
                                });
                              }
                            : null,
                        icon: Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
