import 'package:culinary_project/pages/AddProduct.dart';
import 'package:culinary_project/pages/homepage.dart';
import 'package:culinary_project/pages/offergallery.dart';
import 'package:culinary_project/service/database_service.dart';
import 'package:culinary_project/shared/constants.dart';
import 'package:culinary_project/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SellerHome extends StatelessWidget {
  static const primaryColor = Color.fromARGB(255, 0, 163, 146);
  static const secondaryColor = Color.fromARGB(255, 0, 163, 146);

  void nextScreen(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Constants.secondaryColor,
        // leading: Image.asset("lib/assets/logosmall.png"),
        title: Column(children: [
          Text(
            "Snack Shack",
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
              ],
            ),
            Container(
              child: OfferGallery(),
            )
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: secondaryColor,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.white,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              DatabaseService.userdata!['name'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {},
              selectedColor: primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              title: const Text(
                "My Profile",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                nextScreen(context, AddProduct());
              },
              selectedColor: primaryColor,
              selected: false,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              title: const Text(
                "Add Product",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {},
              selectedColor: primaryColor,
              selected: false,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              title: const Text(
                "Product Management",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {},
              selectedColor: primaryColor,
              selected: false,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
              title: const Text(
                "Order Management",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              tileColor: Color.fromARGB(255, 14, 14, 14),
              onTap: () async {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text("Are you sure you want to Logout?"),
                      title: Text("Log Out"),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.cancel,
                          ),
                          color: Colors.red,
                        ),
                        IconButton(
                          onPressed: () async {
                            DatabaseService.signOutAndReset();
                            nextScreenReplace(context, HomePage());
                            // Perform logout action here
                          },
                          icon: Icon(Icons.done),
                          color: Colors.green,
                        )
                      ],
                    );
                  },
                );
              },
              selectedColor: primaryColor,
              selected: false,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              title: const Text(
                "Log out",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
