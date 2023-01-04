// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CurrentWeatherDao? _currentWeatherDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CurrentWeatherEntity` (`id` INTEGER, `weather` TEXT, `coord` TEXT, `base` TEXT, `main` TEXT, `visibility` INTEGER, `wind` TEXT, `rain` TEXT, `clouds` TEXT, `dt` INTEGER, `sys` TEXT, `timezone` INTEGER, `name` TEXT, `cod` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CurrentWeatherDao get currentWeatherDao {
    return _currentWeatherDaoInstance ??=
        _$CurrentWeatherDao(database, changeListener);
  }
}

class _$CurrentWeatherDao extends CurrentWeatherDao {
  _$CurrentWeatherDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _currentWeatherEntityInsertionAdapter = InsertionAdapter(
            database,
            'CurrentWeatherEntity',
            (CurrentWeatherEntity item) => <String, Object?>{
                  'id': item.id,
                  'weather': _weatherListConverter.encode(item.weather),
                  'coord': _coordEntityConverter.encode(item.coord),
                  'base': item.base,
                  'main': _mainEntityConverter.encode(item.main),
                  'visibility': item.visibility,
                  'wind': _windEntityConverter.encode(item.wind),
                  'rain': _rainEntityConverter.encode(item.rain),
                  'clouds': _cloudsEntityConverter.encode(item.clouds),
                  'dt': item.dt,
                  'sys': _sysEntityConverter.encode(item.sys),
                  'timezone': item.timezone,
                  'name': item.name,
                  'cod': item.cod
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CurrentWeatherEntity>
      _currentWeatherEntityInsertionAdapter;

  @override
  Future<CurrentWeatherEntity?> findCityByName(String name) async {
    return _queryAdapter.query(
        'SELECT * FROM CurrentWeatherEntity WHERE name = ?1',
        mapper: (Map<String, Object?> row) => CurrentWeatherEntity(
            id: row['id'] as int?,
            weather: _weatherListConverter.decode(row['weather'] as String),
            coord: _coordEntityConverter.decode(row['coord'] as String),
            base: row['base'] as String?,
            main: _mainEntityConverter.decode(row['main'] as String),
            visibility: row['visibility'] as int?,
            wind: _windEntityConverter.decode(row['wind'] as String),
            rain: _rainEntityConverter.decode(row['rain'] as String),
            clouds: _cloudsEntityConverter.decode(row['clouds'] as String),
            dt: row['dt'] as int?,
            sys: _sysEntityConverter.decode(row['sys'] as String),
            timezone: row['timezone'] as int?,
            name: row['name'] as String?,
            cod: row['cod'] as int?),
        arguments: [name]);
  }

  @override
  Future<int> insertCity(CurrentWeatherEntity currentWeatherEntity) {
    return _currentWeatherEntityInsertionAdapter.insertAndReturnId(
        currentWeatherEntity, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _coordEntityConverter = CoordEntityConverter();
final _mainEntityConverter = MainEntityConverter();
final _windEntityConverter = WindEntityConverter();
final _rainEntityConverter = RainEntityConverter();
final _cloudsEntityConverter = CloudsEntityConverter();
final _sysEntityConverter = SysEntityConverter();
final _weatherEntityConverter = WeatherEntityConverter();
final _weatherListConverter = WeatherListConverter();
