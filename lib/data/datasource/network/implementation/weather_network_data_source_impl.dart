import 'package:dio/dio.dart';
import 'package:weather/core/utils/constants.dart';
import 'package:weather/data/datasource/network/abstraction/weather_network_data_source.dart';

class WeatherNetworkDataSourceImpl implements WeatherNetworkDataSource {
  Dio _dio;
  WeatherNetworkDataSourceImpl(this._dio);
  
  @override
  Future<Response<dynamic>> getCurrentWeather(String city) async {
    var response = await _dio.get("${Constants.BASE_URL}/data/2.5/weather",
        queryParameters: {
          'q': city,
          'appid': Constants.API_KEY,
          'units': 'metric'
        });
    return response;
  }

  @override
  Future<Response<dynamic>> getWeatherForecast(double lat, double lon) async {

    var response = await _dio.get(

        "${Constants.BASE_URL}/data/2.5/onecall",
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'exclude': 'minutely,hourly',
          'appid': Constants.API_KEY,
          'units': 'metric'
        });

    return response;
  }

  /// city name suggest api
  // @override
  // Future<Response<dynamic>> getCitySuggestion(String prefix) async {
  //   var response = await _dio.get(
  //       "http://geodb-free-service.wirefreethought.com/v1/geo/cities",
  //       queryParameters: {'limit': 10, 'offset': 0, 'namePrefix': prefix});
  //
  //   return response;
  // }

  @override
  Future<Response<dynamic>> getCitySuggestion(String prefix) async {
    var response = await _dio.get(
        "${Constants.BASE_URL}/geo/1.0/direct",
        queryParameters: {
          'limit': 5,
          'appid': Constants.API_KEY,
          'q': prefix
        });

    return response;
  }

}
