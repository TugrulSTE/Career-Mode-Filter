
class Player {

  String name;
  double value;
  int overall;
  int potential;
  int age;
  String club;
  int skills;
  Player({
    required this.name,
    required this.age,
    required this.potential,
    required this.overall,
    required this.value,
    required this.club,
    required this.skills,
    });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'potential': potential,
      'overall': overall,
      'value': value,
      'club': club,
      'skills' : skills,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      name: map['name'],
      age: map['age'],
      potential: map['potential'],
      overall: map['overall'],
      value: map['value'],
      club: map['club'],
      skills: map['skills'],
    );
  }
  
}