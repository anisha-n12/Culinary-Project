import 'dart:io';

import 'package:culinary_project/service/database_service.dart';
import 'package:culinary_project/shared/constants.dart';
import 'package:culinary_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? _image;
  String productName = "";
  String category = "";
  String description = "";
  String quantity = "";
  String price = "";
  final picker = ImagePicker(); // Image picker instance
  List<String> _selectedCategories = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Product',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Constants.secondaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 150,
                    height: 150,
                    color: Colors.grey[200],
                    child: _image != null
                        ? Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.add_photo_alternate,
                            size: 50,
                          ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  productName = value;
                },
                decoration: textInputDecoration.copyWith(
                  labelText: 'Product Name',
                  hintText: 'Enter product name',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  description = value;
                },
                decoration: textInputDecoration.copyWith(
                  labelText: 'Description',
                  hintText: 'Enter description',
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  price = value;
                },
                decoration: textInputDecoration.copyWith(
                  labelText: 'Price',
                  hintText: 'Enter price in Indian rupees',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  quantity = value;
                },
                decoration: textInputDecoration.copyWith(
                  labelText: 'Quantity',
                  hintText: 'Enter quantity',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String category in [
                    'Pickles',
                    'Chutneys',
                    'Masalas',
                    'Papads',
                    'Snacks',
                    'Sweets',
                    'Beverages'
                  ])
                    CheckboxListTile(
                      title: Text(category),
                      value: _selectedCategories.contains(category),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null && value) {
                            _selectedCategories.add(category);
                          } else {
                            _selectedCategories.remove(category);
                          }
                        });
                      },
                    ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add logic to submit product details
                  DatabaseService.addProduct(
                      context,
                      productName,
                      _image,
                      description,
                      DatabaseService.currdocid,
                      price,
                      quantity,
                      _selectedCategories);
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 0, 163, 146), // Background color
                  onPrimary: Colors.white, // Text color
                  textStyle: TextStyle(fontSize: 16), // Text style
                ),
              ),
              SizedBox(height: 20), // Adjust spacing as needed
            ],
          ),
        ),
      ),
    );
  }
}
