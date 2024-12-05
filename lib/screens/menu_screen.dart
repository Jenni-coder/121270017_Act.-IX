import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/clima_Ciudad.dart';
import 'package:flutter_application_1/screens/clima_Coordenadas.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Container(
        decoration: BoxDecoration(
          // Fondo con color sólido
          color: const Color.fromARGB(255, 191, 223, 236),
          
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WeatherByCoordinatesScreen(),
                    ),
                  );
                },
                child: const Text('Consultar Clima por Coordenadas'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WeatherByCityScreen(),
                    ),
                  );
                },
                child: const Text('Consultar Clima por Ciudad'),
              ),
            ],
          ),
        ),
     ),
);
}
}
