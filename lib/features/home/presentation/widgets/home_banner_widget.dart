// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/features/home/data/models/offer_banner_model.dart';
import 'package:graduation_project_nti/features/home/data/repositories/offer_repository.dart';

class HomeBannerWidget extends StatefulWidget {
  const HomeBannerWidget({super.key});

  @override
  State<HomeBannerWidget> createState() => _HomeBannerWidgetState();
}

class _HomeBannerWidgetState extends State<HomeBannerWidget> {
  final OffersRepository repository = OffersRepository();
  final List<OfferBannerModel> offers = [];
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  int page = 1;
  final int pageSize = 5;
  bool isLoading = false;
  bool hasNextPage = true;

  @override
  void initState() {
    super.initState();
    fetchOffers();
  }

  Future<void> fetchOffers() async {
    if (isLoading || !hasNextPage) return;
    setState(() => isLoading = true);

    final newOffers = await repository.fetchOffers(
      page: page,
      pageSize: pageSize,
    );

    setState(() {
      offers.addAll(newOffers);
      page++;
      isLoading = false;
      hasNextPage = newOffers.length == pageSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double bannerHeight = screenHeight * 0.22;
    bannerHeight = bannerHeight.clamp(160.0, 220.0);

    if (offers.isEmpty && isLoading) {
      return SizedBox(
        height: bannerHeight,
        child: const Center(child: CupertinoActivityIndicator()),
      );
    }
    return CarouselSlider.builder(
      carouselController: _carouselController,
      itemCount: offers.length,
      itemBuilder: (context, int itemindex, int pageViewIndex) {
        final offer = offers[itemindex];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              offer.coverUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(child: CupertinoActivityIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.error));
              },
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: bannerHeight,
        initialPage: 0,
        viewportFraction: 0.92,
        aspectRatio: 16 / 9,
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayInterval: const Duration(seconds: 5),
        enlargeCenterPage: true,
        enlargeFactor: 0.16,
        autoPlayCurve: Curves.fastOutSlowIn,
        onPageChanged: (index, reason) {
          if (index >= offers.length - 2) {
            fetchOffers();
          }
        },
      ),
    );
  }
}
