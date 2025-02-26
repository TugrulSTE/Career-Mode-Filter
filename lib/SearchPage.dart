import 'package:careerfilter/FavoritePage.dart';
import 'package:careerfilter/player.dart';
import 'package:careerfilter/topImage.dart';
import 'package:flutter/material.dart';
import 'csvProcess.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  String game1;
  SearchPage({required this.game1, super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController overallMinController = TextEditingController();
  final TextEditingController overallMaxController = TextEditingController();
  final TextEditingController potentialMinController = TextEditingController();
  final TextEditingController potentialMaxController = TextEditingController();
  final TextEditingController ageMinController = TextEditingController();
  final TextEditingController ageMaxController = TextEditingController();
  final TextEditingController valueMinController = TextEditingController();
  final TextEditingController valueMaxController = TextEditingController();
  final TextEditingController club = TextEditingController();
  final TextEditingController name = TextEditingController();
  final List<String> positions = [
    "GK",
    "LB",
    "LWB",
    "CB",
    "RB",
    "RWB",
    "MO",
    "MOO",
    "MDO",
    "RM",
    "LM",
    "LW",
    "RW",
    "ST",
    "CF"
  ];
  List<String> selectedPositions = [];
  void showMultiSelectDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text("Select Positions"),
            content: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
                // Maksimum yükseklik
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Sadece içeriğin boyutunu kullan
                  children: positions
                      .map(
                        (position) => CheckboxListTile(
                          title: Text(position),
                          value: selectedPositions.contains(position),
                          onChanged: (bool? isSelected) {
                            setState(() {
                              if (!selectedPositions.contains(position)) {
                                // Pozisyon listede yoksa ekle
                                selectedPositions.add(position);
                              } else {
                                // Pozisyon listeden çıkar
                                selectedPositions.remove(position);
                              }
                            });
                            print(selectedPositions);
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Modal kapatılır.
                },
                child: Text("Done"),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              // Üst kısım (Mavi bölüm)
              topImage(),

              // Başlık
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'FILTER TO SEARCH',
                  style: TextStyle(
                    fontSize: 23,
                    color: const Color.fromARGB(255, 33, 15, 150),
                  ),
                ),
              ),

              // Select Position Butonu
              Padding(
                padding: const EdgeInsets.only(right: 95.0),
                child: GestureDetector(
                  onTap: showMultiSelectDialog,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 33, 15, 150),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select Position",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Diğer filtreleme alanları
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    SizedBox(height: 5),
                    Column(
                      children: [
                        buildNameField("Name", name),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: buildFilterField(
                                "Overall Min", overallMinController)),
                        SizedBox(width: 9),
                        Expanded(
                            child: buildFilterField(
                                "Overall Max", overallMaxController)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Potential Min-Max
                    Row(
                      children: [
                        Expanded(
                            child: buildFilterField(
                                "Potential Min", potentialMinController)),
                        SizedBox(width: 9),
                        Expanded(
                            child: buildFilterField(
                                "Potential Max", potentialMaxController)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Age Min-Max
                    Row(
                      children: [
                        Expanded(
                            child:
                                buildFilterField("Age Min", ageMinController)),
                        SizedBox(width: 9),
                        Expanded(
                            child:
                                buildFilterField("Age Max", ageMaxController)),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    // Value Min-Max
                    Row(
                      children: [
                        Expanded(
                            child: buildFilterField(
                                "Value Min", valueMinController)),
                        SizedBox(width: 9),
                        Expanded(
                            child: buildFilterField(
                                "Value Max", valueMaxController)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        final minAge =
                            int.tryParse(ageMinController.text) ?? 16;
                        final maxAge =
                            int.tryParse(ageMaxController.text) ?? 50;
                        final minVal =
                            int.tryParse(valueMinController.text) ?? 0;
                        final maxVal =
                            int.tryParse(valueMaxController.text) ?? 1000000000;
                        final ovrMax =
                            int.tryParse(overallMaxController.text) ?? 99;
                        final ovrMin =
                            int.tryParse(overallMinController.text) ?? 40;
                        final potMax =
                            int.tryParse(potentialMaxController.text) ?? 99;
                        final potMin =
                            int.tryParse(potentialMinController.text) ?? 40;
                        final pos = selectedPositions;
                        ;
                        print(potMax);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CsvExample([],
                                  game: widget.game1,
                                  minage: minAge,
                                  maxage: maxAge,
                                  maxoverall: ovrMax,
                                  minoverall: ovrMin,
                                  maxpotential: potMax,
                                  minpotential: potMin,
                                  maxvalue: maxVal,
                                  minvalue: minVal,
                                  name: name.text,
                                  position: pos,
                                  )),
                        );
                      },
                      backgroundColor: const Color.fromARGB(255, 33, 15, 150),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    FloatingActionButton(
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Favoritepage()))

                      },
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build individual filter text fields
  Widget buildFilterField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: UnderlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget buildNameField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: UnderlineInputBorder(),
        ),
        keyboardType: TextInputType.name,
      ),
    );
  }
}
