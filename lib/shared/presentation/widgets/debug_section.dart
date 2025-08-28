import 'package:flutter/material.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

/// A reusable debug section widget that can be used anywhere in the app
/// This widget provides debugging tools with consistent theming
class DebugSection extends StatelessWidget {
  /// Title for the debug section
  final String title;

  /// List of debug actions to display
  final List<DebugAction> actions;

  /// Whether to show the debug section (useful for conditional display)
  final bool visible;

  /// Custom background color (optional)
  final Color? backgroundColor;

  /// Custom icon for the debug section
  final IconData icon;

  const DebugSection({
    super.key,
    this.title = '🔧 Debug Tools',
    required this.actions,
    this.visible = true,
    this.backgroundColor,
    this.icon = Icons.bug_report,
  });

  /// Factory method for creating a common refresh debug section
  factory DebugSection.createRefreshSection({
    required VoidCallback onRefresh,
    required BuildContext context,
    String title = '🔧 Debug Tools',
    String refreshLabel = 'Refresh with Debug',
    String logsLabel = 'Show Logs',
    String? refreshEndpoint,
  }) {
    return DebugSection(
      title: title,
      actions: [
        DebugAction.refresh(
          label: refreshLabel,
          onPressed: onRefresh,
          debugEndpoint: refreshEndpoint,
        ),
        DebugAction.viewLogs(label: logsLabel, context: context),
      ],
    );
  }

  /// Factory method for creating a common API testing debug section
  factory DebugSection.createApiTestSection({
    required List<DebugAction> apiActions,
    required BuildContext context,
    String title = '🌐 API Debug Tools',
  }) {
    return DebugSection(
      title: title,
      actions: [
        ...apiActions,
        DebugAction.viewLogs(label: 'Show Logs', context: context),
      ],
    );
  }

  /// Factory method for creating a common data inspection debug section
  factory DebugSection.createDataInspectionSection({
    required List<DebugAction> inspectionActions,
    required BuildContext context,
    String title = '📊 Data Debug Tools',
  }) {
    return DebugSection(
      title: title,
      actions: [
        ...inspectionActions,
        DebugAction.viewLogs(label: 'Show Console Logs', context: context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    return Card(
      color:
          backgroundColor ??
          (context.isDarkMode
              ? context.colorScheme.surface.withValues(alpha: 0.3)
              : Colors.orange.shade50),
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 12),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: context.isDarkMode
              ? Colors.orange.shade300
              : Colors.orange.shade700,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AppText(
            title,
            style: AppTextStyle.titleMedium,
            fontWeight: FontWeight.bold,
            color: context.isDarkMode
                ? Colors.orange.shade300
                : Colors.orange.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: actions
          .map((action) => _buildActionButton(context, action))
          .toList(),
    );
  }

  Widget _buildActionButton(BuildContext context, DebugAction action) {
    final isDestructive = action.type == DebugActionType.destructive;
    final isInfo = action.type == DebugActionType.info;

    Color backgroundColor;
    Color foregroundColor;

    if (context.isDarkMode) {
      if (isDestructive) {
        backgroundColor = Colors.red.shade900;
        foregroundColor = Colors.red.shade200;
      } else if (isInfo) {
        backgroundColor = Colors.blue.shade900;
        foregroundColor = Colors.blue.shade200;
      } else {
        backgroundColor = Colors.orange.shade900;
        foregroundColor = Colors.orange.shade200;
      }
    } else {
      if (isDestructive) {
        backgroundColor = Colors.red.shade100;
        foregroundColor = Colors.red.shade800;
      } else if (isInfo) {
        backgroundColor = Colors.blue.shade100;
        foregroundColor = Colors.blue.shade800;
      } else {
        backgroundColor = Colors.orange.shade100;
        foregroundColor = Colors.orange.shade800;
      }
    }

    return ElevatedButton.icon(
      onPressed: action.onPressed,
      icon: Icon(action.icon, size: 16),
      label: AppText(
        action.label,
        style: AppTextStyle.labelMedium,
        fontWeight: FontWeight.w500,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

/// Model class for debug actions
class DebugAction {
  /// Label text for the action button
  final String label;

  /// Icon for the action button
  final IconData icon;

  /// Callback function when button is pressed
  final VoidCallback onPressed;

  /// Type of debug action (affects styling)
  final DebugActionType type;

  const DebugAction({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.type = DebugActionType.normal,
  });

  /// Factory constructor for refresh actions
  factory DebugAction.refresh({
    required String label,
    required VoidCallback onPressed,
    String? debugEndpoint,
  }) {
    return DebugAction(
      label: label,
      icon: Icons.refresh,
      onPressed: () {
        if (debugEndpoint != null) {
          DebugHelper.logApiResponse({}, endpoint: debugEndpoint);
        }
        onPressed();
      },
      type: DebugActionType.info,
    );
  }

  /// Factory constructor for log viewing actions
  factory DebugAction.viewLogs({
    required String label,
    required BuildContext context,
    String? message,
  }) {
    return DebugAction(
      label: label,
      icon: Icons.visibility,
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AppText(
              message ?? 'Check console for detailed debugging logs',
            ),
            backgroundColor: context.isDarkMode
                ? Colors.orange.shade800
                : Colors.orange,
          ),
        );
      },
      type: DebugActionType.normal,
    );
  }

  /// Factory constructor for clear/reset actions
  factory DebugAction.clear({
    required String label,
    required VoidCallback onPressed,
  }) {
    return DebugAction(
      label: label,
      icon: Icons.clear_all,
      onPressed: onPressed,
      type: DebugActionType.destructive,
    );
  }

  /// Factory constructor for API testing actions
  factory DebugAction.testApi({
    required String label,
    required VoidCallback onPressed,
  }) {
    return DebugAction(
      label: label,
      icon: Icons.api,
      onPressed: onPressed,
      type: DebugActionType.info,
    );
  }

  /// Factory constructor for data inspection actions
  factory DebugAction.inspect({
    required String label,
    required VoidCallback onPressed,
  }) {
    return DebugAction(
      label: label,
      icon: Icons.search,
      onPressed: onPressed,
      type: DebugActionType.normal,
    );
  }
}

/// Enum for different types of debug actions
enum DebugActionType {
  /// Normal debug action (orange theme)
  normal,

  /// Information or API related action (blue theme)
  info,

  /// Destructive action like clear/reset (red theme)
  destructive,
}
