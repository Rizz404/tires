import 'package:flutter/material.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

// Enum for the button's visual style (filled, outlined, etc.)
enum AppButtonVariant { filled, outlined, text }

// Enum for the button's color scheme, aligning with the theme
enum AppButtonColor { primary, secondary, success, error, neutral }

// Enum for the button's size
enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppButtonVariant variant;
  final AppButtonColor color;
  final AppButtonSize size;
  final bool isFullWidth;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.variant = AppButtonVariant.filled,
    this.color = AppButtonColor.primary,
    this.size = AppButtonSize.medium,
    this.isFullWidth = true,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ({Color? backgroundColor, Color foregroundColor, BorderSide? side})
    _getColorProps() {
      final colorMap = {
        AppButtonColor.primary: (
          bg: theme.colorScheme.primary,
          fg: theme.colorScheme.onPrimary,
        ),
        AppButtonColor.secondary: (
          bg: theme.colorScheme.secondary,
          fg: Colors.white,
        ),
        AppButtonColor.success: (bg: Colors.green, fg: Colors.white),
        AppButtonColor.error: (
          bg: theme.colorScheme.error,
          fg: theme.colorScheme.onError,
        ),
        AppButtonColor.neutral: (
          bg: theme.colorScheme.surfaceVariant,
          fg: theme.colorScheme.onSurfaceVariant,
        ),
      };

      final selectedColorSet = colorMap[color]!;

      switch (variant) {
        case AppButtonVariant.filled:
          return (
            backgroundColor: selectedColorSet.bg,
            foregroundColor: selectedColorSet.fg,
            side: null,
          );
        case AppButtonVariant.outlined:
          return (
            backgroundColor: Colors.transparent,
            foregroundColor: selectedColorSet.bg,
            side: BorderSide(color: selectedColorSet.bg, width: 1.5),
          );
        case AppButtonVariant.text:
          return (
            backgroundColor: Colors.transparent,
            foregroundColor: selectedColorSet.bg,
            side: null,
          );
      }
    }

    ({EdgeInsetsGeometry padding, TextStyle? textStyle, double height})
    _getSizingProps() {
      switch (size) {
        case AppButtonSize.small:
          return (
            padding: const EdgeInsets.symmetric(horizontal: 16),
            textStyle: theme.textTheme.labelLarge,
            height: 40,
          );
        case AppButtonSize.large:
          return (
            padding: const EdgeInsets.symmetric(horizontal: 32),
            textStyle: theme.textTheme.titleMedium,
            height: 60,
          );
        case AppButtonSize.medium:
          return (
            padding: const EdgeInsets.symmetric(horizontal: 24),
            textStyle: theme.textTheme.titleSmall,
            height: 50,
          );
      }
    }

    final colorProps = _getColorProps();
    final sizingProps = _getSizingProps();

    final progressIndicatorColor = variant == AppButtonVariant.filled
        ? colorProps.foregroundColor
        : colorProps.backgroundColor;

    final buttonContent = isLoading
        ? SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: progressIndicatorColor,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leadingIcon != null) ...[
                leadingIcon!,
                const SizedBox(width: 8),
              ],
              AppText(text),
              if (trailingIcon != null) ...[
                const SizedBox(width: 8),
                trailingIcon!,
              ],
            ],
          );

    final baseStyle = ButtonStyle(
      padding: WidgetStateProperty.all(sizingProps.padding),
      textStyle: WidgetStateProperty.all(sizingProps.textStyle),
      backgroundColor: WidgetStateProperty.all(colorProps.backgroundColor),
      foregroundColor: WidgetStateProperty.all(colorProps.foregroundColor),
      side: WidgetStateProperty.all(colorProps.side),
      minimumSize: isFullWidth
          ? WidgetStateProperty.all(Size.fromHeight(sizingProps.height))
          : null,
      maximumSize: isFullWidth
          ? WidgetStateProperty.all(Size.fromHeight(sizingProps.height))
          : null,
      elevation: variant == AppButtonVariant.filled
          ? WidgetStateProperty.all(2)
          : WidgetStateProperty.all(0),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    switch (variant) {
      case AppButtonVariant.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: baseStyle,
          child: buttonContent,
        );
      case AppButtonVariant.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: baseStyle,
          child: buttonContent,
        );
      case AppButtonVariant.filled:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: baseStyle,
          child: buttonContent,
        );
    }
  }
}
