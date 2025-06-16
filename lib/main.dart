import 'package:flutter/material.dart';
import 'package:smart_car_lab/page/home/home_page.dart';
import 'package:smart_car_lab/route/routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Car Lab Introduction',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light,colorSchemeSeed: Colors.cyan),
      darkTheme: ThemeData(brightness: Brightness.dark,colorSchemeSeed: Colors.cyan),
      themeMode: ThemeMode.dark,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: RoutePath.home,
      home: HomePage(),
    );
  }
}
