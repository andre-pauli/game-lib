// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_game_screen.dart';
import 'screens/search_screen.dart';
import 'screens/game_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca de Jogos',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/add_game': (context) => const AddGameScreen(),
        '/search': (context) => SearchScreen(),
        '/game_detail': (context) => GameDetailScreen(),
      },
    );
  }
}
