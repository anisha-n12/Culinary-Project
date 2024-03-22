// import 'dart:io';

// import 'package:flutter/material.dart';
import 'package:culinary_project/service/database_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io'; // Import the database service
import 'package:image_picker/image_picker.dart'; // Import the image picker package

class Seller_Registration extends StatefulWidget {
  @override
  __Seller_RegistrationState createState() => __Seller_RegistrationState();
}

class __Seller_RegistrationState extends State<Seller_Registration> {
  final DatabaseService _databaseService =
      DatabaseService(); // Instantiate the database service
  File? _image; // File variable to store the picked image
  final picker = ImagePicker(); // Image picker instance

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // Function to upload the picked image along with seller information
  Future<void> _uploadSellerInfo() async {
    // Example seller information
    String name = "John Doe";
    String businessName = "Doe's Bakery";
    String description = "We bake the best pastries!";
    String category = "Bakery";
    String email = "john.doe@example.com";
    String mobile = "+1234567890";
    String buildingNo = "123";
    String district = "ABC District";
    String city = "XYZ City";
    String state = "State";
    String pinCode = "123456";

    // Add seller information using the DatabaseService
    await _databaseService.addSeller(
      name,
      businessName,
      description,
      category,
      email,
      mobile,
      buildingNo,
      district,
      city,
      state,
      pinCode,
      _image, // Pass the picked image file
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Seller Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!), // Display the picked image if available
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'), // Button to pick an image
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadSellerInfo,
              child: Text(
                  'Upload Seller Info'), // Button to upload seller information
            ),
          ],
        ),
      ),
    );
  }
}
