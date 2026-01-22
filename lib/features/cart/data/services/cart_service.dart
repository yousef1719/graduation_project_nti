import 'package:graduation_project_nti/features/cart/data/models/cart_item.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  final List<CartItem> _items = [];

  factory CartService() {
    return _instance;
  }

  CartService._internal();

  List<CartItem> get items => _items;

  void addItem(CartItem item) {
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index >= 0) {
      _items[index].quantity += item.quantity;
    } else {
      _items.add(item);
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
  }

  void clear() {
    _items.clear();
  }

  int get itemCount => _items.length;

  double get total {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }
}
