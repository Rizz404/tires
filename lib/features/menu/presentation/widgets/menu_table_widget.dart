import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class MenuTableWidget extends StatelessWidget {
  final List<Menu> menus;
  final bool isLoading;
  final VoidCallback? onRefresh;

  const MenuTableWidget({
    super.key,
    required this.menus,
    this.isLoading = false,
    this.onRefresh,
  });

  Color _colorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading && menus.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (menus.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restaurant_menu_outlined,
                size: 64,
                color: context.colorScheme.onSurface.withOpacity(0.3),
              ),
              const SizedBox(height: 16),
              AppText(
                'No menus found',
                style: AppTextStyle.bodyLarge,
                color: context.colorScheme.onSurface.withOpacity(0.6),
              ),
              if (onRefresh != null) ...[
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onRefresh,
                  child: const AppText('Refresh'),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 8),
          child: AppText('Menu List', style: AppTextStyle.titleLarge),
        ),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: context.colorScheme.outlineVariant),
          ),
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTableHeader(context),
                  const Divider(height: 1, thickness: 1),
                  ...menus.map((menu) => _buildTableRow(context, menu)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: context.colorScheme.surface.withOpacity(0.5),
      child: Row(
        children: const [
          SizedBox(width: 40, child: Text('')),
          SizedBox(
            width: 300,
            child: AppText('MENU', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 120,
            child: AppText('PRICE', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 150,
            child: AppText('TIME REQUIRED', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 80,
            child: AppText('ORDER', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 120,
            child: AppText('STATUS', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 80,
            child: Center(
              child: AppText('ACTION', fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, Menu menu) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 40, child: Checkbox(value: false, onChanged: (v) {})),
          SizedBox(
            width: 300,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: _colorFromHex(menu.color.hex),
                  child: AppText(
                    menu.name.isNotEmpty ? menu.name[0].toUpperCase() : 'M',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        menu.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                      ),
                      if (menu.description != null) ...[
                        const SizedBox(height: 2),
                        AppText(
                          menu.description!,
                          style: AppTextStyle.bodySmall,
                          color: context.colorScheme.onSurface.withOpacity(0.7),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 120,
            child: AppText(
              menu.price.formatted,
              color: context.colorScheme.onSurface.withOpacity(0.9),
            ),
          ),
          SizedBox(
            width: 150,
            child: AppText(
              '${menu.requiredTime} min',
              color: context.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(
            width: 80,
            child: AppText(
              '${Random().nextInt(150)}',
              color: context.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(width: 120, child: _buildStatusChip(context, menu)),
          SizedBox(
            width: 80,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.more_horiz, size: 20),
                onPressed: () {},
                tooltip: 'More Actions',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, Menu menu) {
    return Chip(
      label: Text(menu.isActive ? 'Active' : 'Inactive'),
      backgroundColor: menu.isActive
          ? Colors.green.shade100
          : Colors.grey.shade300,
      labelStyle: TextStyle(
        color: menu.isActive ? Colors.green.shade800 : Colors.grey.shade800,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      visualDensity: VisualDensity.compact,
      side: BorderSide.none,
    );
  }
}
