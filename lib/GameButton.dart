import 'package:flutter/material.dart';
import 'package:careerfilter/SearchPage.dart';

class GameButton extends StatelessWidget {
  final String
      gamename; // Why does the constructor throw error when I don't add final keyword?

  const GameButton({super.key, required this.gamename});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(top: 30, right: 55),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 33, 15, 150),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        ),
        child: TextButton(
          onPressed: () {
            print('$gamename seçildi');
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(game1: gamename,)), );
          },
          child: Center(
            child: Text(
              gamename,
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
