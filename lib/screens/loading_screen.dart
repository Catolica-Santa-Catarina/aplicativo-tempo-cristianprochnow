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

  Future<void> getLocation() async {
    await location.getCurrentLocation();
  }

  Future<void> getData() async {
    double lat = location.latitude ?? 35;
    double lon = location.longitude ?? 139;

    var url = Uri.parse(
      'https://samples.openweathermap.org/data/2.5/weather'
      '?lat=$lat&lon=$lon&appid=b6907d289e10d714a6e88b30761fae22'
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
    await getLocation();
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
