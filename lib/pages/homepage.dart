// import 'package:culinary_project/pages/ProductDetail.dart';
// import 'package:culinary_project/pages/offergallery.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:culinary_project/service/database_service.dart';
// import 'package:culinary_project/shared/constants.dart';
// import 'package:culinary_project/widgets/widgets.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Constants.secondaryColor,
//         leading: Image.asset("lib/assets/logosmall.png"),
//         title: Column(children: [
//           Text(
//             "Snack Shack",
//             style: TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
//           ),
//           SizedBox(height: 5),
//         ]),
//         toolbarHeight: 80,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               children: [
//                 const SizedBox(
//                   width: 320,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Navigate to SellerPage
//                   },
//                   style: buttonStyle,
//                   child: const Text(
//                     "Login",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // Offer Gallery
//             OfferGallery(),
//             // GUI of UserHome
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                 future:
//                     DatabaseService().retrieveCollection('productcollection'),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else {
//                     List<QueryDocumentSnapshot<Map<String, dynamic>>> products =
//                         snapshot.data!.docs;

//                     return GridView.builder(
//                       shrinkWrap: true,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 16.0,
//                         mainAxisSpacing: 16.0,
//                         childAspectRatio: 0.75,
//                       ),
//                       itemCount: products.length,
//                       itemBuilder: (context, index) {
//                         final productData = products[index].data();
//                         final imageUrl = productData['imageurl'] ?? '';
//                         final productName =
//                             productData['productname'] ?? 'Unknown';
//                         final price = productData['price'] is String
//                             ? double.tryParse(productData['price']) ?? 0
//                             : (productData['price'] ?? 0)
//                                 .toDouble(); // Ensure price is double
//                         final productId = products[index].id;

//                         return GestureDetector(
//                           onTap: () async {
//                             // Retrieve seller data using seller ID
//                             final sellerId = productData['sellerid'];
//                             print('Seller ID: $sellerId');
//                             final sellerData = await FirebaseFirestore.instance
//                                 .collection('sellerCollection')
//                                 .doc(sellerId)
//                                 .get();
//                             print('Seller Data: $sellerData');

//                             // Check if sellerData is not null before accessing fields
//                             if (sellerData.exists) {
//                               // Access sellerData fields
//                               final businessName = sellerData['business_name'];
//                               final sellerImageUrl = sellerData['image_url'];
//                               print('Business Name: $businessName');
//                               print('Seller Image URL: $sellerImageUrl');

//                               // Navigate to product detail page
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ProductDetail(
//                                     productId: productId,
//                                     imageurl: imageUrl,
//                                     price: price,
//                                     productname: productName,
//                                     quantity: productData['quantity'],
//                                     rating: productData['rating'],
//                                     sellerid: sellerId,
//                                     businessName: businessName,
//                                     category: productData['category'],
//                                     city: productData['city'],
//                                     description: productData['description'],
//                                     district: productData['district'],
//                                     email: productData['email'],
//                                     sellerImageUrl: sellerImageUrl,
//                                   ),
//                                 ),
//                               );
//                             } else {
//                               // Handle the case where sellerData does not exist
//                               print('Seller data not found.');
//                             }
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12.0),
//                               border: Border.all(color: Colors.grey[300]!),
//                             ),
//                             child: Card(
//                               elevation: 0,
//                               margin: EdgeInsets.zero,
//                               clipBehavior: Clip.antiAlias,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12.0),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: imageUrl.isNotEmpty
//                                         ? Image.network(
//                                             imageUrl,
//                                             fit: BoxFit.cover,
//                                           )
//                                         : Center(child: Text('No Image')),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       productName,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8.0),
//                                     child: Text('\Rs.${price.toString()}'),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:culinary_project/pages/AdminPage.dart';
import 'package:culinary_project/pages/offergallery.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culinary_project/service/database_service.dart';
import 'package:culinary_project/shared/constants.dart';
import 'package:culinary_project/widgets/widgets.dart';
import 'package:culinary_project/pages/ProductDetail.dart';

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
        title: Column(
          children: [
            Text(
              "Snack Shack",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(width: 320),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to SellerPage
                    nextScreen(context, AdminPage());
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
            // Offer Gallery
            OfferGallery(),
            // GUI of UserHome
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
    );
  }
}
