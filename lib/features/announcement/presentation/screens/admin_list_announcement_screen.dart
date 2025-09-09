import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/announcement/presentation/widgets/announcement_filter_search.dart';
import 'package:tires/features/announcement/presentation/widgets/announcement_table_widget.dart';
import 'package:tires/features/user/domain/entities/announcement.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/stat_tile.dart';

// Todo: Nanti buat i18n juga dan benerin biar pake shared widget
@RoutePage()
class AdminListAnnouncementScreen extends StatefulWidget {
  const AdminListAnnouncementScreen({super.key});

  @override
  State<AdminListAnnouncementScreen> createState() =>
      _AdminListAnnouncementScreenState();
}

class _AdminListAnnouncementScreenState
    extends State<AdminListAnnouncementScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  bool _isFilterVisible = true;

  List<Announcement> _announcements = [];
  List<Announcement> _filteredAnnouncements = [];

  @override
  void initState() {
    super.initState();
    _loadMockAnnouncements();
  }

  void _loadMockAnnouncements() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _announcements = _generateMockAnnouncements();
          _applyFilters();
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _refreshAnnouncements() async {
    setState(() {
      _announcements.clear();
      _filteredAnnouncements.clear();
    });
    _loadMockAnnouncements();
  }

  void _applyFilters() {
    final formValues = _formKey.currentState?.value;
    if (formValues == null) return;

    final searchQuery = formValues['search'] as String? ?? '';
    final selectedStatus = formValues['status'] as String? ?? 'all';
    final startDate = formValues['start_date'] as DateTime?;
    final endDate = formValues['end_date'] as DateTime?;

    List<Announcement> filtered = List.from(_announcements);

    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((ann) {
        final translation = ann.translations.first;
        return translation.title.toLowerCase().contains(query) ||
            translation.content.toLowerCase().contains(query);
      }).toList();
    }

    if (selectedStatus != 'all') {
      final isActive = selectedStatus == 'active';
      filtered = filtered.where((ann) => ann.isActive == isActive).toList();
    }

    if (startDate != null) {
      filtered = filtered
          .where(
            (ann) =>
                ann.publishedAt != null &&
                !ann.publishedAt!.isBefore(startDate),
          )
          .toList();
    }

    if (endDate != null) {
      final inclusiveEndDate = endDate
          .add(const Duration(days: 1))
          .subtract(const Duration(microseconds: 1));
      filtered = filtered
          .where(
            (ann) =>
                ann.publishedAt != null &&
                !ann.publishedAt!.isAfter(inclusiveEndDate),
          )
          .toList();
    }

    setState(() => _filteredAnnouncements = filtered);
  }

  void _resetFilters() {
    _formKey.currentState?.reset();
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(
        child: RefreshIndicator(
          onRefresh: _refreshAnnouncements,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: _buildStatsCards()),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: AnnouncementFilterSearch(
                  formKey: _formKey,
                  isFilterVisible: _isFilterVisible,
                  onToggleVisibility: () =>
                      setState(() => _isFilterVisible = !_isFilterVisible),
                  onFilter: _applyFilters,
                  onReset: _resetFilters,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: AnnouncementTableWidget(
                  announcements: _filteredAnnouncements,
                  isLoading: _isLoading,
                  onRefresh: _refreshAnnouncements,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            'Announcement Management',
            style: AppTextStyle.headlineMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 4),
          AppText(
            'Manage announcements for customers',
            style: AppTextStyle.bodyLarge,
            color: context.colorScheme.onSurface.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          AppButton(
            color: AppButtonColor.primary,
            isFullWidth: false,
            text: 'Add Announcement',
            leadingIcon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    final total = _announcements.length;
    final active = _announcements.where((a) => a.isActive).length;
    final inactive = total - active;
    final today = _announcements.where((a) {
      if (a.publishedAt == null) return false;
      final now = DateTime.now();
      return a.publishedAt!.year == now.year &&
          a.publishedAt!.month == now.month &&
          a.publishedAt!.day == now.day;
    }).length;

    return Column(
      children: [
        StatTile(
          title: 'Total Announcements',
          value: '$total',
          icon: Icons.volume_up,
          color: Colors.blue.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: 'Active',
          value: '$active',
          icon: Icons.check_circle,
          color: Colors.green.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: 'Inactive',
          value: '$inactive',
          icon: Icons.cancel,
          color: Colors.red.shade100,
        ),
        const SizedBox(height: 12),
        StatTile(
          title: 'Today',
          value: '$today',
          icon: Icons.calendar_today,
          color: Colors.purple.shade100,
        ),
      ],
    );
  }

  List<Announcement> _generateMockAnnouncements() {
    final now = DateTime.now();
    return List.generate(15, (index) {
      final id = index + 1;
      return Announcement(
        id: id,
        isActive: id % 3 != 0,
        publishedAt: now.subtract(Duration(days: id * 2)),
        translations: [
          AnnouncementTranslation(
            id: id,
            locale: 'en',
            title: 'Announcement Title Number $id: Important Update',
            content:
                'This is the detailed content for announcement number $id. It contains important information that all customers should read carefully.',
            createdAt: now.subtract(Duration(days: id * 2 + 1)),
            updatedAt: now.subtract(Duration(days: id * 2)),
          ),
        ],
        createdAt: now.subtract(Duration(days: id * 2 + 1)),
        updatedAt: now.subtract(Duration(days: id * 2)),
      );
    });
  }
}
