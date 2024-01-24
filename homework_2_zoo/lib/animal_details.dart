import 'package:flutter/material.dart';

class AnimalDetails extends StatefulWidget {
  final String name;
  final String description;
  final String image;

  AnimalDetails({required this.name, required this.description, required this.image});

  @override
  _AnimalDetailsState createState() => _AnimalDetailsState();
}

class _AnimalDetailsState extends State<AnimalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/${widget.image}',
              width: 300,
              height: 300,
            ),
            SizedBox(height: 16),
            Text(widget.name),
            SizedBox(height: 8),
            Text(widget.description),
            // Добавьте фотографию, информацию и интерактивные элементы по необходимости
          ],
        ),
      ),
    );
  }
}