import 'package:floor/floor.dart';

import '../entity/city_entity.dart';

@dao
abstract class CurrentWeatherDao {

  @Query('SELECT * FROM CurrentWeatherEntity WHERE name = :name')
  Future<CurrentWeatherEntity?> findCityByName(String name);

  @insert
  Future<int> insertCity(CurrentWeatherEntity currentWeatherEntity);

}

