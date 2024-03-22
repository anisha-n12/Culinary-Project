import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culinary_project/pages/AdminPage.dart';
import 'package:culinary_project/pages/buyerhome.dart';
import 'package:culinary_project/pages/sellerhome.dart';
import 'package:culinary_project/widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:flutter/material.dart';

class DatabaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static String currusername = "";
  static String currpassword = "";
  static String currdocid = "";
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

  static Future<void> addBuyer(
      BuildContext context,
      String name,
      String email,
      String mobile,
      String buildingNo,
      String district,
      String city,
      String state,
      String pinCode,
      String username,
      String password) async {
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
        "loginID": username,
        "password": password,
      });
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: username,
          password: password,
        );

        // Store user role in Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': userCredential.user!.email,
          'role': "Buyer", // or 'home' based on your categories000000000000000000000000000
        });
      } catch (e) {
        print("Error creating user: $e");
      }

      showSnackBar(context, Colors.green, "Buyer registration Successfull!");
    } catch (e) {
      showSnackBar(context, Colors.green,
          "There was an issue adding buyer information: $e");
      print("There was an issue adding buyer information: $e");
      // Handle the error as needed
    }
  }

  static Future<void> signInUser(
      BuildContext context, String email, String password, String role) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      currusername = email;
      currpassword = password;
      _redirectUser(context, userCredential.user!, role);
      showSnackBar(context, Colors.green, "Logged in successfully...");
    } on FirebaseAuthException catch (e) {
      print("Error signing in: $e");
      // if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      showSnackBar(context, Colors.red, "Incorrect email or password...");
      // }
    }
  }

  static void _redirectUser(
      BuildContext context, User user, String role) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user.uid).get();

    String roleinData = userDoc['role'];

    if (roleinData == 'Buyer' && role == "Buyer") {
      QuerySnapshot querySnapshot = await _firestore
          .collection('buyerCollection')
          .where('loginId', isEqualTo: userDoc['email'])
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        currdocid = querySnapshot.docs.first.id;
      }
      nextScreenReplace(context, BuyerHome());
    } else if (roleinData == 'Seller' && role == "Seller") {
      QuerySnapshot querySnapshot = await _firestore
          .collection('sellerCollection')
          .where('loginId', isEqualTo: userDoc['email'])
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        currdocid = querySnapshot.docs.first.id;
      }
      nextScreenReplace(context, SellerHome());
    } else if (roleinData == 'Admin' && role == "Admin") {
      currdocid = "admin";
      nextScreenReplace(context, AdminPage());
    } else {
      showSnackBar(context, Colors.red, "No user found with given role!");
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
      // try {
      //   UserCredential userCredential =
      //       await _auth.createUserWithEmailAndPassword(
      //     email: username,
      //     password: password,
      //   );

      //   // Store user role in Firestore
      //   await _firestore.collection('users').doc(userCredential.user!.uid).set({
      //     'email': userCredential.user!.email,
      //     'role': RecOrWar, // or 'home' based on your categories
      //   });
      // } catch (e) {
      //   print("Error creating user: $e");
      // }
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
