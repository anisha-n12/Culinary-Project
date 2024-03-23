import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culinary_project/service/database_service.dart';
import 'package:culinary_project/shared/constants.dart';
import 'package:culinary_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String buyerId;

  const OrderDetailsScreen({
    Key? key,
    required this.buyerId,
  }) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _orderFuture;

  @override
  void initState() {
    super.initState();
    _orderFuture = FirebaseFirestore.instance
        .collection('Order')
        .doc(widget.buyerId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _orderFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Error fetching order details'));
          } else {
            Map<String, dynamic>? orderData = snapshot.data?.data();
            if (orderData == null) {
              return Center(child: Text('Order data is null'));
            }
            String productId = orderData['productId'];
            return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('productcollection')
                  .doc(productId)
                  .get(),
              builder: (context, productSnapshot) {
                if (productSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (productSnapshot.hasError ||
                    !productSnapshot.hasData) {
                  return Center(child: Text('Error fetching product details'));
                } else {
                  Map<String, dynamic>? productData =
                      productSnapshot.data?.data();
                  if (productData == null) {
                    return Center(child: Text('Product data is null'));
                  }
                  return ListTile(
                    title: Text('Product Details'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product Name: ${productData['name']}'),
                        Text('Price: ${productData['price']}'),
                        Text('Description: ${productData['description']}'),
                        // Add an image widget to display the product image
                        // For example:
                        // Image.network(productData['imageUrl']),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
