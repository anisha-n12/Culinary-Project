import 'package:culinary_project/shared/constants.dart';
import 'package:culinary_project/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Constants.secondaryColor,
          title: Text(
            "SnackShack",
            style: textDecoration,
          ),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Rector Logo
        ]));
  }
}
