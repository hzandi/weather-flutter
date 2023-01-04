import 'package:flutter/material.dart';
import 'package:weather/core/utils/asset_utils.dart';
import '../../presentation/screens/home_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: false,
        body: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetUtils.getBackgroundImage(),
              fit: BoxFit.cover
            ),
          ),
          child: HomeScreen(),
        ),
      ),
    );
  }
}
