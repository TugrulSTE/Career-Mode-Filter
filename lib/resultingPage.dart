import 'package:careerfilter/CsvViewModel.dart';
import 'package:careerfilter/skillPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'player.dart';
import 'topImage.dart';
import 'package:intl/intl.dart';

class CsvExample extends StatelessWidget {
  const CsvExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CsvViewModel>(context);

    return SafeArea(
      child: Scaffold(
        body: vm.isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  topImage(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: vm.currentItems.length,
                      itemBuilder: (context, index) {
                        Player row = vm.currentItems[index];
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
                                    width: MediaQuery.of(context).size.width * 0.08,
                                    height: MediaQuery.of(context).size.height * 0.1,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                vm.addToFavorites(row);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text("${row.name} favorilere eklendi!"),
                                                  ),
                                                );
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
                                                  builder: (context) => AlertDialog(
                                                    title: Text(row.name),
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Club: " +row.club, textAlign: TextAlign.left,),
                                                        SizedBox(height: 3,),
                                                        Row(children: [
                                                          Text("Skills: "),
                                                          ...List.generate(row.skills, 
                                                        (index) => Icon(Icons.star)),
                                                        ],),
                                                        SizedBox(height: 2,),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: TextButton(
                                                            onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => SkillPage(),))}, child: Text("Learn more about skill moves"),),
                                                        )
                                                        ,
                                                      ],
                                                    ),
                                                  ),
                                                );
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
                        onPressed: vm.currentPage > 0 ? vm.prevPage : null,
                        icon: Icon(Icons.arrow_back),
                      ),
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 94, 90, 192),
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                        child: Text("Sayfa: ${vm.currentPage + 1} / ${vm.totalPages}",
                            style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      IconButton(
                        onPressed: vm.currentPage < vm.totalPages - 1
                            ? vm.nextPage
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
