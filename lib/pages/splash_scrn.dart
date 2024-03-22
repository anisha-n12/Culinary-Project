import 'dart:async';

import 'package:culinary_project/shared/constants.dart';
import 'package:culinary_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:culinary_project/pages/homepage.dart';
import 'package:lottie/lottie.dart';

class SplashScrn extends StatefulWidget {
  const SplashScrn({super.key});

  @override
  State<SplashScrn> createState() => _SplashScrnState();
}

class _SplashScrnState extends State<SplashScrn> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.secondaryColor,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  "Welcome",
                  style: textDecorationmont.copyWith(fontSize: 40),
                ),
                const SizedBox(height: 25),
                Container(
                    height: 250,
                    width: 300,
                    child: Center(
                        child: Image.asset("lib/assets/logosmall.png",
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.topCenter))),
                const SizedBox(height: 4),
                Container(
                    height: 250,
                    width: 300,
                    child: Center(
                        child: Image.asset("lib/assets/name.png",
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.topCenter))),
                Container(
                    color: Colors.white,
                    child: const Row(children: [
                      SizedBox(width: 30),
                      Text(
                        "Snack Shack",
                        style: TextStyle(
                            fontSize: 60,
                            color: Constants.ternaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: SizedBox(width: 4),
                      )
                    ])),
                SizedBox(height: 85),
                Container(
                  height: 150,
                  width: 100,
                  child: Lottie.network(
                      "https://lottie.host/5a633516-f801-4191-a311-c29a1479bf48/A7AFfT8vJQ.json"),
                ),
              ],
            ),
          ),
        ));
  }
}
