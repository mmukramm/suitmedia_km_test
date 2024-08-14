import 'package:flutter/material.dart';

import 'package:suitmedia_km_test/styles/theme.dart';
import 'package:suitmedia_km_test/screens/first_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const FirstScreen(),
    );
  }
}
