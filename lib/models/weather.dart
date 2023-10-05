class Weather {
  final String cityName;
  final int temperature;
  final int condition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json["name"],
      temperature: json["main"]["temp"].toInt(),
      condition: json["weather"][0]["id"]
    );
  }

  String getWeatherIcon() {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage() {
    if (temperature > 25) {
      return 'É tempo de 🍦';
    } else if (temperature > 20) {
      return 'O tempo está bom para bermuda e 👕';
    } else if (temperature < 10) {
      return 'Você precisará de 🧣 e 🧤';
    } else {
      return 'Leve um 🧥';
    }
  }
}