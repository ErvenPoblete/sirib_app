import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirib_app/pages/favorites_provider.dart';
import 'package:sirib_app/pages/splash_screen.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
