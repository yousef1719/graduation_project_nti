import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/home/presentation/cubit/home_cubit.dart';
import 'package:graduation_project_nti/features/home/presentation/cubit/home_state.dart';

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is! HomeLoaded) {
          return const SizedBox.shrink();
        }

        final categories = state.categories;
        final selectedId = state.selectedCategoryId;

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
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length + 1, // +1 for "All"
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _buildCategoryItem(
                        context,
                        id: null,
                        name: 'All',
                        image: '',
                        isSelected: selectedId == null,
                      );
                    }

                    final category = categories[index - 1];
                    return _buildCategoryItem(
                      context,
                      id: category.id,
                      name: category.name,
                      image: category.image,
                      isSelected: selectedId == category.id,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryItem(
    BuildContext context, {
    required String? id,
    required String name,
    required String image,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => context.read<HomeCubit>().selectCategory(id),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected
                      ? theme.colorScheme.primary.withAlpha(128)
                      : theme.dividerColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.backgroundColor,
                  child: image.isEmpty
                      ? Icon(
                          id == null ? Icons.apps : Icons.category,
                          color: isSelected ? theme.colorScheme.primary : Colors.grey,
                          size: 30,
                        )
                      : ClipOval(
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                            errorBuilder: (context, error, stackTrace) {
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
            text: name,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color,
          ),
        ],
      ),
    );
  }
}
