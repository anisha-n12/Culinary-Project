import 'package:culinary_project/pages/user_managment.dart';
import 'package:culinary_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culinary_project/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culinary_project/shared/constants.dart';
import 'package:culinary_project/pages/user_managment.dart'; // Assuming UserManagement is defined in user_managment.dart
import 'package:culinary_project/pages/user_managment.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culinary_project/shared/constants.dart';
import 'package:culinary_project/pages/user_managment.dart';

class SellerCollectionScreen extends StatefulWidget {
  @override
  _SellerCollectionScreenState createState() => _SellerCollectionScreenState();
}

class _SellerCollectionScreenState extends State<SellerCollectionScreen> {
  final UserManagement _userManagement = UserManagement();
  late List<Map<String, dynamic>> _sellers;
  late List<Map<String, dynamic>> _filteredSellers;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredSellers = [];
    _sellers = [];
    _loadSellers();
  }

  void _loadSellers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _userManagement.retrieveCollection('sellerCollection');
      setState(() {
        _sellers = snapshot.docs.map((doc) => doc.data()).toList();
        _filteredSellers = _sellers;
      });
    } catch (e) {
      print('Error loading sellers: $e');
    }
  }

  void _filterSellers(String query) {
    setState(() {
      _filteredSellers = _sellers
          .where((seller) => seller['business_name']
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToSellerDetail(
      BuildContext context, Map<String, dynamic> seller) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SellerDetailScreen(seller: seller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Collection'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 0, 163, 146)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => _filterSellers(_searchController.text),
                decoration: InputDecoration(
                  hintText: 'Search Products...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSellers.length,
              itemBuilder: (context, index) {
                var sellerData = _filteredSellers[index];
                var logoUrl = sellerData['image_url'] ?? '';
                var businessName = sellerData['business_name'] ?? '';
                var ownerName = sellerData['name'] ?? '';
                var description = sellerData['description'] ?? '';

                return GestureDetector(
                  onTap: () => _navigateToSellerDetail(context, sellerData),
                  child: Padding(
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SellerDetailScreen extends StatelessWidget {
  final Map<String, dynamic> seller;

  const SellerDetailScreen({Key? key, required this.seller}) : super(key: key);

  void suspendUser(String sellerId) {
    // Implement your suspension logic here
    // For example, you can delete the seller document from Firestore
    FirebaseFirestore.instance
        .collection('sellerCollection')
        .doc(sellerId)
        .delete()
        .then((_) {
      print('Seller suspended successfully');
    }).catchError((error) {
      print('Error suspending seller: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    String sellerId = seller['sellerId'] ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.secondaryColor,
        title: Text('Seller Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 200, // Adjust the height as needed
                  child: Image.network(
                    seller['image_url'] ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Business Name: ${seller['business_name']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Description: ${seller['description']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Category: ${seller['category']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Owner Name: ${seller['name']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Contact  Number: ${seller['mobile']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Email Address: ${seller['email']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'City: ${seller['city']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'PinCode: ${seller['pincode']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Login ID: ${seller['loginID']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('sellerCollection')
                            .doc(sellerId)
                            .delete()
                            .then((_) {
                          print('Seller suspended successfully');
                        }).catchError((error) {
                          print('Error suspending seller: $error');
                        });
                      },
                      style: buttonStyle,
                      child: const Text(
                        "Suspend User",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
