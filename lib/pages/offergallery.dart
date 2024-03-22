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
          ],
        )),
    Container(
        decoration: carouselDecoration,
        child: Column(
          children: [
            Image.asset("lib/assets/pickles_offer.png"),
          ],
        )),
    Container(
        decoration: carouselDecoration,
        child: Column(
          children: [
            Image.asset("lib/assets/pickles_offer.png"),
            const SizedBox(height: 100),
            const Text("Boys Hostel")
          ],
        )),
    Container(
        decoration: carouselDecoration,
        child: Column(
          children: [
            Image.asset("lib/assets/pickles_offer.png"),
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
              height: size.height * 0.5, // Customize the height of the carousel
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
