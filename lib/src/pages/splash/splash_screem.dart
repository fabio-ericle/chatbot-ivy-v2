import 'package:app_ivy_v2/src/pages/home/home.dart';
import 'package:flutter/material.dart';

class SplashScreem extends StatelessWidget {
  const SplashScreem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then((_) =>
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomePage())));

    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          "Splash Screem",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
