import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> fetchNews() async {
  final String apiKey = 'c5561d94070449daab96fe5c08c1d9f0';
  final String apiUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> articles = jsonResponse['articles'];
      List<String> titles = [];

      for (var article in articles) {
        String title = article['title'];
        titles.add(title);
        print('Title: $title');
      }

      await saveToFile(titles);
    } else {
      print('Error fetching data: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}

Future<void> saveToFile(List<String> news) async {
  final file = await _localFile;
  final sink = file.openWrite(mode: FileMode.append);

  for (var article in news) {
    sink.writeln(article);
  }

  await sink.flush();
  await sink.close();
}

Future<void> readFromFile() async {
  try {
    final file = File('news.txt');
    if (await file.exists()) {
      final contents = await file.readAsString();
      print('Содержимое файла: $contents');
    } else {
      print('Файл не найден.');
    }
  } catch (e) {
    print('Произошла ошибка при чтении файла: $e');
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/news.txt');
}