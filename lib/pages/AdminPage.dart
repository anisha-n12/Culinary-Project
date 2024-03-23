import 'package:culinary_project/pages/user_manage.dart';
import 'package:culinary_project/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: const Text(
          "Admin Page",
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
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
              "Username",
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
                nextScreenReplace(context, SellerCollectionScreen());
              },
              selectedColor: primaryColor,
              selected: false,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(
                Icons.people,
                color: Colors.white,
              ),
              title: const Text(
                "User Management",
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
            ListTile(
              onTap: () {},
              selectedColor: primaryColor,
              selected: false,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              title: const Text(
                "Change Password",
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
