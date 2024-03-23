import 'package:culinary_project/pages/user_managment.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culinary_project/shared/constants.dart';
// import 'user_management.dart';

class SellerCollectionScreen extends StatelessWidget {
  final UserManagement _userManagement = UserManagement();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Collection'),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: _userManagement.retrieveCollection('sellerCollection'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var sellerData = snapshot.data!.docs[index].data();
                var logoUrl = sellerData['image_url'] ?? '';
                var businessName = sellerData['business_name'] ?? '';
                var ownerName = sellerData['name'] ?? '';
                var description = sellerData['description'] ?? '';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Constants.secondaryColor),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      leading: SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.network(logoUrl),
                      ),
                      title: Text(
                        businessName,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.0),
                          Text(
                            'Owner: $ownerName',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Description: $description',
                            style: TextStyle(fontSize: 14.0),
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
    );
  }
}
