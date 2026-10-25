import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/result_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Split-My-Bill',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      // Theme sesuai mode dark atau light hp user
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/result': (context) => const ResultPage(),
      },
    );
  }
}
