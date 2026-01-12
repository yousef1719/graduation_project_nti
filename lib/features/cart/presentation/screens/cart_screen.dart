import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/features/cart/data/models/cart_item.dart';
import 'package:graduation_project_nti/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:graduation_project_nti/features/cart/presentation/widgets/checkout_button.dart';
import 'package:graduation_project_nti/features/cart/presentation/widgets/order_summary_widget.dart';
import 'package:graduation_project_nti/features/cart/presentation/widgets/promo_code_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> cartItems = [
    CartItem(
      id: '1',
      name: 'Gold Layered Necklace',
      subtitle: '18k Gold Plated',
      price: 45,
      image: 'assets/images/background/GoldNeckle.jpg',
    ),
    CartItem(
      id: '2',
      name: 'Gold Layered Necklace',
      subtitle: '18k Gold Plated',
      price: 142.50,
      image: 'assets/images/background/GoldNeckle.jpg',
    ),
  ];

  double get subtotal {
    return cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  double get tax => 12.5;
  double get shipping => 0;

  double get total => subtotal + tax + shipping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          leading: SizedBox.shrink(),
          title: 'My Cart (${cartItems.length})',
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length + 1,
              itemBuilder: (context, index) {
                if (index < cartItems.length) {
                  final item = cartItems[index];
                  return CartItemWidget(
                    key: ValueKey(item.id),
                    item: item,
                    onIncrease: () {
                      setState(() {
                        item.quantity++;
                      });
                    },
                    onDecrease: () {
                      setState(() {
                        if (item.quantity > 1) item.quantity--;
                      });
                    },
                    onDelete: () {
                      setState(() {
                        cartItems.removeAt(index);
                      });
                    },
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const PromoCodeWidget(),
                    const SizedBox(height: 20),
                    OrderSummaryWidget(
                      subtotal: subtotal,
                      shipping: shipping,
                      tax: tax,
                      total: total,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CheckoutButton(total: total),
    );
  }
}
