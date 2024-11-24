import 'package:flutter/material.dart';

class NamePerson extends StatelessWidget {
  final String name;
  const NamePerson({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            name, 
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey
          )
        ),
          const Icon(
            Icons.person,
            color: Colors.grey
          )
        ],
      ),
    );
  }
}