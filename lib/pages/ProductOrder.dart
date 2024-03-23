import 'package:culinary_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:culinary_project/service/database_service.dart';
import 'package:culinary_project/shared/constants.dart';

class ProductOrder extends StatefulWidget {
  final String buyerId;
  final String productId;

  const ProductOrder({
    Key? key,
    required this.buyerId,
    required this.productId,
  }) : super(key: key);

  @override
  _ProductOrderState createState() => _ProductOrderState();
}

class _ProductOrderState extends State<ProductOrder> {
  String buyerName = '';
  String buyerAddress = '';
  String paymentMethod = 'Cash on Delivery'; // Default payment method
  int quantity = 1; // Initial quantity
  double price = 0; // Price fetched from the database
  double totalAmount = 0; // Total amount to be displayed

  @override
  void initState() {
    super.initState();
    fetchBuyerInfo();
    fetchProductPrice();
  }

  void fetchBuyerInfo() {
  if (DatabaseService.userdata != null) {
    setState(() {
      buyerName = DatabaseService.userdata!['name'] ?? '';
      buyerAddress = DatabaseService.userdata!['buildingNo'] +
          " " +
          DatabaseService.userdata!['city'] +
          " " +
          DatabaseService.userdata!['pinCode'] +
          " " +
          DatabaseService.userdata!['state'];
    });
  }
}

  void fetchProductPrice() {
    // Fetch the price of the product from the database using productId
    // Example code to fetch the price
    // Replace with actual implementation
    setState(() {
      price = 10.0; // Replace with the actual price fetched from the database
      updateTotalAmount(); // Update the total amount based on the quantity and price
    });
  }

  void updateTotalAmount() {
    // Calculate the total amount based on the quantity and price
    setState(() {
      totalAmount = quantity * price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back navigation here
        Navigator.pop(context);
        return true; // Return true to allow back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.secondaryColor,
          title: Text('Product Order'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                  context); // Navigate back when arrow button is pressed
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: textInputDecoration.copyWith(
                  labelText: 'Buyer Name',
                ),
                readOnly: true,
                controller: TextEditingController(text: buyerName),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: textInputDecoration.copyWith(
                  labelText: 'Buyer Address',
                ),
                readOnly: true,
                controller: TextEditingController(text: buyerAddress),
              ),
              SizedBox(height: 16.0),
             TextField(
  decoration: textInputDecoration.copyWith(
    labelText: 'Quantity',
  ),
  keyboardType: TextInputType.number, // Set keyboard type to number
  onChanged: (value) {
    setState(() {
      quantity = int.tryParse(value) ?? 1;
      updateTotalAmount(); // Update the total amount based on the quantity change
    });
  },
),
              SizedBox(height: 16.0),
              Text(
                'Total Amount: Rs. $totalAmount',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: paymentMethod,
                onChanged: (newValue) {
                  setState(() {
                    paymentMethod = newValue!;
                  });
                },
                items: ['Cash on Delivery', 'Online Payment']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
                decoration: textInputDecoration.copyWith(
                  labelText: 'Payment Method',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  addToProductOrder();
                },
                style: buttonStyle.copyWith(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(
                      color: Colors.black, // Change text color to black
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addToProductOrder() {
    // Call the DatabaseService method to add the product order
    DatabaseService.addProductOrder(widget.buyerId, widget.productId, quantity);

    // Show a snackbar or navigate to another screen after submitting the order
    showSnackBar(
      context,
      Constants.secondaryColor,
      'Order submitted successfully',
    );

    // You can also navigate to another screen after submitting the order
    // Navigator.of(context).pop();
  }
}
