import 'package:flutter/material.dart';
import 'package:weather_forecast_sagara_test/models/weather_list_res.dart';
import 'package:weather_forecast_sagara_test/models/weather_res.dart';
import 'package:weather_forecast_sagara_test/services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  late Future<WeatherResponse> weather;
  late Future<WeatherListResponse> weatherList;

  void getCurrentWeather(double latitude, double longitude) {
    weather = WeatherService.getCurrentWeather(latitude, longitude);
  }

  void getListWeather(double latitude, double longitude) {
    weatherList = WeatherService.getListWeather(latitude, longitude);
  }
}
