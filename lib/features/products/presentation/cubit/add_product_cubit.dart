import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/features/products/data/repo/product_repo.dart';
import 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final ProductRepo productRepo;

  AddProductCubit({required this.productRepo}) : super(AddProductInitial());

  Future<void> addProduct({
    required String name,
    required String description,
    required double price,
    required String category,
    required String sellerId,
    bool inStock = true,
  }) async {
    emit(AddProductLoading());
    try {
      final productData = {
        "name": name,
        "description": description,
        "price": price,
        "categories": [category],
        "productPictures": ["https://dummyimage.com/300x300"],
        "nameArabic": "",
        "descriptionArabic": "",
        "coverPictureUrl": "https://dummyimage.com/600x400",
        "sellerId": sellerId,
        "color": "",
        "stock": inStock ? 10 : 0,
      };

      await productRepo.addProduct(productData);
      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductError(e.toString()));
    }
  }
}
