import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culinary_project/pages/AddProduct.dart';
import 'package:culinary_project/pages/ProductDetail.dart';
import 'package:culinary_project/pages/buyerOrder.dart';
import 'package:culinary_project/pages/buyerprofile.dart';
// import 'package:culinary_project/pages/cart.dart';
import 'package:culinary_project/pages/homepage.dart';
import 'package:culinary_project/pages/offergallery.dart';
import 'package:culinary_project/service/database_service.dart';
import 'package:culinary_project/shared/constants.dart';
import 'package:culinary_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
// import 'package:badges/badges.dart';

class BuyerHome extends StatelessWidget {
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
    // int itemCount = ShoppingCart.cartItems.le;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        actions: [
          FavoritesIndicator(),
          CartIndicator(itemCount: 3),
        ],
        backgroundColor: Constants.secondaryColor,
        // leading: Image.asset("lib/assets/logosmall.png"),
        title: Column(children: [
          Text(
            "Snack Shack",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(height: 2),
        ]),
        toolbarHeight: 70,
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
            SizedBox(height: 10),
            Container(
              child: OfferGallery(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Explore",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future:
                    DatabaseService().retrieveCollection('productcollection'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<QueryDocumentSnapshot<Map<String, dynamic>>> products =
                        snapshot.data!.docs;

                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final productData = products[index].data();
                        final imageUrl = productData['imageurl'] ?? '';
                        final productName =
                            productData['productname'] ?? 'Unknown';
                        final price = productData['price'] is String
                            ? double.tryParse(productData['price']) ?? 0
                            : (productData['price'] ?? 0).toDouble();
                        final productId = products[index].id;
                        final sellerId = productData['sellerid'];

                        return GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                  productId: productId,
                                  sellerId: sellerId,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Card(
                              elevation: 0,
                              margin: EdgeInsets.zero,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: imageUrl.isNotEmpty
                                        ? Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                          )
                                        : Center(child: Text('No Image')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      productName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('\Rs.${price.toString()}'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
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
              onTap: () {
                nextScreen(context, BuyerProfile());
              },
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
                nextScreen(context,
                    OrderDetailsScreen(buyerId: DatabaseService.currdocid));
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
                "My Orders",
                style: TextStyle(color: Colors.white),
              ),
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
                            DatabaseService.signOutAndReset();
                            nextScreenReplace(context, HomePage());
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

class CartIndicator extends StatelessWidget {
  final int itemCount;

  const CartIndicator({Key? key, required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.shopping_cart, size: 35),
          onPressed: () {
            // Handle cart button press
          },
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            constraints: BoxConstraints(
              minWidth: 5,
              minHeight: 5,
            ),
            child: Text(
              itemCount.toString(),
              style: TextStyle(
                color: Constants.secondaryColor,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class FavoritesIndicator extends StatelessWidget {
  const FavoritesIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.favorite, size: 35),
      onPressed: () {
        // Handle favorites button press
      },
    );
  }
}
// 