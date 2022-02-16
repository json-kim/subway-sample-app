import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subway_app/core/di/provider_setting.dart';
import 'package:subway_app/presentation/subway_home/subway_home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [...globalProviders],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SubwayHomeScreen(),
    );
  }
}
