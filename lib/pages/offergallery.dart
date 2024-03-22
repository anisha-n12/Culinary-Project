import 'package:culinary_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OfferGallery extends StatefulWidget {
  const OfferGallery({super.key});

  @override
  State<OfferGallery> createState() => _OfferGalleryState();
}

class _OfferGalleryState extends State<OfferGallery> {
  List<Container> carouselItems = [
    Container(
        decoration: carouselDecoration,
        child: Column(
          children: [
            Image.asset("lib/assets/pickles_offer.png"),
            const SizedBox(height: 5),
            const Text("Tangy delight in every bite!",
                style: TextStyle(fontSize: 20, color: Colors.black),
                textAlign: TextAlign.center)
          ],
        )),
    Container(
        decoration: carouselDecoration,
        child: Column(
          children: [
            Image.asset("lib/assets/papad_offer.png"),
            const SizedBox(height: 5),
            const Text("Crunchy joy, taste explosion guaranteed!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.black))
          ],
        )),
    Container(
        decoration: carouselDecoration,
        child: Column(
          children: [
            Image.asset("lib/assets/masala_offer.png"),
            const SizedBox(height: 5),
            const Text("Spice up your culinary journey!",
                style: TextStyle(fontSize: 20, color: Colors.black),
                textAlign: TextAlign.center)
          ],
        )),
    Container(
        decoration: carouselDecoration,
        child: Column(
          children: [
            Image.asset("lib/assets/snacks_offer.png"),
            const SizedBox(height: 5),
            const Text("Homemade flavor-packed treats!",
                style: TextStyle(fontSize: 20, color: Colors.black),
                textAlign: TextAlign.center)
          ],
        ))
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          // Other widgets
          CarouselSlider(
            items: carouselItems,
            options: CarouselOptions(
              height:
                  size.height * 0.34, // Customize the height of the carousel
              autoPlay: false, // Enable auto-play
              enlargeCenterPage: true, // Increase the size of the center item
              enableInfiniteScroll: true, // Enable infinite scroll
              onPageChanged: (index, reason) {
                // Optional callback when the page changes
                // You can use it to update any additional UI components
              },
            ),
          ),
        ]));
  }
}
