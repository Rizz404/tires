import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class AppSearchableDropdownItem<T> {
  final T value;
  final String label;
  final Widget? icon;
  final String? searchKey;

  const AppSearchableDropdownItem({
    required this.value,
    required this.label,
    this.icon,
    this.searchKey,
  });
}

class AppSearchableDropdown<T> extends StatefulWidget {
  final String name;
  final T? initialValue;
  final List<AppSearchableDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final String? label;
  final String? searchHintText;
  final bool enabled;
  final Widget? prefixIcon;
  final bool isExpanded;
  final double? width;
  final double? maxHeight;
  final String? Function(T?)? validator;
  final Future<List<AppSearchableDropdownItem<T>>> Function(String query)?
  onSearch;
  final Future<List<AppSearchableDropdownItem<T>>> Function()? onLoadMore;
  final bool enableInfiniteScroll;
  final int debounceTime;
  final Widget? emptySearchResult;
  final Widget? loadingIndicator;

  const AppSearchableDropdown({
    super.key,
    required this.name,
    this.initialValue,
    required this.items,
    this.onChanged,
    this.hintText,
    this.label,
    this.searchHintText,
    this.enabled = true,
    this.prefixIcon,
    this.isExpanded = true,
    this.width,
    this.maxHeight = 300,
    this.validator,
    this.onSearch,
    this.onLoadMore,
    this.enableInfiniteScroll = false,
    this.debounceTime = 300,
    this.emptySearchResult,
    this.loadingIndicator,
  });

  @override
  State<AppSearchableDropdown<T>> createState() =>
      _AppSearchableDropdownState<T>();
}

