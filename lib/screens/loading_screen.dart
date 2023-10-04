import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tempo_template/services/location.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location location = Location();
  String apiKey = '23760ad9ae5f8405406946d32fd49435';

  Future<void> getLocation() async {
    await location.getCurrentLocation();
  }

  Future<void> getData() async {
    await getLocation();

    double? lat = location.latitude;
    double? lon = location.longitude;

    var url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather'
          '?lat=$lat'
          '&lon=$lon'
          '&unit=metrics'
          '&appid=$apiKey'
    );
    http.Response response = await http.get(url);
    
    if (response.statusCode == 200) { // se a requisição foi feita com sucesso
      var data = response.body;
      print(data);  // imprima o resultado
    } else {
      print(response.statusCode);  // senão, imprima o código de erro
    }
  }

  Future<void> getInfo() async {
    await getData();
  }

  void onPressedGetLocation() {}

  @override
  void initState() {
    super.initState();

    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: onPressedGetLocation,
          child: const Text('Obter Localização'),
        ),
      ),
    );
  }
}
