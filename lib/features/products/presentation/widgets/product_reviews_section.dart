import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/products/data/models/product_model.dart';
import 'package:graduation_project_nti/features/products/data/models/review_model.dart';
import 'package:graduation_project_nti/features/products/data/repo/product_repo.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/custom_rating_widget.dart';

class ProductReviewsSection extends StatefulWidget {
  final ProductModel product;

  const ProductReviewsSection({super.key, required this.product});

  @override
  State<ProductReviewsSection> createState() => _ProductReviewsSectionState();
}

class _ProductReviewsSectionState extends State<ProductReviewsSection> {
  List<ReviewModel> reviews = [];
  bool isLoading = true;
  final ProductRepo repo = ProductRepo();

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      final result = await repo.getProductReviews(widget.product.id);
      setState(() {
        reviews = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'Reviews (${widget.product.reviewsCount})',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
            CustomText(
              text: 'See All',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
        const SizedBox(height: 12),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: reviews
                    .map((review) => reviewCard(context, review))
                    .toList(),
              ),
        const SizedBox(height: 20),
      ],
    );
  }
}

Widget reviewCard(BuildContext context, ReviewModel review) {
  return Container(
    padding: const EdgeInsets.all(17),
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface.withAlpha(76),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              CupertinoIcons.person_circle,
              color: Theme.of(context).iconTheme.color,
              size: 30,
            ),
            SizedBox(width: 6),
            CustomText(
              text: review.userName,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            Spacer(),
            CustomText(
              text: review.createdAt.split('T').first,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ],
        ),
        SizedBox(height: 6),
        CustomRatingWidget(rating: review.rating.toDouble()),
        SizedBox(height: 8),
        CustomText(
          text: review.comment,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
      ],
    ),
  );
}
