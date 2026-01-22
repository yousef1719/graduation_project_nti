import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/cart/data/models/cart_item.dart';
import 'package:graduation_project_nti/features/cart/data/services/cart_service.dart';
import 'package:graduation_project_nti/features/products/data/models/product_model.dart';

class CustomBottomActionBar extends StatefulWidget {
  final ProductModel product;

  const CustomBottomActionBar({super.key, required this.product});

  @override
  State<CustomBottomActionBar> createState() => _CustomBottomActionBarState();
}

class _CustomBottomActionBarState extends State<CustomBottomActionBar> {
  int _quantity = 1;
  final CartService _cartService = CartService();

  void _addToCart() {
    final cartItem = CartItem(
      id: widget.product.id,
      name: widget.product.name,
      subtitle: widget.product.productCode,
      price: widget.product.price,
      quantity: _quantity,
      image: widget.product.coverPictureUrl,
    );

    _cartService.addItem(cartItem);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $_quantity ${widget.product.name}(s) to cart'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 2),
      ),
    );

    setState(() => _quantity = 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).cardColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_quantity > 1) _quantity--;
                    });
                  },
                  icon: Icon(
                    Icons.remove,
                    size: 20,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                CustomText(
                  text: _quantity.toString(),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_quantity < widget.product.stock) _quantity++;
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    size: 20,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: widget.product.stock > 0 ? _addToCart : null,
              icon: const Icon(CupertinoIcons.cart, color: Colors.white),
              label: const CustomText(
                text: 'Add to Cart',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.product.stock > 0
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
