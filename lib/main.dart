import 'package:flutter/material.dart';

import 'my_home_page.dart';
import 'favorite_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: "/home",
      routes: {
        "/home" : (context) => MyHomePage(),
        "/favorite" : (context) => Favorite(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}