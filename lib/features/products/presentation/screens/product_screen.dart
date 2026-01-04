import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/constants/app_colors.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/features/home/presentation/widgets/custom_grid_view.dart';
import 'package:graduation_project_nti/features/products/presentation/widgets/custom_floating_add_button.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      floatingWidget: CustomFloatingAddButton(),
      floatingWidgetHeight: 40,
      floatingWidgetWidth: 40,
      dx: MediaQuery.of(context).size.width - 28,
      dy: MediaQuery.of(context).size.height - 288,
      mainScreenWidget: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            title: 'Product',
            centerTitle: true,
            leading: SizedBox.shrink(),
          ),
        ),
        body: CustomScrollView(slivers: [CustomGridView()]),
      ),
    );
  }
}
