import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tempo_template/models/weather.dart';

import 'package:tempo_template/models/location.dart';
import 'package:tempo_template/screens/location_screen.dart';
import 'package:tempo_template/services/location_service.dart';
import 'package:tempo_template/services/networking.dart';
import 'package:tempo_template/utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<Location> getLocation() async {
    LocationService locationService = LocationService();
    Location location = await locationService.getCurrentLocation();

    return location;
  }

  Future<void> getData() async {
    Location location = await getLocation();

    var url = 'https://api.openweathermap.org/data/2.5/weather'
      '?lat=${location.latitude}'
      '&lon=${location.longitude}'
      '&units=metric'
      '&appid=$apiKey';

    NetworkHelper networkHelper = NetworkHelper(url);

    var networkData = await networkHelper.getData();

    pushToLocationScreen(
      Weather.fromJson(networkData)
    );
  }

  Future<void> getInfo() async {
    await getData();
  }

  void onPressedGetLocation() {}

  void pushToLocationScreen(Weather weather) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => LocationScreen(
        weather: weather,
      )
    ));
  }

  @override
  void initState() {
    super.initState();

    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
