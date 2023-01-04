import 'dart:collection';
import 'dart:convert';

import 'package:floor/floor.dart';

import '../entity/city_entity.dart';


class CoordEntityConverter extends TypeConverter<CoordEntity?, String> {
  @override
  CoordEntity? decode(String databaseValue) {
    try {
      return CoordEntity.fromJson(jsonDecode(databaseValue));
    }
    catch (e) {
      return null;
    }
  }

  @override
  String encode(CoordEntity? value) {
    return jsonEncode(value);
  }
}

class MainEntityConverter extends TypeConverter<MainEntity?, String> {
  @override
  MainEntity? decode(String databaseValue) {
    try {
      return MainEntity.fromJson(jsonDecode(databaseValue));
    }
    catch (e) {
      return null;
    }

  }

  @override
  String encode(MainEntity? value) {
    return jsonEncode(value);
  }
}

class WindEntityConverter extends TypeConverter<WindEntity?, String> {
  @override
  WindEntity? decode(String databaseValue) {
    try {
      return WindEntity.fromJson(jsonDecode(databaseValue));
    }
    catch (e) {
      return null;
    }
  }

  @override
  String encode(WindEntity? value) {
    return jsonEncode(value);
  }
}

class RainEntityConverter extends TypeConverter<RainEntity?, String> {
  @override
  RainEntity? decode(String databaseValue) {
    try {
      return RainEntity.fromJson(jsonDecode(databaseValue));
    }
    catch (e) {
      return null;
    }
  }

  @override
  String encode(RainEntity? value) {
    return jsonEncode(value);
  }
}

class CloudsEntityConverter extends TypeConverter<CloudsEntity?, String> {
  @override
  CloudsEntity? decode(String databaseValue) {
    try {
      return CloudsEntity.fromJson(jsonDecode(databaseValue));
    }
    catch (e) {
      return null;
    }
  }

  @override
  String encode(CloudsEntity? value) {
    return jsonEncode(value);
  }
}

class SysEntityConverter extends TypeConverter<SysEntity?, String> {
  @override
  SysEntity? decode(String databaseValue) {
    try {
      return SysEntity.fromJson(jsonDecode(databaseValue));
    }
    catch (e) {
      return null;
    }
  }

  @override
  String encode(SysEntity? value) {
    return jsonEncode(value);
  }
}

class WeatherEntityConverter extends TypeConverter<WeatherEntity?, String> {
  @override
  WeatherEntity? decode(String databaseValue) {
    try {
      return WeatherEntity.fromJson(jsonDecode(databaseValue));
    }
    catch (e) {
      return null;
    }
  }

  @override
  String encode(WeatherEntity? value) {
    return jsonEncode(value);
  }
}

class WeatherListConverter extends TypeConverter<List<WeatherEntity?>?, String> {
  @override
  List<WeatherEntity?>? decode(String databaseValue) {
    try {
      List<WeatherEntity?>? weather = <WeatherEntity?>[];
      LinkedHashMap<String, dynamic> json = jsonDecode(databaseValue);
      if (json['weather'] != null) {
        json['weather'].forEach((v) {
          weather.add(WeatherEntity.fromJson(v));
        });
      }
      return weather;
    }
    catch (e) {
      return null;
    }
  }

  @override
  String encode(List<WeatherEntity?>? value) {
    final data = <String, dynamic>{};
    data.addAll({'weather': value});
    return jsonEncode(data);
  }
}