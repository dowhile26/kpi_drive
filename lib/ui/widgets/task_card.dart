import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String name;
  const TaskCard({super.key, this.name = ''});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: const Color(0xFF2C2B31),
      child: SizedBox(
        width: 200,
        child: Padding(padding: const EdgeInsets.all(12), child: Text(name)),
      ),
    );
  }
}
