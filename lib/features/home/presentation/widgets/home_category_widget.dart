// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/home/data/models/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCategoryWidget extends StatefulWidget {
  const HomeCategoryWidget({super.key});

  @override
  State<HomeCategoryWidget> createState() => _HomeCategoryWidgetState();
}

class _HomeCategoryWidgetState extends State<HomeCategoryWidget> {
  //final List<CategoryModel> items = [];
  int isSeleceted = 0;

  final Dio dio = Dio();
  List<CategoryModel> categories = [];
  Future<void> getCategories() async {
    try {
      // 🟢 جلب الـ token من SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        log("Token not found. Please login first.");
        return;
      }

      // 🟢 عمل request مع الـ token
      Response response = await dio.get(
        'https://accessories-eshop.runasp.net/api/categories',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // مهم جدًا
          },
          validateStatus: (status) {
            return status! < 500; // قبول أي status أقل من 500
          },
        ),
      );

      if (response.statusCode == 200) {
        log(
          "API Full Response: ${response.data}",
        ); // هذا السطر سيطبع لك شكل البيانات في الـ Console

        var rawData = response.data;
        List? categoryList;

        if (rawData is List) {
          categoryList = rawData;
        } else if (rawData is Map) {
          // جرب الوصول للمفاتيح الأكثر شيوعاً أو ابحث عن أي مفتاح نوعه List
          categoryList =
              rawData['data'] ??
              rawData['categories'] ??
              rawData['result'] ??
              rawData['values']; // أحياناً يكون الاسم values

          // إذا ظل null، نقوم بالبحث عن أول قائمة (List) داخل الـ Map
          if (categoryList == null) {
            categoryList = rawData.values.firstWhere(
              (value) => value is List,
              orElse: () => null,
            );
          }
        }

        if (categoryList != null) {
          setState(() {
            categories = categoryList!
                .map((e) => CategoryModel.fromJson(e))
                .toList();
          });
          log("Categories fetched successfully ✅ Count: ${categories.length}");
        } else {
          log("❌ Error: Could not find a List in the API response.");
        }
      } else {
        log("Error fetching categories: ${response.statusCode}");
      }
    } on DioException catch (e) {
      log("Dio Error: $e");
    } catch (e) {
      log("Unexpected Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Category',
            fontSize: 20,
            color: Theme.of(context).textTheme.titleLarge?.color,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                // final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSeleceted = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSeleceted == index
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.primary.withOpacity(0.5)
                                  : Theme.of(context).dividerColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: CircleAvatar(
                              radius: 30, // نصف قطر الدائرة
                              backgroundColor: AppColors
                                  .backgroundColor, // لون خلفية الدائرة
                              child: categories[index].image.isEmpty
                                  ? const Icon(
                                      Icons.category,
                                      color: Colors.grey,
                                      size: 30,
                                    ) // لو مفيش صورة، نعرض أيقونة بديلة
                                  : ClipOval(
                                      child: Image.network(
                                        categories[index].image,
                                        fit: BoxFit.cover,
                                        width: 60,
                                        height: 60,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.broken_image,
                                                color: Colors.grey,
                                              );
                                            },
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      CustomText(
                        text: categories[index].name,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
