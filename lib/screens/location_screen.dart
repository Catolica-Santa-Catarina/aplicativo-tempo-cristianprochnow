import 'package:flutter/material.dart';
import 'package:tempo_template/models/weather.dart';
import 'package:tempo_template/screens/city_screen.dart';
import 'package:tempo_template/services/weather.dart';
import 'package:tempo_template/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final Weather weather;

  const LocationScreen({
    required this.weather,
    Key? key
  }) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late Weather weather;
  late String message;
  late String weatherIcon;

  void updateUI(Weather weather) {
    setState(() {
      this.weather = weather;
      message = this.weather.getMessage();
      weatherIcon = this.weather.getWeatherIcon();
    });
  }

  @override
  void initState() {
    super.initState();

    weather = widget.weather;
    updateUI(weather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      Weather weather = await WeatherService().getWeatherLocation();

                      updateUI(weather);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const CityScreen()
                      ));

                      if (cityName != null) {
                        Weather weatherData = await WeatherService()
                            .getCityWeather(cityName);
                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      '${weather.temperature.toString()}º',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message em ${weather.cityName.toString()}',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
