import 'package:careerfilter/topImage.dart';
import 'package:flutter/material.dart';
import 'GameButton.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Career Filter',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              // Mavi bölüm
              topImage(),
              // Buraya alt kısımda eklemek istediğiniz padding'li içerik
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'SELECT A GAME',
                  style: TextStyle(
                      fontSize: 23,
                      color: const Color.fromARGB(255, 114, 10, 48)),
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  GameButton(gamename: "FIFA 22"),
                  GameButton(gamename: "FIFA 18"),
                  
                  GameButton(gamename: "FIFA 16")
                ],
              )),
            
            ],
            
          ),
          bottomNavigationBar: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
                      image: AssetImage(
                          "lib/assets/images/magenta-abstract-3840x2160-18139.png"),
                      fit: BoxFit.cover),
    ),
    height: 50,
    child: Center(
      child: Text(
        "Find Players For Your Team !",
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    ),
  ),
        ),
      ),
    );

  }
}


