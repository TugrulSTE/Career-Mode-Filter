import 'package:careerfilter/favoriteService.dart';
import 'package:careerfilter/player.dart';
import 'package:careerfilter/topImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Favoritepage extends StatefulWidget {
  Favoritepage({super.key});

  @override
  _FavoritepageState createState() => _FavoritepageState();
}

class _FavoritepageState extends State<Favoritepage> {
  int itemsPerPage = 10;
  int currentPage = 0;
  List<Player> favorites=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  _loadFavorites();
  }

Future<void> _loadFavorites() async {
    final favs = await Favoriteservice().getFavorites();
    setState(() {
      favorites = favs;
    });
  }
  @override
  Widget build(BuildContext context) {
    int totalPages = (favorites.length / itemsPerPage).ceil();

    // Sayfadaki veriyi al
    List<Player> currentItems = favorites
        .skip(currentPage * itemsPerPage)
        .take(itemsPerPage)
        .toList();

    return SafeArea(
      child: Scaffold(
        body: favorites.isEmpty
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
                                  Color.fromARGB(248, 83, 83, 83),
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
                                            padding:
                                                const EdgeInsets.symmetric(
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
                            color: Color.fromARGB(255, 130, 129, 129),
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
