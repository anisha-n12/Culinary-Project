import 'package:culinary_project/pages/loginpage.dart';
import 'package:culinary_project/pages/offergallery.dart';
import 'package:culinary_project/services/database_service.dart';
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
        automaticallyImplyLeading: false,
        backgroundColor: Constants.secondaryColor,
        leading: Image.asset("lib/assets/logosmall.png"),
        title: Column(children: [
          Text(
            "SnackShack",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(height: 5),
        ]),
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 320,
                ),
                ElevatedButton(
                  onPressed: () {
                    nextScreen(context, LoginPage());
                  },
                  style: buttonStyle,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: OfferGallery(),
            )
          ],
        ),
      ),
    );
  }
}
