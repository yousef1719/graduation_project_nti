import 'package:graduation_project_nti/core/network/api_service.dart';
import 'package:graduation_project_nti/features/home/data/models/offer_banner_model.dart';

class OffersRepository {
  final ApiService _apiService = ApiService();

  Future<List<OfferBannerModel>> fetchOffers({
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      final response = await _apiService.get(
        'offers',
        queryParams: {'page': page, 'pageSize': pageSize},
      );

      if (response is! Map<String, dynamic> || response['offers'] == null) {
        return [];
      }

      final items = response['offers']['items'] as List;
      return items.map((e) => OfferBannerModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
