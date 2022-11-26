import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/lixo_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Reciclagem',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/lixo': (context) => const LixoListPage(title: "Lixo"),
      },
    );
  }
}
