import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sirib_app/pages/home_page.dart';
import 'package:sirib_app/pages/color_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color scaffoldBackgroundColor = AppColors.background1;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Center(
                child: Image.asset(
              'lib/images/SIRIB_LOGO.png',
              height: 150,
            )),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
