import 'package:culinary_project/pages/AddProduct.dart';
import 'package:culinary_project/pages/AdminPage.dart';
import 'package:culinary_project/pages/SellerPage.dart';
import 'package:culinary_project/pages/SellerRegistration.dart';
import 'package:culinary_project/pages/loginpage.dart';
import 'package:culinary_project/pages/offergallery.dart';
// import 'package:culinary_project/pages/upload_img.dart';
import 'package:culinary_project/services/database_service.dart';
import 'package:culinary_project/shared/constants.dart';
import 'package:culinary_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:culinary_project/service/database_service.dart';
import 'package:culinary_project/shared/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                    nextScreen(context, AddProduct());
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
