import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class DatabaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
    File? imageFile, // Add image file parameter
  ) async {
    try {
      final CollectionReference sellerCollection =
          _firestore.collection("sellerCollection");

      // Upload image to Firebase Storage if image file is provided
      String imageUrl = '';
      if (imageFile != null) {
        imageUrl = await _uploadImageToStorage(imageFile);
      }

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
        "loginID": "",
        "password": "",
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
