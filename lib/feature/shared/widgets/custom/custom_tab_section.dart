import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

typedef CustomTabContentBuilder = Widget Function(
  BuildContext context,
  int index,
);

class CustomTabSection extends StatefulWidget {
  final String title;
  final List<String> tabs;
  final CustomTabContentBuilder contentBuilder;
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;

  const CustomTabSection({
    super.key,
    required this.title,
    required this.tabs,
    required this.contentBuilder,
    this.initialIndex = 0,
    this.onTabChanged,
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
    setState(() {});
    if (!_tabController.indexIsChanging) {
      widget.onTabChanged?.call(_tabController.index);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
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
        widget.contentBuilder(context, _tabController.index),
      ],
    );
  }
}
