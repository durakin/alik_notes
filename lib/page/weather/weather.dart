import 'dart:async';

import 'package:alik_notes/weather_service/weather.dart';
import 'package:flutter/material.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late Future<Weather> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Погода в Красноярске сейчас'),
      ),
      body: Center(
        child: FutureBuilder<Weather>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Card(
                child: ListTile(
                  title: Text(
                    snapshot.data!.description,
                    style: const TextStyle(color: Colors.white),
                  ),
                  leading: snapshot.data!.icon,
                ),
                color: const Color(0xff263238),
              );
            } else if (snapshot.hasError) {
              return const Text('Ошибка при загрузке погоды');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
