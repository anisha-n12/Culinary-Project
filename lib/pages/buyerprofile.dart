import 'package:culinary_project/service/database_service.dart';
import 'package:culinary_project/shared/constants.dart';
import 'package:flutter/material.dart';

class BuyerProfile extends StatefulWidget {
  const BuyerProfile({Key? key}) : super(key: key);

  @override
  State<BuyerProfile> createState() => _BuyerProfileState();
}

class _BuyerProfileState extends State<BuyerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Profile",
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Constants.secondaryColor,
                    radius: 100,
                    // Display profile icon using Icon widget
                    child: Icon(
                      Icons.person, // Use Icons.person for profile icon
                      size: 100,
                      color: Colors.white,
                    ),
                    // backgroundColor: Colors
                    // .blue, // Customize icon background color as needed
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DatabaseService.userdata!['name'], // Display user's name
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildProfileField("Email", DatabaseService.userdata!["email"]),
            _buildProfileField("Mobile", DatabaseService.userdata!["mobile"]),
            _buildProfileField(
                "Building No", DatabaseService.userdata!["buildingNo"]),
            _buildProfileField(
                "District", DatabaseService.userdata!["district"]),
            _buildProfileField("City", DatabaseService.userdata!["city"]),
            _buildProfileField("State", DatabaseService.userdata!["state"]),
            _buildProfileField(
                "Pin Code", DatabaseService.userdata!["pinCode"]),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label + " : ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
