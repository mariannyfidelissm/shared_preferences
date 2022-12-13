import 'views/home_page.dart';
import 'views/splash_page.dart';
import 'views/preferences_page.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences',
      initialRoute: '/splash',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomePage(),
        '/splash': (context) => const SplashPage(),
        '/shared': (context) => const MySharedPrefsPage()
      },
    );
  }
}
