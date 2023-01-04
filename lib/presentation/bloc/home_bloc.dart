import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/resources/response_state.dart';
import 'package:weather/presentation/bloc/current_weather_status.dart';
import 'package:weather/presentation/bloc/forecast_weather_status.dart';
import 'package:weather/domain/use_cases/current_weather_use_case.dart' as current_weather;
import 'package:weather/domain/use_cases/current_weather_cache_use_case.dart' as current_weather_cache;
import 'package:weather/domain/use_cases/forecast_weather_use_case.dart' as forecast_weather;
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  current_weather.CurrentWeatherUseCase currentWeatherUseCase;
  current_weather_cache.CurrentWeatherCacheUseCase currentWeatherCacheUseCase;
  forecast_weather.ForecastWeatherUseCase forecastWeatherUseCase;
  HomeBloc(this.currentWeatherUseCase, this.currentWeatherCacheUseCase, this.forecastWeatherUseCase) : super(HomeState(currentWeatherStatus: CurrentWeatherLoadingStatus(), forecastWeatherStatus: ForecastWeatherLoadingStatus(),)) {

    on<CurrentWeatherEvent>((event, emit) async {
      emit(state.copyWith(newCurrentWeatherStatus: CurrentWeatherLoadingStatus()));

      DataState responseResourceCache = await currentWeatherCacheUseCase(current_weather_cache.Params.forQuery(event.cityName));

      if (responseResourceCache is DataSuccess) {
        emit(state.copyWith(newCurrentWeatherStatus: CurrentWeatherLoadedStatus(responseResourceCache.data)));
      }

      if (responseResourceCache is DataFailed) {
        emit(state.copyWith(newCurrentWeatherStatus: CurrentWeatherErrorStatus(responseResourceCache.errorMessage)));
      }

      //

      DataState responseResourceNetwork = await currentWeatherUseCase(current_weather.Params.forQuery(event.cityName));

      if (responseResourceNetwork is DataSuccess) {
        emit(state.copyWith(newCurrentWeatherStatus: CurrentWeatherLoadedStatus(responseResourceNetwork.data)));
      }

      if (responseResourceNetwork is DataFailed) {
        emit(state.copyWith(newCurrentWeatherStatus: CurrentWeatherErrorStatus(responseResourceNetwork.errorMessage)));
      }

      // SysEntity sysEntity = SysEntity(type: 1, id: 2, country: 'sna', sunrise: 15, sunset: 11);
      // String s = jsonEncode(sysEntity);
      // print("Here2 " + s);
      // SysEntity sysEntity2 = SysEntity.fromJson(jsonDecode(s));
      // print("Here2 " + sysEntity2.toString());

    });

    on<ForecastWeatherEvent>((event, emit) async {
      emit(state.copyWith(newForecastWeatherStatus: ForecastWeatherLoadingStatus()));
      DataState responseResource = await forecastWeatherUseCase(forecast_weather.Params.forQuery(event.lat, event.lon));

      if (responseResource is DataSuccess) {
        emit(state.copyWith(newForecastWeatherStatus: ForecastWeatherLoadedStatus(responseResource.data)));
      }

      if (responseResource is DataFailed) {
        emit(state.copyWith(newForecastWeatherStatus: ForecastWeatherErrorStatus(responseResource.errorMessage)));
      }
    });
  }
}
