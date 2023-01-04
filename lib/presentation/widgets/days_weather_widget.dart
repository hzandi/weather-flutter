import 'package:flutter/material.dart';
import 'package:weather/core/utils/asset_utils.dart';
import 'package:weather/core/utils/date_utils.dart';
import 'package:weather/domain/model/forecast_weather_model.dart';



class DaysWeatherWidget extends StatelessWidget {
  final DailyModel dailyModel;
  DaysWeatherWidget({Key? key, required this.dailyModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Text(DateConverter.changeDtToDateTime(dailyModel.dt).toString(),
              style: const TextStyle(fontSize: 12, color: Colors.amber)),
          SizedBox(height: height * 0.005,),

          Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: AssetUtils.setIconForMain(dailyModel.weather![0].description!,40.0)),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                    "${dailyModel.temp!.max!.round()}\u00B0/${dailyModel.temp!.min!.round()}\u00B0",
                    style: const TextStyle(fontSize: 12, color: Colors.white)),
              )),
        ],
      ),
    );
  }
}