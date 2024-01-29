import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:homework_5/features/tasks/data/models/task.dart';

class TaskRepository {
  Future<List<Task>> getTasksFromApi() async {
    final url = 'https://jsonplaceholder.typicode.com/todos';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Task.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}

class Task {
  int id;
  String title;
  bool completed;

  Task({required this.id, required this.title, required this.completed});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}