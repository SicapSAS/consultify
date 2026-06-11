import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

typedef CustomTabContentBuilder = Widget Function(
  BuildContext context,
  int index,
  String searchQuery,
);

class CustomTabSection extends StatefulWidget {
  final String title;
  final List<String> tabs;
  final CustomTabContentBuilder contentBuilder;
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;
  final String? searchHint;
  final bool Function(int tabIndex)? showSearchForTab;

  const CustomTabSection({
    super.key,
    required this.title,
    required this.tabs,
    required this.contentBuilder,
    this.initialIndex = 0,
    this.onTabChanged,
    this.searchHint,
    this.showSearchForTab,
  }) : assert(tabs.length >= 2, 'Debe haber al menos 2 pestañas');

  static Widget emptyMessageBox(BuildContext context, String message) {

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 18,
          color: AppColors.textPrimary.withValues(alpha: 0.55),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  State<CustomTabSection> createState() => _CustomTabSectionState();
}

class _CustomTabSectionState extends State<CustomTabSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    final maxIndex = widget.tabs.length - 1;
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.initialIndex.clamp(0, maxIndex),
    );
    _tabController.addListener(_handleTabChange);
  }

  @override
  void didUpdateWidget(covariant CustomTabSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabs.length != widget.tabs.length) {
      final previousIndex = _tabController.index;
      _tabController.removeListener(_handleTabChange);
      _tabController.dispose();
      final maxIndex = widget.tabs.length - 1;
      _tabController = TabController(
        length: widget.tabs.length,
        vsync: this,
        initialIndex: previousIndex.clamp(0, maxIndex),
      );
      _tabController.addListener(_handleTabChange);
    }
  }

  void _handleTabChange() {
    if (!mounted) return;
    if (!_tabController.indexIsChanging) {
      if (_searchQuery.isNotEmpty) {
        _searchController.clear();
        _searchQuery = '';
      }
      widget.onTabChanged?.call(_tabController.index);
    }
    setState(() {});
  }

  void _handleSearchChanged(String value) {
    setState(() => _searchQuery = value);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: widget.tabs.length > 3,
            tabAlignment: widget.tabs.length > 3
                ? TabAlignment.start
                : TabAlignment.fill,
            labelColor: AppColors.secondary,
            unselectedLabelColor: AppColors.secondary.withValues(alpha: 0.5),
            indicatorColor: AppColors.secondaryButton,
            indicatorWeight: 3,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            tabs: widget.tabs.map((label) => Tab(text: label)).toList(),
          ),
        ),
        SizedBox(height: 12),
        if (widget.searchHint != null &&
            (widget.showSearchForTab?.call(_tabController.index) ?? true)) ...[
          AppSearchField(
            controller: _searchController,
            hintText: widget.searchHint,
            onChanged: _handleSearchChanged,
          ),
          SizedBox(height: 12),
        ],
        widget.contentBuilder(
          context,
          _tabController.index,
          _searchQuery,
        ),
      ],
    );
  }
}
