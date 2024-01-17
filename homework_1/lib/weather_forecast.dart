import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchWeatherData(String city, String apiKey) async {
  final apiUrl = 'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return {'success': true, 'data': response.body};
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
      return {'success': false, 'error': 'Failed to fetch data'};
    }
  } catch (e) {
    print('Failed to connect: $e');
    return {'success': false, 'error': 'Failed to connect'};
  }
}

void updateWeatherUI(Map<String, dynamic> weatherData) {
  // Implement logic to update the UI with weather information
  // For example, display temperature, weather description, etc.
}