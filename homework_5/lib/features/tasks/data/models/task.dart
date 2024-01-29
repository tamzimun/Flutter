import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  fetchData();
}

void fetchData() async {
  final url = 'https://jsonplaceholder.typicode.com/todos';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      processTodos(data);
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error: $e');
  }
}

void processTodos(List<dynamic> todos) {
  for (var todo in todos) {
    print('Title: ${todo['title']}, Completed: ${todo['completed']}');
  }
}