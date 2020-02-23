import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';

const openWeatherAPIKey = 'a4b19dd39c40d86db3ec04638d848479';
const openWeatherLocationURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    String query = '$openWeatherLocationURL?lat=${location
        .latitude}&lon=${location
        .longitude}&appid=$openWeatherAPIKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url: query);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityWeather({String city}) async {
    String query ='$openWeatherLocationURL?q=$city&appid=$openWeatherAPIKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url: query);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
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

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
