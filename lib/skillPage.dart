import 'package:careerfilter/list_with_text.dart';
import 'package:flutter/material.dart';

class SkillPage extends StatelessWidget {
  const SkillPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 33, 15, 150),
          foregroundColor: Colors.white,
          title: Text("List of Skill Moves", style: TextStyle(color: Colors.white),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    "What is skill moves?",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("    Skill moves are the way to show your ability of playmaking, each of your players have different skill ability numbered from 1 to 5. You can benefit from the list given below to see effectiveness of skills: "),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "1 Star Skill Moves",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.normal, color: const Color.fromARGB(255, 33, 15, 150)),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: SkillList(
                      skills: [
                        'Directional Nutmeg',
                        'Flick Up',
                        'Open Up Fake Shot',
                        'Ball Juggle',
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "2 Star Skill Moves",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.normal, color: const Color.fromARGB(255, 33, 15, 150)),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: SkillList(
                      skills: [
                        "Stepover Moves",
                        "Reverse Stepover Moves",
                        "Body Feint Right / Left",
                        "Feint Forward and Turn",
                        "Ball Roll Right / Left"
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "3 Star Skill Moves",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.normal, color: const Color.fromARGB(255, 33, 15, 150)),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: SkillList(
                      skills: [
                        "Heel Flick",
                        "Stutter Feint",
                        "Fake Left Go Right",
                        "Fake Right Go Left",
                        "Roulette",
                        "Feint Left Exit Right",
                        "Feint Right Exit Left"
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "4 Star Skill Moves",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.normal, color: const Color.fromARGB(255, 33, 15, 150)),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: SkillList(
                      skills: [
                        "Ball Hop",
                        "Spin Right / Left",
                        "Rainbow",
                        "Stop and Turn Right / Left",
                        "Quick Ball Rolls",
                        "Three Touch Roulette Right / Left",
                        "Heel to Ball Roll",
                        "Flair Nutmegs"
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "5 Star Skill Moves",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.normal, color: const Color.fromARGB(255, 33, 15, 150)),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: SkillList(
                      skills: [
                        "Elastico",
                        "Advanced Rainbow",
                        "Hocus Pocus",
                        "Triple Elastico",
                        "Heel Flick Turn",
                        "Turn and Spin",
                        "Ball Roll Fake",
                        "Spin Flick",
                        "Flick Over",
                        "Tornado Spin",
                        "Heel Fake"
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
