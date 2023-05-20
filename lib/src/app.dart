import 'package:flutter/material.dart';
import 'package:recipely/src/features/splash/splash.dart';

class RecipelyApp extends StatelessWidget {
  const RecipelyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipely',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
