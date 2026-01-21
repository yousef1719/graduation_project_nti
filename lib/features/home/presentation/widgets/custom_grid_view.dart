import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/products/data/models/product_model.dart';
import 'package:graduation_project_nti/features/products/presentation/screens/product_details_screen.dart';

class CustomGridView extends StatefulWidget {
  const CustomGridView({
    super.key,
    required this.products,
    this.isSelectionMode = false,
    this.selectedIds = const {},
    this.onSelectionChanged,
    this.onDeletePressed,
  });

  final List<ProductModel> products;
  final bool isSelectionMode;
  final Set<String> selectedIds;
  final Function(String)? onSelectionChanged;
  final Function(String)? onDeletePressed;

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  int? isSelected;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final crossAxisCount = width > 600 ? 3 : 2;
    final theme = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(childCount: widget.products.length, (
          context,
          index,
        ) {
          final product = widget.products[index];
          final isSelectedId = widget.selectedIds.contains(product.id);

          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onLongPress: widget.onSelectionChanged != null
                ? () => widget.onSelectionChanged!(product.id)
                : null,
            onTap: () {
              if (widget.isSelectionMode && widget.onSelectionChanged != null) {
                widget.onSelectionChanged!(product.id);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsScreen(product: product),
                  ),
                );
              }
            },
            child: Card(
              color: isSelectedId
                  ? theme.colorScheme.primary.withAlpha(25)
                  : theme.cardColor,
              elevation: isSelectedId ? 2 : 5,
              shadowColor: theme.shadowColor.withAlpha(51),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: isSelectedId
                    ? BorderSide(color: theme.colorScheme.primary, width: 2)
                    : BorderSide.none,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: product.coverPictureUrl.isNotEmpty
                              ? Image.network(
                                  product.coverPictureUrl,
                                  height: height * 0.2,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Container(
                                          height: height * 0.2,
                                          width: double.infinity,
                                          color: Colors.grey[200],
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              value:
                                                  loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                  : null,
                                            ),
                                          ),
                                        );
                                      },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: height * 0.2,
                                      width: double.infinity,
                                      color: Colors.grey[300],
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.broken_image,
                                            color: Colors.grey[500],
                                            size: 40,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Image error',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  height: height * 0.2,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.grey[500],
                                    size: 40,
                                  ),
                                ),
                        ),
                        // Discount badge
                        if (product.discountPercentage > 0)
                          Positioned(
                            top: 8,
                            left: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(51),
                                    blurRadius: 4,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                '${product.discountPercentage}% OFF',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        // Delete button
                        if (!widget.isSelectionMode &&
                            widget.onDeletePressed != null)
                          Positioned(
                            top: 4,
                            left: 4,
                            child: IconButton(
                              onPressed: () =>
                                  widget.onDeletePressed!(product.id),
                              icon: const Icon(
                                CupertinoIcons.trash,
                                color: Colors.white,
                                size: 18,
                              ),
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(32, 32),
                                backgroundColor: Colors.red.withAlpha(179),
                                shape: const CircleBorder(),
                              ),
                            ),
                          ),
                        // Selection indicator
                        if (widget.isSelectionMode)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelectedId
                                    ? AppColors.primaryColor
                                    : Colors.black.withAlpha(77),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                Icons.check,
                                size: 16,
                                color: isSelectedId
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        // Favorite button
                        if (!widget.isSelectionMode)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (isSelected == index) {
                                    isSelected = null;
                                  } else {
                                    isSelected = index;
                                  }
                                });
                              },
                              icon: Icon(
                                isSelected == index
                                    ? CupertinoIcons.heart_fill
                                    : CupertinoIcons.heart,
                                color: isSelected == index
                                    ? Colors.red
                                    : Colors.white,
                                size: 20,
                              ),
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(32, 32),
                                backgroundColor: Colors.black.withAlpha(77),
                                shape: const CircleBorder(),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    CustomText(
                      overflow: TextOverflow.ellipsis,
                      text: product.name,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                    CustomText(
                      text: product.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.textTheme.bodyMedium?.color?.withAlpha(179),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: '\$${product.price.toStringAsFixed(2)}',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: theme.colorScheme.onPrimary,
                            size: 18,
                          ),
                          style: IconButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(25, 25),
                            backgroundColor: theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.65,
        ),
      ),
    );
  }
}
