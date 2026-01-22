import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
    this.onPressedLeading,
    this.title,
    this.actions,
    this.centerTitle,
    this.leading,
    this.automaticallyImplyLeading,
    this.showSearch = false,
    this.onSearchChanged,
    this.onSearchToggled,
  });

  final Widget? leading;
  final void Function()? onPressedLeading;
  final List<Widget>? actions;
  final String? title;
  final bool? centerTitle;
  final bool? automaticallyImplyLeading;
  final bool showSearch;
  final Function(String)? onSearchChanged;
  final Function(bool)? onSearchToggled;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        // Delay focus to ensure TextField is built
        Future.delayed(Duration.zero, () {
          _focusNode.requestFocus();
        });
      } else {
        // Only clear and notify if there was actually search text
        final hadText = _searchController.text.isNotEmpty;
        _searchController.clear();
        _focusNode.unfocus();
        // Only trigger onSearchChanged if we're clearing actual search text
        if (hadText) {
          widget.onSearchChanged?.call('');
        }
      }
      widget.onSearchToggled?. call(_isSearching);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: widget.automaticallyImplyLeading ?? true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: widget.centerTitle ?? true,
      title:
          _isSearching
              ? TextField(
                controller: _searchController,
                focusNode: _focusNode,
                onChanged: widget.onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyLarge,
              )
              : CustomText(
                text: widget.title ?? '',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
      leading:
          widget.leading ??
          IconButton(
            onPressed: widget.onPressedLeading ?? () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
      actions: [
        if (widget.showSearch)
          IconButton(
            onPressed: _toggleSearch,
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ...?widget.actions,
      ],
    );
  }
}
