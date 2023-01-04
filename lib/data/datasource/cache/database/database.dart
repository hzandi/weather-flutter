import 'package:floor/floor.dart';
import '../entity/city_entity.dart';
import 'city_dao.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'type_converters.dart';

part 'database.g.dart'; // the generated code will be there

@TypeConverters([CoordEntityConverter, MainEntityConverter, WindEntityConverter, RainEntityConverter, CloudsEntityConverter, SysEntityConverter, WeatherEntityConverter, WeatherListConverter])
@Database(version: 1, entities: [CurrentWeatherEntity])
abstract class AppDatabase extends FloorDatabase {
  CurrentWeatherDao get currentWeatherDao;
}