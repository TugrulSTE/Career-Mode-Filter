import 'package:flutter/material.dart';

class SkillList extends StatelessWidget {
  final List<String> skills;

  const SkillList({Key? key, required this.skills}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: skills.map((skill) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Text('• $skill'),
        );
      }).toList(),
    );
  }
}
