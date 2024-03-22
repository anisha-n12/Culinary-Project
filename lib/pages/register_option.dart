import 'package:culinary_project/pages/buyer_reg.dart';
import 'package:culinary_project/pages/homepage.dart';
import 'package:culinary_project/pages/seller_reg.dart';
import 'package:culinary_project/shared/constants.dart';
import 'package:culinary_project/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterOptions extends StatefulWidget {
  const RegisterOptions({super.key});

  @override
  State<RegisterOptions> createState() => _RegisterOptionsState();
}

class _RegisterOptionsState extends State<RegisterOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Constants.secondaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  nextScreen(context, BuyerRegistration());
                },
                child: Column(children: [
                  Image.asset(
                    "lib/assets/buyer_reg.png",
                    fit: BoxFit.cover,
                    height: 270,
                    width: 500,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text("I'm a Buyer",
                      style: textDecoration.copyWith(
                          color: Colors.black, fontSize: 30)),
                  const SizedBox(
                    height: 20.0,
                  ),
                ]),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  nextScreen(context, SellerRegistration());
                },
                child: Column(children: [
                  Image.asset(
                    "lib/assets/seller_reg.png",
                    fit: BoxFit.cover,
                    height: 270,
                    width: 500,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text("I'm a Seller",
                      style: textDecoration.copyWith(
                          color: Colors.black, fontSize: 30)),
                  const SizedBox(
                    height: 20.0,
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
