import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

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
  bool _isSearching = false;
  bool get isSearching => _isSearching;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void closeSearch() {
    if (_isSearching) {
      setState(() {
        _isSearching = false;
        _searchController.clear();
        _focusNode.unfocus();
      });
      // DON'T call onSearchChanged - this prevents refresh when just closing
      widget.onSearchToggled?.call(false);
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        // Auto-focus when search opens
        Future.delayed(Duration.zero, () {
          _focusNode.requestFocus();
        });
      } else {
        // Clear and unfocus when closing
        _searchController.clear();
        _focusNode.unfocus();
        // Only call onSearchChanged to reset the search if there was text
        if (_searchController.text.isNotEmpty) {
          widget.onSearchChanged('');
        }
      }
      widget.onSearchToggled?.call(_isSearching);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      actionsPadding: const EdgeInsets.only(right: 12),
      pinned: true,
      floating: true,
      snap: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: _isSearching
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
          onPressed: _toggleSearch,
          icon: Icon(
            _isSearching ? CupertinoIcons.xmark : CupertinoIcons.search,
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
  }
}
