import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather/core/resources/response_state.dart';
import 'package:weather/data/datasource/cache/abstraction/weather_cache_data_source.dart';
import 'package:weather/data/datasource/cache/mapper/CurrentWeatherMapper.dart';
import 'package:weather/data/datasource/network/abstraction/weather_network_data_source.dart';
import 'package:weather/domain/model/current_weather_model.dart';
import 'package:weather/domain/model/suggest_city_model.dart';
import 'package:weather/domain/repository/weather_repository.dart';
import 'package:weather/domain/model/forecast_weather_model.dart';
import '../datasource/cache/entity/city_entity.dart';
import '../datasource/network/dto/current_weather_dto.dart';
import '../datasource/network/dto/forecast_weather_dto.dart';
import '../datasource/network/dto/suggest_city_dto.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherNetworkDataSource weatherNetworkDataSource;
  WeatherCacheDataSource weatherCacheDataSource;
  CurrentWeatherMapper currentWeatherMapper;
  WeatherRepositoryImpl(this.weatherNetworkDataSource, this.weatherCacheDataSource, this.currentWeatherMapper);

  @override
  Future<DataState<CurrentWeatherModel>> getCurrentWeather(String city) async {
    try {
      Response response = await weatherNetworkDataSource.getCurrentWeather(city);
      if (response.statusCode == 200) {
        CurrentWeatherModel currentWeatherModel = CurrentWeatherDTO.fromJson(response.data);
        CurrentWeatherEntity currentWeatherEntity = currentWeatherMapper.mapToEntity(currentWeatherModel);
        weatherCacheDataSource.insertCity(currentWeatherEntity);
        return getCurrentWeatherFromCache(currentWeatherEntity.name!);
      }
      else {
        return DataFailed("Something Went Wrong. try again...");
      }
    }
    catch(e) {
      print(e.toString());
      return DataFailed("please check your connection...");
    }

  }

  @override
  Future<DataState<ForecastWeatherModel>> getWeatherForecast(double lat, double lon) async {
    try{
      Response response = await weatherNetworkDataSource.getWeatherForecast(lat, lon);
      if(response.statusCode == 200){
        ForecastWeatherModel forecastDaysModel = ForecastWeatherDTO.fromJson(response.data);

        return DataSuccess(forecastDaysModel);
      }else{
        return DataFailed("Something Went Wrong. try again...");
      }
    }catch(e){
      print(e.toString());
      return DataFailed("please check your connection...");
    }
  }

  @override
  Future<List<SuggestCityModel>> getCitySuggestion(String cityName) async {
    Response response = await weatherNetworkDataSource.getCitySuggestion(cityName);
    List<SuggestCityModel>? suggestCityModel = List.empty(growable: true);
    for (var item in response.data) {
      suggestCityModel.add(SuggestCityDTO.fromJson(item));
    }
    return suggestCityModel;
  }

  @override
  Future<DataState<CurrentWeatherModel>> getCurrentWeatherFromCache(String city) async {
    try{
      CurrentWeatherEntity? currentWeatherEntity = await weatherCacheDataSource.findCityByName(city);
      if (currentWeatherEntity != null) {
        CurrentWeatherModel currentWeatherModel = currentWeatherMapper.mapFromEntity(currentWeatherEntity);
        return DataSuccess(currentWeatherModel);
      }
      else {
        return DataFailed("error...");
      }

    }catch(e){
      print(e.toString());
      return DataFailed("error...");
    }
  }

}
