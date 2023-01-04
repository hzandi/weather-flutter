import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/presentation/bloc/home_bloc.dart';
import 'package:weather/locator.dart';
import 'core/widgets/main_screen.dart';
import 'package:flutter/rendering.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  debugPaintSizeEnabled = false;
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.black54),
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<HomeBloc>()),
        ],
        child: MainScreen(),
      )));
}
