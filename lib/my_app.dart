import 'package:flutter/material.dart';
import 'package:to_do/views/screens/home_screen.dart';
import 'package:to_do/views/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/home": (context) => const HomeScreen(),
        "/splash": (context) => const SplashScreen(),
      },
      initialRoute: "/splash",
    );
  }
}
