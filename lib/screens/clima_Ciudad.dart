import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherByCityScreen extends StatefulWidget {
  const WeatherByCityScreen({super.key});

  @override
  _WeatherByCityScreenState createState() => _WeatherByCityScreenState();
}

class _WeatherByCityScreenState extends State<WeatherByCityScreen> {
  final TextEditingController _cityController = TextEditingController();
  String _weatherData = '';

  Future<void> fetchWeather(String city) async {
    const apiKey = '14213b2206beba2ea5abfe6903f20015'; 
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _weatherData = '''
          🌍 Ciudad: ${data['name']}
          🌤 Clima: ${data['weather'][0]['description']}
          🌡 Temperatura: ${data['main']['temp']}°C
          💧 Humedad: ${data['main']['humidity']}%
          ''';
        });
      } else {
        final errorData = json.decode(response.body);
        setState(() {
          _weatherData = 'Error: ${errorData['message']}';
        });
      }
    } catch (e) {
      setState(() {
        _weatherData = 'Ocurrió un error al obtener los datos del clima.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clima por Ciudad')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Nombre de la Ciudad',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final city = _cityController.text.trim();
                if (city.isNotEmpty) {
                  fetchWeather(city);
                } else {
                  setState(() {
                    _weatherData = 'Por favor, ingresa un nombre de ciudad.';
                  });
                }
              },
              child: const Text('Consultar Clima'),
            ),
            const SizedBox(height: 20),
            Text(
              _weatherData,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
     ),
);
}
}