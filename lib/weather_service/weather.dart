import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Weather> fetchWeather() async {
  final response = await http
      .get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=55.994446&lon=92.797586&appid=0416cd11b0822dcdcf8f342dc9924b75&units=metric&lang=RU'));

  if (response.statusCode == 200) {

    return Weather.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load weather');
  }
}

class Weather {
  final int weatherId;
  final int temperature;
  final String weatherName;

  Icon get icon {
    int x = weatherId ~/ 100;
    if (weatherId == 800) {
      return const Icon(Icons.wb_sunny_outlined, color: Colors.white);
    }
    if (x == 8) {
      return const Icon(Icons.wb_cloudy_outlined, color: Colors.white);
    }
    if (x == 7) {
      return const Icon(Icons.foggy, color: Colors.white);
    }
    if (x == 6) {
      return const Icon(Icons.ac_unit_outlined, color: Colors.white);
    }
    if (x == 5 || x == 3) {
      return const Icon(Icons.beach_access_outlined, color: Colors.white);
    }
    if (x == 2) {
      return const Icon(Icons.bolt_outlined, color: Colors.white);
    }
    return const Icon(Icons.question_mark_outlined, color: Colors.white);
  }

  String get description {
    return "${temperature > 0 ? '+' : '-'}$temperature, $weatherName";
  }

  const Weather({
    required this.weatherId,
    required this.temperature,
    required this.weatherName,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      weatherId: json['weather'][0]['id'],
      weatherName: json['weather'][0]['description'],
      temperature: json['main']['temp'],
    );
  }
}
