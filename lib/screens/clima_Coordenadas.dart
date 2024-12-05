import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherByCoordinatesScreen extends StatefulWidget {
  const WeatherByCoordinatesScreen({super.key});

  @override
  _WeatherByCoordinatesScreenState createState() =>
      _WeatherByCoordinatesScreenState();
}

class _WeatherByCoordinatesScreenState
    extends State<WeatherByCoordinatesScreen> {
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  String _weatherData = '';
  bool _isLoading = false;

  Future<void> fetchWeather(double lat, double lon) async {
    const apiKey = '14213b2206beba2ea5abfe6903f20015'; 
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    setState(() {
      _isLoading = true; 
    });

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
    } finally {
      setState(() {
        _isLoading = false; // Ocultar indicador de carga
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clima por Coordenadas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _latitudeController,
              decoration: const InputDecoration(
                labelText: 'Latitud',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _longitudeController,
              decoration: const InputDecoration(
                labelText: 'Longitud',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final lat = double.tryParse(_latitudeController.text.trim());
                final lon = double.tryParse(_longitudeController.text.trim());
                if (lat != null && lon != null) {
                  fetchWeather(lat, lon);
                } else {
                  setState(() {
                    _weatherData = 'Por favor, ingresa valores válidos.';
                  });
                }
              },
              child: const Text('Consultar Clima'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Text(
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