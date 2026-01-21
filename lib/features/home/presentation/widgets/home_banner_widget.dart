import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/features/home/presentation/cubit/home_cubit.dart';
import 'package:graduation_project_nti/features/home/presentation/cubit/home_state.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double bannerHeight = screenHeight * 0.22;
    bannerHeight = bannerHeight.clamp(160.0, 220.0);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is! HomeLoaded) {
          return const SizedBox.shrink();
        }

        final offers = state.banners;

        if (offers.isEmpty) {
          return const SizedBox.shrink();
        }

        return CarouselSlider.builder(
          itemCount: offers.length,
          itemBuilder: (context, int itemindex, int pageViewIndex) {
            final offer = offers[itemindex];
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  offer.coverUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) {
                      return child;
                    }
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
          ),
        );
      },
    );
  }
}
