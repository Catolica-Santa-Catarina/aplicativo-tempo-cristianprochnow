import 'package:tempo_template/models/location.dart';
import 'package:tempo_template/models/weather.dart';
import 'package:tempo_template/services/location_service.dart';
import 'package:tempo_template/services/networking.dart';
import 'package:tempo_template/utilities/constants.dart';

class WeatherService {
  Future<Weather> getWeatherLocation() async {
    LocationService locationService = LocationService();
    Location location = await locationService.getCurrentLocation();

    var url = '$openWeatherUrl'
        '?lat=${location.latitude}'
        '&lon=${location.longitude}'
        '&units=metric'
        '&appid=$apiKey';

    NetworkHelper networkHelper = NetworkHelper(url);

    var networkData = await networkHelper.getData();

    return Weather.fromJson(networkData);
  }

  Future<Weather> getCityWeather(String cityName) async {
    String url = '$openWeatherUrl'
        '?q=$cityName'
        '&units=metric'
        '&appid=$apiKey';

    NetworkHelper networkHelper = NetworkHelper(url);
    var networkData = await networkHelper.getData();
    Weather weatherData = Weather.fromJson(networkData);

    return weatherData;
  }
}