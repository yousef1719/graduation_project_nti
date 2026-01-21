import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/home/presentation/cubit/home_cubit.dart';
import 'package:graduation_project_nti/features/home/presentation/cubit/home_state.dart';

class HomeSliverAppBarWidget extends StatefulWidget {
  final Function(String) onSearchChanged;
  final Function(bool)? onSearchToggled;

  const HomeSliverAppBarWidget({
    super.key,
    required this.onSearchChanged,
    this.onSearchToggled,
  });

  @override
  State<HomeSliverAppBarWidget> createState() => HomeSliverAppBarWidgetState();
}

class HomeSliverAppBarWidgetState extends State<HomeSliverAppBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void closeSearch() {
    final cubit = context.read<HomeCubit>();
    if (cubit.state is HomeLoaded && (cubit.state as HomeLoaded).isSearching) {
      cubit.toggleSearch(false);
      _searchController.clear();
      _focusNode.unfocus();
      widget.onSearchToggled?.call(false);
    }
  }

  void _toggleSearch(bool currentIsSearching) {
    final cubit = context.read<HomeCubit>();
    final newSearching = !currentIsSearching;
    
    cubit.toggleSearch(newSearching);
    
    if (newSearching) {
      Future.delayed(Duration.zero, () {
        _focusNode.requestFocus();
      });
    } else {
      _searchController.clear();
      _focusNode.unfocus();
      if (_searchController.text.isNotEmpty) {
        widget.onSearchChanged('');
      }
    }
    widget.onSearchToggled?.call(newSearching);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        if (previous is HomeLoaded && current is HomeLoaded) {
          return previous.isSearching != current.isSearching;
        }
        return true;
      },
      builder: (context, state) {
        bool isSearching = false;
        if (state is HomeLoaded) {
          isSearching = state.isSearching;
        }

        return SliverAppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          actionsPadding: const EdgeInsets.only(right: 12),
          pinned: true,
          floating: true,
          snap: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: isSearching
              ? TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  onChanged: widget.onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    border: InputBorder.none,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/svgicons/circlelogo.svg',
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(width: 8),
                    CustomText(
                      text: 'Luxe',
                      fontSize: 25,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Playfair',
                    ),
                  ],
                ),
          actions: [
            IconButton(
              onPressed: () => _toggleSearch(isSearching),
              icon: Icon(
                isSearching ? CupertinoIcons.xmark : CupertinoIcons.search,
                color: Theme.of(context).iconTheme.color,
                size: 22,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              CupertinoIcons.bell,
              color: Theme.of(context).iconTheme.color,
              size: 22,
            ),
          ],
        );
      },
    );
  }
}
