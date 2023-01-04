import 'package:dio/dio.dart';

abstract class WeatherNetworkDataSource {

  Future<Response<dynamic>> getCurrentWeather(String city);
  Future<Response<dynamic>> getWeatherForecast(double lat, double lon);
  Future<Response<dynamic>> getCitySuggestion(String cityName);

}
