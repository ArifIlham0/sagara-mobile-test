import 'package:http/http.dart' as https;
import 'package:weather_forecast_sagara_test/models/weather_list_res.dart';
import 'package:weather_forecast_sagara_test/models/weather_res.dart';
import 'package:geolocator/geolocator.dart';

class WeatherService {
  static var client = https.Client();

  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<WeatherResponse> getCurrentWeather(
      double latitude, double longitude) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };

    var url = Uri.https("api.openweathermap.org", "/data/2.5/weather", {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'appid': '2a14256e4366b30d7a77be55f8c55549'
    });
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var weather = weatherResponseFromJson(response.body);
      return weather;
    } else {
      throw Exception('Failed to get current weather');
    }
  }

  static Future<WeatherListResponse> getListWeather(
      double latitude, double longitude) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };

    var url = Uri.https("api.openweathermap.org", "/data/2.5/forecast", {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'appid': '2a14256e4366b30d7a77be55f8c55549'
    });
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var weatherList = weatherListResponseFromJson(response.body);
      return weatherList;
    } else {
      throw Exception('Failed to get list weather');
    }
  }
}
