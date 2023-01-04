import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/data/datasource/cache/abstraction/weather_cache_data_source.dart';
import 'package:weather/data/repository/weather_repository_impl.dart';
import 'package:weather/domain/repository/weather_repository.dart';
import 'package:weather/domain/use_cases/get_suggestion_city_use_case.dart';
import 'package:weather/presentation/bloc/home_bloc.dart';
import 'data/datasource/cache/database/database.dart';
import 'data/datasource/cache/implementation/weather_cache_data_source_impl.dart';
import 'data/datasource/cache/mapper/CurrentWeatherMapper.dart';
import 'data/datasource/network/abstraction/weather_network_data_source.dart';
import 'data/datasource/network/implementation/weather_network_data_source_impl.dart';
import 'domain/use_cases/current_weather_cache_use_case.dart';
import 'domain/use_cases/current_weather_use_case.dart';
import 'domain/use_cases/forecast_weather_use_case.dart';

GetIt locator = GetIt.instance;

setupInjection() async{
  locator.registerSingleton<Dio>(Dio());

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<AppDatabase>(database);
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
  locator.registerSingleton<CurrentWeatherMapper>(CurrentWeatherMapper());
  locator.registerSingleton<WeatherNetworkDataSource>(WeatherNetworkDataSourceImpl(locator()));
  locator.registerSingleton<WeatherCacheDataSource>(WeatherCacheDataSourceImpl(database.currentWeatherDao));
  locator.registerSingleton<WeatherRepository>(WeatherRepositoryImpl(locator(), locator(), locator()));
  locator.registerSingleton<CurrentWeatherUseCase>(CurrentWeatherUseCase(locator()));
  locator.registerSingleton<CurrentWeatherCacheUseCase>(CurrentWeatherCacheUseCase(locator()));
  locator.registerSingleton<ForecastWeatherUseCase>(ForecastWeatherUseCase(locator()));
  locator.registerSingleton<GetSuggestionCityUseCase>(GetSuggestionCityUseCase(locator()));
  locator.registerSingleton<HomeBloc>(HomeBloc(locator(), locator(), locator()));
}
