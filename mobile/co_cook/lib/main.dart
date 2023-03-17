import 'package:flutter/material.dart';
import 'package:co_cook/screens/splash_screen/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:co_cook/screens/user_screen/user_screen.dart';
import 'package:co_cook/styles/colors.dart';
import 'package:co_cook/styles/text_styles.dart';

import 'screens/main_screen/main_screen.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}