import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/controller/home_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/widget/carousel_image.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';

class OffersCarousel extends StatelessWidget {
  const OffersCarousel({super.key, required this.controller});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      disableGesture: true,
      items: [CarouselImage(), CarouselImage(), CarouselImage()],
      options: CarouselOptions(
        height: fullHeight * 0.26,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        enableInfiniteScroll: false,
        autoPlay: false,
        onPageChanged: (index, reason) {
          controller.onPageChanged(index);
        },
      ),
    );
  }
}
