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
  static String currRole = "";

  static QueryDocumentSnapshot<Map<String, dynamic>>? userdata;

  static Future<void> addProduct(
    BuildContext context,
    String productName,
    File? imagefile,
    String description,
    String sellerId,
    String price,
    String quantity,
    List<String> categories,
  ) async {
    try {
      final CollectionReference productCollection =
          _firestore.collection("productcollection");
      String imageUrl = '';
      if (imagefile != null) {
        imageUrl = await _uploadImageToStorage(imagefile);
      }

      // Add product to product collection
      DocumentReference productDocRef = await productCollection.add({
        "productName": productName,
        "imageUrl": imageUrl,
        "description": description,
        "sellerId": sellerId,
        "price": price,
        "quantity": quantity,
        // "categories": categories,
      });

      // Add sellerId to each category document
      final CollectionReference categoriesCollection =
          _firestore.collection("categories");
      for (String category in categories) {
        QuerySnapshot categoryQuerySnapshot = await categoriesCollection
            .where("categoryName", isEqualTo: category)
            .get();

        if (categoryQuerySnapshot.docs.isEmpty) {
          // Category document doesn't exist, create it
          await categoriesCollection.add({
            "categoryName": category,
            "sellerIds": [sellerId],
          });
        } else {
          // Category document exists, update it
          DocumentSnapshot categoryDocSnapshot =
              categoryQuerySnapshot.docs.first;
          List<dynamic> sellerIds = categoryDocSnapshot.get("sellerIds");
          if (!sellerIds.contains(sellerId)) {
            sellerIds.add(sellerId);
            await categoriesCollection.doc(categoryDocSnapshot.id).update({
              "sellerIds": sellerIds,
            });
          }
        }
      }

      showSnackBar(context, Colors.green, "Product added successfully!");
      nextScreen(context, SellerHome());
    } catch (e) {
      showSnackBar(
          context, Colors.red, "There was an issue adding the product: $e");
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
          'role':
              "Buyer", // or 'home' based on your categories000000000000000000000000000
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

  static Future<void> getCurrentUserData(String role) async {
    try {
      User? user = _auth.currentUser;
      QuerySnapshot<Map<String, dynamic>> querySnapshot;
      if (role == "Buyer") {
        querySnapshot = await _firestore
            .collection('buyerCollection')
            .where('loginID', isEqualTo: user!.email)
            .get();
      } else if (role == "Seller") {
        querySnapshot = await _firestore
            .collection('sellerCollection')
            .where('loginID', isEqualTo: user!.email)
            .get();
      } else {
        querySnapshot = await _firestore
            .collection('sellerCollection')
            .where('loginID', isEqualTo: user!.email)
            .get();
      }
      if (querySnapshot.docs.isNotEmpty) {
        // Retrieve the first document (assuming email is unique)
        userdata = querySnapshot.docs.first;

        // User data found in Firestore
        // return userData.data();
      }
    } catch (e) {
      print('Error getting current user data: $e');
      return null;
    }
  }

  static Future<void> signInUser(
      BuildContext context, String email, String password, String role) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _redirectUser(context, userCredential.user!, role);
      currusername = email;
      currpassword = password;
      getCurrentUserData(role);
      showSnackBar(context, Colors.green, "Logged in successfully...");
    } on FirebaseAuthException catch (e) {
      print("Error signing in: $e");
      // if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      showSnackBar(context, Colors.red, "Incorrect email or password...");
      // }
    }
  }

  static Future<void> signOutAndReset() async {
    await _auth.signOut(); // Sign out from Firebase Authentication
    currusername = ""; // Reset username
    currpassword = "";
    currdocid = "";
    currRole = "";
  }

  static void _redirectUser(
      BuildContext context, User user, String role) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user.uid).get();

    String roleinData = userDoc['role'];

    if (roleinData == 'Buyer' && role == "Buyer") {
      QuerySnapshot querySnapshot = await _firestore
          .collection('buyerCollection')
          .where('loginID', isEqualTo: userDoc['email'])
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        currdocid = querySnapshot.docs.first.id;
        currRole = role;
      }
      nextScreenReplace(context, BuyerHome());
    } else if (roleinData == 'Seller' && role == "Seller") {
      QuerySnapshot querySnapshot = await _firestore
          .collection('sellerCollection')
          .where('loginID', isEqualTo: userDoc['email'])
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
    BuildContext context,
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
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: username,
          password: password,
        );

        // Store user role in Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': userCredential.user!.email,
          'role':
              "Seller", // or 'home' based on your categories000000000000000000000000000
        });
      } catch (e) {
        print("Error creating user: $e");
      }

      showSnackBar(context, Colors.green, "Seller registration Successfull!");
    } catch (e) {
      showSnackBar(context, Colors.green,
          "There was an issue adding Seller information: $e");
      print("There was an issue adding Seller information: $e");
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

  Future<QuerySnapshot<Map<String, dynamic>>> retrieveCollection(
      String collectionName) async {
    try {
      return await FirebaseFirestore.instance.collection(collectionName).get();
    } catch (e) {
      print('Error retrieving collection: $e');
      throw e; // Rethrow the exception to handle it elsewhere if needed
    }
  }
}
