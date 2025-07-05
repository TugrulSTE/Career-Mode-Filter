import 'package:careerfilter/search_view_model.dart';
import 'package:careerfilter/skillPage.dart';
import 'package:careerfilter/topImage.dart';
import 'package:flutter/material.dart';
import 'GameButton.dart';
import 'package:provider/provider.dart';
void main() {
  
  runApp(ChangeNotifierProvider(
      create: (_) => SearchViewModel(), // ViewModel bağlandı
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Career Filter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
                      color: const Color.fromARGB(255, 33, 15, 150)),
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  GameButton(gamename: "FIFA 22"),
               
                  SizedBox(height: 10,),
                ],
              )),
            
            ],
            
          ),
          bottomNavigationBar: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
                      image: AssetImage(
                          "lib/assets/images/abstract_blue.jpg"),
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


