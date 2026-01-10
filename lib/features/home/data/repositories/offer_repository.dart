import 'package:dio/dio.dart';
import 'package:graduation_project_nti/features/home/data/models/offer_banner_model.dart';

class OffersRepository {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://accessories-eshop.runasp.net/api',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<List<OfferBannerModel>> fetchOffers({
    int page = 1,
    int pageSize = 5,
  }) async {
    final response = await dio.get(
      '/offers',
      // لو السيرفر محتاج body للـ GET، يبقى استخدم `options: Options(method: 'GET')` مع data
      options: Options(
        method: 'GET',
        headers: {'Content-Type': 'application/json'},
      ),
      data: {"page": 1, "pageSize": 5},
    );
    final items = response.data['offers']['items'] as List;
    return items.map((e) => OfferBannerModel.fromJson(e)).toList();
  }
}