class _AppSearchableDropdownState<T> extends State<AppSearchableDropdown<T>> {
  final GlobalKey<FormBuilderFieldState> _fieldKey =
      GlobalKey<FormBuilderFieldState>();
  final LayerLink _layerLink = LayerLink();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;
  List<AppSearchableDropdownItem<T>> _displayedItems = [];
  List<AppSearchableDropdownItem<T>> _allItems = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String _currentSearchQuery = '';
  int _currentPage = 1;
  Timer? _debounceTimer;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _allItems = List.from(widget.items);
    _displayedItems = List.from(widget.items);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _debounceTimer?.cancel();
    _removeOverlay();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isDisposed ||
        !mounted ||
        !widget.enableInfiniteScroll ||
        widget.onLoadMore == null) {
      return;
    }

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    if (_isLoadingMore ||
        _isDisposed ||
        !mounted ||
        !widget.enableInfiniteScroll ||
        widget.onLoadMore == null) {
      return;
    }

    AppLogger.uiDebug('Loading more items for dropdown');
    if (mounted) {
      setState(() {
        _isLoadingMore = true;
      });
    }

    try {
      final newItems = await widget.onLoadMore!();
      if (mounted && !_isDisposed) {
        setState(() {
          _allItems.addAll(newItems);
          if (_currentSearchQuery.isEmpty) {
            _displayedItems.addAll(newItems);
          } else {
            _displayedItems = _filterItems(_allItems, _currentSearchQuery);
          }
          _currentPage++;
          _isLoadingMore = false;
        });
      }
    } catch (e, stackTrace) {
      AppLogger.uiError('Failed to load more items', e, stackTrace);
      if (mounted && !_isDisposed) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  List<AppSearchableDropdownItem<T>> _filterItems(
    List<AppSearchableDropdownItem<T>> items,
    String query,
  ) {
    if (query.isEmpty) return items;

    final lowerQuery = query.toLowerCase();
    return items.where((item) {
      final searchKey =
          item.searchKey?.toLowerCase() ?? item.label.toLowerCase();
      return searchKey.contains(lowerQuery);
    }).toList();
  }

  Future<void> _onSearchChanged(String query) async {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      Duration(milliseconds: widget.debounceTime),
      () async {
        if (_isDisposed || !mounted) return;

        _currentSearchQuery = query;

        if (widget.onSearch != null) {
          if (mounted) {
            setState(() {
              _isLoading = true;
            });
          }

          try {
            final searchResults = await widget.onSearch!(query);
            if (mounted && !_isDisposed) {
              setState(() {
                _displayedItems = searchResults;
                _isLoading = false;
              });
            }
          } catch (e, stackTrace) {
            AppLogger.uiError('Search failed', e, stackTrace);
            if (mounted && !_isDisposed) {
              setState(() {
                _displayedItems = _filterItems(_allItems, query);
                _isLoading = false;
              });
            }
          }
        } else {
          if (mounted && !_isDisposed) {
            setState(() {
              _displayedItems = _filterItems(_allItems, query);
            });
          }
        }
      },
    );
  }

  void _toggleDropdown() {
    if (_isDisposed || !mounted) return;

    if (_isDropdownOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    if (_isDisposed || !mounted) return;

    AppLogger.uiDebug('Opening searchable dropdown');
    _overlayEntry = _createOverlayEntry();
    if (_overlayEntry != null && mounted) {
      try {
        Overlay.of(context).insert(_overlayEntry!);
        setState(() {
          _isDropdownOpen = true;
        });
      } catch (e) {
        AppLogger.uiError('Failed to insert overlay', e, StackTrace.current);
        _overlayEntry?.dispose();
        _overlayEntry = null;
      }
    }
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      try {
        _overlayEntry?.remove();
      } catch (e) {
        AppLogger.uiError('Failed to remove overlay', e, StackTrace.current);
      } finally {
        _overlayEntry?.dispose();
        _overlayEntry = null;
      }
    }
    if (mounted && !_isDisposed) {
      setState(() {
        _isDropdownOpen = false;
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    if (_isDisposed || !mounted) return _createEmptyOverlayEntry();

    try {
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox == null) return _createEmptyOverlayEntry();

      final size = renderBox.size;
      final offset = renderBox.localToGlobal(Offset.zero);

      return OverlayEntry(
        builder: (context) => Positioned(
          left: offset.dx,
          top: offset.dy + size.height,
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height),
            child: _buildDropdownContent(),
          ),
        ),
      );
    } catch (e) {
      AppLogger.uiError(
        'Failed to create overlay entry',
        e,
        StackTrace.current,
      );
      return _createEmptyOverlayEntry();
    }
  }

  OverlayEntry _createEmptyOverlayEntry() {
    return OverlayEntry(builder: (context) => const SizedBox.shrink());
  }

  Widget _buildDropdownContent() {
    final maxHeight = widget.maxHeight ?? 300;

    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(8),
      color: context.colorScheme.surface,
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.colorScheme.outline.withValues(alpha: 0.2),
          ),
          color: context.colorScheme.surface,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSearchField(),
            if (_isLoading)
              Padding(
                padding: const EdgeInsets.all(16),
                child:
                    widget.loadingIndicator ??
                    const Center(child: CircularProgressIndicator()),
              )
            else if (_displayedItems.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child:
                    widget.emptySearchResult ??
                    const AppText(
                      'No items found',
                      style: AppTextStyle.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
              )
            else
              Flexible(
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: _displayedItems.length + (_isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _displayedItems.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final item = _displayedItems[index];
                    return _buildDropdownItem(item);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: widget.searchHintText ?? 'Search...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              _onSearchChanged('');
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownItem(AppSearchableDropdownItem<T> item) {
    return InkWell(
      onTap: () {
        _selectItem(item);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.icon != null) ...[item.icon!, const SizedBox(width: 8)],
            Flexible(
              child: AppText(
                item.label,
                style: AppTextStyle.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectItem(AppSearchableDropdownItem<T> item) {
    if (_isDisposed || !mounted) return;

    AppLogger.uiDebug('Selected item: ${item.label}');
    _fieldKey.currentState?.didChange(item.value);
    widget.onChanged?.call(item.value);
    _removeOverlay();
    _searchController.clear();
    if (mounted && !_isDisposed) {
      setState(() {
        _currentSearchQuery = '';
        // Ensure the selected item is in _allItems for future reference
        if (!_allItems.any(
          (existingItem) => existingItem.value == item.value,
        )) {
          _allItems.add(item);
        }
        _displayedItems = List.from(_allItems);
      });
    }
  }

  String _getSelectedItemLabel() {
    if (_fieldKey.currentState?.value == null) return '';

    final currentValue = _fieldKey.currentState?.value;

    // First try to find in displayed items (includes search results)
    try {
      final item = _displayedItems.firstWhere(
        (item) => item.value == currentValue,
      );
      return item.label;
    } catch (e) {
      // If not found in displayed items, try in all items
      try {
        final item = _allItems.firstWhere((item) => item.value == currentValue);
        return item.label;
      } catch (e) {
        // If still not found, return the value as string
        return currentValue.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget dropdown = CompositedTransformTarget(
      link: _layerLink,
      child: FormBuilderField<T>(
        key: _fieldKey,
        name: widget.name,
        initialValue: widget.initialValue,
        validator: widget.validator,
        builder: (field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.label != null) ...[
                AppText(widget.label!, style: AppTextStyle.bodyMedium),
                const SizedBox(height: 4),
              ],
              GestureDetector(
                onTap: widget.enabled ? _toggleDropdown : null,
                child: InputDecorator(
                  decoration: InputDecoration(
                    hintText: widget.hintText ?? 'Select option',
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabled: widget.enabled,
                    errorText: field.errorText,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: field.value != null
                            ? AppText(
                                _getSelectedItemLabel(),
                                style: AppTextStyle.bodyMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Text(
                                widget.hintText ?? 'Select option',
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    if (widget.width != null) {
      dropdown = SizedBox(width: widget.width, child: dropdown);
    }

    return dropdown;
  }
}
