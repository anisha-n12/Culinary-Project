import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class DatabaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(
    String productName,
    String imageUrl,
    String description,
    String sellerId,
    double price,
    int quantity,
  ) async {
    try {
      final CollectionReference productCollection =
          _firestore.collection("productCollection");

      // Start a Firestore transaction
      await _firestore.runTransaction((transaction) async {
        // Get the document reference for the Sales_Admin document
        final DocumentReference adminDocRef = _firestore
            .collection("Sales_Admin")
            .doc(); // No document ID provided

        // Get the current value of no_product field
        final DocumentSnapshot adminSnapshot =
            await transaction.get(adminDocRef);
        final int currentNoProducts =
            (adminSnapshot.data() as Map<String, dynamic>)['no_product'] ?? 0;

        // Update the no_product field by incrementing it by 1
        transaction.update(adminDocRef, {'no_product': currentNoProducts + 1});

        // Add product information to Firestore
        await productCollection.add({
          "productName": productName,
          "imageUrl": imageUrl,
          "description": description,
          "sellerId": sellerId,
          "price": price,
          "quantity": quantity,
        });
      });

      print("Product added successfully!");
    } catch (e) {
      print("There was an issue adding the product: $e");
      // Handle the error as needed
    }
  }

  Future<void> addBuyer(
    String name,
    String email,
    String mobile,
    String buildingNo,
    String district,
    String city,
    String state,
    String pinCode,
  ) async {
    try {
      final CollectionReference buyerCollection =
          _firestore.collection("buyerCollection");

      // Add buyer information to Firestore
      await buyerCollection.add({
        "name": name,
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

      print("Buyer information added successfully!");
    } catch (e) {
      print("There was an issue adding buyer information: $e");
      // Handle the error as needed
    }
  }

  Future<void> addSeller(
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
    File? imageFile,
    String username,
    String password,
  ) async {
    try {
      final CollectionReference sellerCollection =
          _firestore.collection("sellerCollection");

      // Upload image to Firebase Storage if image file is provided
      String imageUrl = '';
      if (imageFile != null) {
        imageUrl = await _uploadImageToStorage(imageFile);
      }

      // Update the no_user field of Sales_Admin document by incrementing it by 1
      await _firestore.runTransaction((transaction) async {
        final DocumentReference adminDocRef =
            _firestore.collection("Sales_Admin").doc();
        final DocumentSnapshot adminSnapshot =
            await transaction.get(adminDocRef);
        final int currentNoUsers =
            (adminSnapshot.data() as Map<String, dynamic>)['no_user'] ?? 0;
        transaction.update(adminDocRef, {'no_user': currentNoUsers + 1});
      });

      // Add seller information to Firestore
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
        "loginID": username,
        "password": password,
        "image_url": imageUrl, // Add image URL to Firestore
      });

      print(
          "Congratulations! You've successfully registered as a Seller on Snack Shack!");
    } catch (e) {
      print("There was an issue adding your information as a Seller $e");
      // Handle the error as needed
    }
  }

  static Future<String> _uploadImageToStorage(File imageFile) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('seller_images')
          .child(DateTime.now().toString() + '.jpg');

      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      // Get the download URL
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (error) {
      print('Error uploading image: $error');
      return '';
    }
  }
}
