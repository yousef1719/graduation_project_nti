class CartItem {
  final String id;
  final String name;
  final String subtitle;
  final double price;
  int quantity;
  final String image;

  CartItem({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.price,
    this.quantity = 1,
    required this.image,
  });

  // factory CartItem.fromJson(Map<String, dynamic> json) {
  //   return CartItem(
  //     id: json['id'].toString(),
  //     name: json['title'] ?? '',
  //     subtitle: 'Qty: ${json['quantity']}',
  //     price: (json['price'] as num).toDouble(),
  //     quantity: json['quantity'] ?? 1,
  //     image: json['thumbnail'] ?? '',
  //   );
  // }
}
