import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/utils/constants.dart';
import 'package:weather/core/utils/date_utils.dart';
import 'package:weather/core/widgets/custom_loading_animation.dart';
import 'package:weather/core/widgets/dot_loading_widget.dart';
import 'package:weather/domain/model/current_weather_model.dart' as current_weather_model;
import 'package:weather/domain/model/suggest_city_model.dart';
import 'package:weather/presentation/bloc/current_weather_status.dart';
import 'package:weather/presentation/bloc/forecast_weather_status.dart';
import 'package:weather/presentation/bloc/home_bloc.dart';
import 'package:weather/presentation/widgets/days_weather_widget.dart';

import '../../../../locator.dart';
import '../../../../main.dart';
import '../../domain/model/forecast_weather_model.dart';
import '../../domain/use_cases/get_suggestion_city_use_case.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController(initialPage: 0);
  String weatherState = "";
  String icon = "";
  num temp = 0;
  num tempMin = 0;
  num tempMax = 0;
  late current_weather_model.CurrentWeatherModel currentWeatherModel;
  String cityName = Constants.DEFAULT_CITY_NAME;

  TextEditingController textEditingController = TextEditingController();

  // Inject
  late GetSuggestionCityUseCase getSuggestionCityUseCase = locator();
  late SharedPreferences sharedPreferences = locator();


  @override
  void initState() {
    super.initState();
    getCitySharedPreferences();
    BlocProvider.of<HomeBloc>(context).add(CurrentWeatherEvent(cityName));
  }

  getCitySharedPreferences() {
    cityName = sharedPreferences.getString('CityName') ?? Constants.DEFAULT_CITY_NAME;
  }

  void saveCitySharedPreferences(String cityName)  {
    sharedPreferences.setString('CityName', cityName);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        color: const Color.fromARGB(50, 0, 0, 0),
        child: Column(
          children: [
            SizedBox(height: 16,),
            createSearchBar(width, height),
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current){
                if(previous.currentWeatherStatus == current.currentWeatherStatus){
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                if (state.currentWeatherStatus is CurrentWeatherLoadingStatus) {
                  return const Expanded(child: CustomLoadingAnimation());
                } else if (state.currentWeatherStatus is CurrentWeatherLoadedStatus) {
                  saveCitySharedPreferences(cityName);
                  CurrentWeatherLoadedStatus currentWeatherLoadedStatus = state.currentWeatherStatus as CurrentWeatherLoadedStatus;
                  currentWeatherModel = currentWeatherLoadedStatus.currentWeatherModel;

                  var isWeatherListNotEmpty = currentWeatherModel.weather?.isNotEmpty ?? false;
                  if (isWeatherListNotEmpty) {
                    weatherState = currentWeatherModel.weather?[0]?.description ?? "";
                    icon = currentWeatherModel.weather?[0]?.icon ?? "";
                    temp = currentWeatherModel.main?.temp?.round() ?? 0;
                    tempMin = currentWeatherModel.main?.tempMin?.round() ?? 0;
                    tempMax = currentWeatherModel.main?.tempMax?.round() ?? 0;
                  }

                  BlocProvider.of<HomeBloc>(context).add(ForecastWeatherEvent(currentWeatherModel.coord!.lat!.toDouble(), currentWeatherModel.coord!.lon!.toDouble()));

                  final sunrise = DateConverter.changeDtToDateTimeHour(currentWeatherModel.sys!.sunrise,currentWeatherModel.timezone);
                  final sunset =  DateConverter.changeDtToDateTimeHour(currentWeatherModel.sys!.sunset,currentWeatherModel.timezone);

                  return Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 400,
                          child: createFirstPageView(),
                        ),
                        const SizedBox(height: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
                          child: Container(
                            color: Colors.white24,
                            height: 2,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(height: 24,),
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.13,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: BlocBuilder<HomeBloc, HomeState>(
                                buildWhen: (previous, current){
                                  if(previous.forecastWeatherStatus == current.forecastWeatherStatus){
                                    return false;
                                  }
                                  return true;
                                },
                                builder: (BuildContext context, state) {

                                  if (state.forecastWeatherStatus is ForecastWeatherLoadingStatus) {
                                    return const DotLoadingWidget();
                                  }

                                  if (state.forecastWeatherStatus is ForecastWeatherLoadedStatus) {
                                    final ForecastWeatherLoadedStatus forecastWeatherLoadedStatus = state.forecastWeatherStatus as ForecastWeatherLoadedStatus;
                                    final ForecastWeatherModel forecastWeatherModel = forecastWeatherLoadedStatus.forecastWeatherModel;
                                    final List<DailyModel> mainDaily = forecastWeatherModel.daily!;

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: mainDaily.length,
                                      itemBuilder: (BuildContext context,
                                          int index,) {
                                        return DaysWeatherWidget(
                                          dailyModel: mainDaily[index],);
                                      },);
                                  }

                                  if (state.forecastWeatherStatus is ForecastWeatherErrorStatus) {
                                    ForecastWeatherErrorStatus forecastWeatherErrorStatus = state.forecastWeatherStatus as ForecastWeatherErrorStatus;
                                    return Center(child: Text(forecastWeatherErrorStatus.message));
                                  }

                                  return Container();

                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0, bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text("Wind speed",
                                    style: TextStyle(
                                      fontSize: height * 0.017, color: Colors.amber,),),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      "${currentWeatherModel.wind!.speed!} m/s",
                                      style: TextStyle(
                                        fontSize: height * 0.016,
                                        color: Colors.white,),),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  color: Colors.white24,
                                  height: 30,
                                  width: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  children: [
                                    Text("Sunrise",
                                      style: TextStyle(
                                        fontSize: height * 0.017,
                                        color: Colors.amber,),),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 10.0),
                                      child: Text(sunrise,
                                        style: TextStyle(
                                          fontSize: height * 0.016,
                                          color: Colors.white,),),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  color: Colors.white24,
                                  height: 30,
                                  width: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(children: [
                                  Text("Sunset",
                                    style: TextStyle(
                                      fontSize: height * 0.017, color: Colors.amber,),),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(sunset,
                                      style: TextStyle(
                                        fontSize: height * 0.016,
                                        color: Colors.white,),),
                                  ),
                                ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  color: Colors.white24,
                                  height: 30,
                                  width: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(children: [
                                  Text("Humidity",
                                    style: TextStyle(
                                      fontSize: height * 0.017, color: Colors.amber,),),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      "${currentWeatherModel.main!.humidity!}%",
                                      style: TextStyle(
                                        fontSize: height * 0.016,
                                        color: Colors.white,),),
                                  ),
                                ],),
                              ),
                            ],),
                        ),

                      ],
                    ),
                  );
                } else if (state.currentWeatherStatus is CurrentWeatherErrorStatus) {
                  final CurrentWeatherErrorStatus currentWeatherErrorStatus = state.currentWeatherStatus as CurrentWeatherErrorStatus;
                  return Expanded(child:Center(child: Text(currentWeatherErrorStatus.message)));
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }

  createFirstPageView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8,),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              currentWeatherModel.name ?? "",
              style: const TextStyle(fontSize: 36, color: Colors.white),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              weatherState,
              style: const TextStyle(fontSize: 26, color: Colors.white70),
            ),
          ),
        ),
        Center(
          child: Image.network("http://openweathermap.org/img/wn/$icon@2x.png"),
        ),
        Center(
          child: Text(
            "$temp\u00B0",
            style: const TextStyle(fontSize: 36, color: Colors.white),
          ),
        ),
        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "Min",
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 2,),
                Text(
                  "$tempMin\u00B0",
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                color: Colors.white,
                width: 2,
                height: 40,
              ),
            ),
            Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "Max",
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 2,),
                Text(
                  "$tempMax\u00B0",
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  createSearchBar(double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Row(
        children: [
          /// Search Box
          Expanded(
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                onSubmitted: (String prefix) {
                  if (prefix.isNotEmpty) {
                    textEditingController.text = prefix;
                    //BlocProvider.of<HomeBloc>(context).add(CurrentWeatherEvent(prefix));
                  }
                },
                controller: textEditingController,
                style: DefaultTextStyle.of(context).style.copyWith(
                  fontSize: height * 0.02,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.fromLTRB(20, height * 0.02, 0, height * 0.02),
                  hintText: "Enter a City...",
                  hintStyle: const TextStyle(color: Colors.white),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),),
              suggestionsCallback: (String prefix) async {
                return getSuggestionCityUseCase(Params.forQuery(prefix));
              },
              itemBuilder: (context, SuggestCityModel model) {
                return ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(model.name!),
                  subtitle: Text("${model.country!}, ${model.country!}"),
                );
              },
              onSuggestionSelected: (SuggestCityModel model) {
                textEditingController.text = model.name!;
                cityName = model.name!;
                BlocProvider.of<HomeBloc>(context).add(CurrentWeatherEvent(cityName));
              },
            ),),

          const SizedBox(width: 10,),
        ],
      ),
    );
  }
}
