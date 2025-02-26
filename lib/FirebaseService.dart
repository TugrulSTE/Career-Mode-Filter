import 'package:careerfilter/player.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference db = FirebaseDatabase.instance.ref();

  Future<List<Player>> getPlayers() async {
    try {
      DataSnapshot ss = (await db.child("players").once()) as DataSnapshot;
      if (ss.value != null) {
        Map<String, dynamic> data = Map<String, dynamic>.from(ss.value as Map);
        List<Player> players = [];
        data.forEach((key, value) {
          var p = Player(
              name: value["name"],
              age: value["age"],
              potential: value["potential"],
              overall: value["overall"],
              value: value["value"],
              club: value["club"]);
        players.add(p);
        });
        return players;
      }
    } catch (e) {
      print("object");
      return [];
    }
    return [];
  }
}
