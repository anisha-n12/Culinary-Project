import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addSeller(
    String name,
    String businessName,
    String description,
    String category,
    String email,
    String mobile,
    String buildingNo,
    String district,
    String city,
    String state,
    String pinCode,
  ) async {
    try {
      final CollectionReference sellerCollection =
          _firestore.collection("sellerCollection");

      await sellerCollection.add({
        "name": name,
        "business_name": businessName,
        "description": description,
        "category": category,
        "email": email,
        "mobile": mobile,
        "buildingNo": buildingNo,
        "district": district,
        "city": city,
        "state": state,
        "pinCode": pinCode,
        "loginID": "",
        "password": "",
      });

      print(
          "Congratulations! You've successfully registered as a Seller on Snack Shack!");
    } catch (e) {
      print("There was an issue adding your information as a Seller $e");
      // Handle the error as needed
    }
  }
}