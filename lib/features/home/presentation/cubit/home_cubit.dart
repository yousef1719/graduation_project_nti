import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/features/home/data/repo/category_repo.dart';
import 'package:graduation_project_nti/features/home/data/repositories/offer_repository.dart';
import 'package:graduation_project_nti/features/products/data/repo/product_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CategoryRepo categoryRepo;
  final ProductRepo productRepo;
  final OffersRepository offersRepository;

  HomeCubit({
    required this.categoryRepo,
    required this.productRepo,
    required this.offersRepository,
  }) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      final categories = await categoryRepo.getCategories();
      final products = await productRepo.getProducts(page: 1, pageSize: 50);
      final banners = await offersRepository.fetchOffers(page: 1, pageSize: 10);
      
      emit(HomeLoaded(
        categories: categories,
        products: products,
        banners: banners,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void updateSearchQuery(String query) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(searchQuery: query));
      // You might want to trigger a filtered fetch here if backend search is required
      // For now keeping it client-side as consistent with previous logic
    }
  }

  void toggleSearch(bool isSearching) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(isSearching: isSearching));
    }
  }

  void selectCategory(String? categoryId) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(selectedCategoryId: categoryId));
    }
  }
}
