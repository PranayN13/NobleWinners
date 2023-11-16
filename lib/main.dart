import 'package:flutter/material.dart';
import 'package:noble_winners/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noble Winners',
      home: const HomeScreen(),
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
    );
  }
}

void main(){
  runApp(const App());
}