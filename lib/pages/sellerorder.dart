import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culinary_project/service/database_service.dart';
import 'package:culinary_project/shared/constants.dart';
import 'package:flutter/material.dart';

class SellerOrder extends StatefulWidget {
  const SellerOrder({super.key});

  @override
  State<SellerOrder> createState() => _SellerOrderState();
}

class _SellerOrderState extends State<SellerOrder> {
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
      body: FutureBuilder<QuerySnapshot>(
        future: DatabaseService.fetchsellerOrders(DatabaseService.currdocid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final orders = snapshot.data!.docs;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final buyerId = order['buyerId'];
                final productId = order['productId'];

                return FutureBuilder(
                  future: Future.wait([
                    fetchProduct(productId),
                    fetchBuyer(buyerId),
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final productData = (snapshot.data![0]?.data()
                              as Map<String, dynamic>?) ??
                          {};
                      final buyerData = (snapshot.data![1]?.data()
                              as Map<String, dynamic>?) ??
                          {};

                      final productName =
                          productData['productName'] as String? ??
                              'Product Name Not Available';
                      final buyerName = buyerData['name'] as String? ??
                          'Buyer Name Not Available';
                      return ListTile(
                        title: Text('Product: $productName, Buyer: $buyerName'),
                        // You can display other details of the order here
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<DocumentSnapshot> fetchProduct(String productId) async {
    try {
      final DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('productCollection')
          .doc(productId)
          .get();

      return productSnapshot;
    } catch (e) {
      print('Error fetching product: $e');
      throw e;
    }
  }

  Future<DocumentSnapshot> fetchBuyer(String buyerId) async {
    try {
      final DocumentSnapshot buyerSnapshot = await FirebaseFirestore.instance
          .collection('buyerCollection')
          .doc(buyerId)
          .get();

      return buyerSnapshot;
    } catch (e) {
      print('Error fetching buyer: $e');
      throw e;
    }
  }
}
