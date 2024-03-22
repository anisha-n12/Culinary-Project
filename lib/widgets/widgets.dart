import 'package:culinary_project/shared/constants.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    labelStyle: TextStyle(
      fontSize: 13,
      color: Colors.grey,
      // fontWeight: FontWeight.w300,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Constants.secondaryColor, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Constants.secondaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Constants.secondaryColor, width: 2),
    ));

const buttonDecoration = BoxDecoration(
  color: Constants.secondaryColor,
  borderRadius: BorderRadius.all(Radius.circular(8.0)),
);

var buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Constants.secondaryColor),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  textStyle: MaterialStateProperty.all<TextStyle>(
    TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
);

var carouselDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      // Colors.transparent,
      // Colors.transparent,
      // Colors.transparent,
      Colors.transparent,
      Constants.secondaryColor.withOpacity(0.4), // Adjust the opacity as needed
    ],
  ),
  borderRadius: BorderRadius.circular(12.0),
);
const textDecoration = TextStyle(
  color: Colors.white,
  fontSize: 25.0,
  fontFamily: 'Roboto', // You can change the font family as needed
  fontWeight: FontWeight.bold, // You can adjust the font weight
);

const textDecorationmont = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontFamily: 'Pacifico', // Elegant font
  fontWeight: FontWeight.bold, // You can adjust the font weight
);

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnackBar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message, style: const TextStyle(fontSize: 14)),
    backgroundColor: color,
    duration: Duration(seconds: 2),
    action: SnackBarAction(
      label: "Ok",
      onPressed: () {},
      textColor: Colors.white,
    ),
  ));
}
