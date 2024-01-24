import 'package:flutter/material.dart';
import 'animal_details.dart';

class AnimalList extends StatelessWidget {
  final List<Map<String, dynamic>> animals = [
    {'name': 'Lion', 'description': 'The king of the jungle', 'image': 'lion.jpeg'},
    {'name': 'Elephant', 'description': 'Gentle giant with a trunk', 'image': 'elephant.jpeg'},
    {'name': 'Monkey', 'description': 'Playful and agile', 'image': 'monkey.jpeg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of animals'),
      ),
      body: ListView.builder(
        itemCount: animals.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(animals[index]['name']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimalDetails(
                    name: animals[index]['name'],
                    description: animals[index]['description'],
                    image: animals[index]['image'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}