import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culinary_project/shared/constants.dart';
import 'package:culinary_project/widgets/widgets.dart';

class ProductDetail extends StatelessWidget {
  final String productId;
  final String sellerId;

  const ProductDetail({
    Key? key,
    required this.productId,
    required this.sellerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.secondaryColor,
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('productcollection')
              .doc(productId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              var productData = snapshot.data!.data()!;
              var description = productData['description'] ?? '';
              var imageUrl = productData['imageurl'] ?? '';
              var productName = productData['productname'] ?? 'Unknown';
              var price = productData['price'] is String
                  ? double.tryParse(productData['price']) ?? 0
                  : (productData['price'] ?? 0).toDouble();
              var quantity = productData['quantity'] ?? '';
              var rating = productData['rating'] ?? 0;
              var category = productData['category'] ?? '';

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        height: 150, // Decreased logo size
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      productName,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Description: $description',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Price: Rs. ${price.toString()}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Quantity: $quantity',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Rating: $rating',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Category: $category',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 16.0),
                    FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: FirebaseFirestore.instance
                          .collection('sellerCollection')
                          .doc(sellerId)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          var sellerData = snapshot.data!.data()!;
                          var businessName = sellerData['business_name'] ?? '';
                          var description = sellerData['description'] ?? '';
                          var city = sellerData['city'] ?? '';
                          var state = sellerData['state'] ?? '';
                          var contactNumber =
                              sellerData['contact_number'] ?? '';

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Business Name: $businessName',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Description: $description',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Location: $city, $state',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Contact Number: $contactNumber',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              SizedBox(height: 16.0),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 16.0, right: 16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // Add logic to handle ordering
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Constants.secondaryColor,
                                          onPrimary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        child: Text(
                                          'Order',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          // Add logic to handle adding to cart
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Constants.secondaryColor,
                                          onPrimary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        icon: Icon(Icons.shopping_cart),
                                        label: Text(
                                          'Add to Cart',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
