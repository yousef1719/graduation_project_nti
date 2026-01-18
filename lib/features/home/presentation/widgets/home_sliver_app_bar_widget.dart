import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class HomeSliverAppBarWidget extends StatelessWidget {
  const HomeSliverAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      actionsPadding: EdgeInsets.only(right: 12),
      pinned: true,
      floating: true,
      snap: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/svgicons/circlelogo.svg',
            height: 30,
            width: 30,
          ),
          SizedBox(width: 8),
          CustomText(
            text: 'Luxe',
            fontSize: 25,
            color: Theme.of(context).textTheme.titleLarge?.color,
            fontWeight: FontWeight.w700,
            fontFamily: 'Playfair',
          ),
        ],
      ),
      actions: [
        Icon(
          CupertinoIcons.search,
          color: Theme.of(context).iconTheme.color,
          size: 22,
        ),
        SizedBox(width: 16),
        Icon(
          CupertinoIcons.bell,
          color: Theme.of(context).iconTheme.color,
          size: 22,
        ),
      ],
    );
  }
}
