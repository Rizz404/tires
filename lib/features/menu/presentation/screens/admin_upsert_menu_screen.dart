import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/usecases/create_menu_usecase.dart';
import 'package:tires/features/menu/domain/usecases/delete_menu_usecase.dart';
import 'package:tires/features/menu/domain/usecases/update_menu_usecase.dart';
import 'package:tires/features/menu/presentation/providers/menu_mutation_state.dart';
import 'package:tires/features/menu/presentation/providers/menu_providers.dart';
import 'package:tires/features/menu/presentation/validations/menu_validators.dart';
import 'package:tires/l10n_generated/app_localizations.dart';
import 'package:tires/shared/presentation/utils/app_toast.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_radio_group.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_text_field.dart';
import 'package:tires/shared/presentation/widgets/error_summary_box.dart';
import 'package:tires/shared/presentation/widgets/loading_overlay.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class AdminUpsertMenuScreen extends ConsumerStatefulWidget {
  final Menu? menu;

  const AdminUpsertMenuScreen({super.key, this.menu});

  @override
  ConsumerState<AdminUpsertMenuScreen> createState() =>
      _AdminUpsertMenuScreenState();
}

class _AdminUpsertMenuScreenState extends ConsumerState<AdminUpsertMenuScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<DomainValidationError>? _validationErrors;
  bool _isSubmitting = false;

  bool get _isEditMode => widget.menu != null;

  @override
  void initState() {
    super.initState();
    if (_isEditMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _populateForm();
      });
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.fields.forEach((key, field) {
      field.dispose();
    });
    super.dispose();
  }

  Color _colorFromHex(String hexColor) {
    try {
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }
      return Color(int.parse(hexColor, radix: 16));
    } catch (e) {
      // Return default color if parsing fails
      return Colors.grey;
    }
  }

  /// Helper method to clean formatted numbers before parsing
  int _parseFormattedNumber(String value) {
    final cleanValue = value.replaceAll(RegExp(r'[,¥$\s]'), '');
    return int.parse(cleanValue);
  }

  void _populateForm() {
    final menu = widget.menu;
    if (menu != null) {
      _formKey.currentState?.patchValue({
        'name_en': menu.translations?.en?.name ?? menu.name,
        'description_en':
            menu.translations?.en?.description ?? menu.description,
        'name_ja': menu.translations?.ja?.name,
        'description_ja': menu.translations?.ja?.description,
        'required_time': menu.requiredTime.toString(),
        'price': menu.price.amount
            .toString(), // Convert to string for proper formatting
        'display_order': menu.displayOrder.toString(),
        'color': menu.color.hex,
        'is_active': menu.isActive,
      });
      // Force rebuild to ensure form fields are updated
      setState(() {});
    }
  }

  void _handleSubmit(WidgetRef ref) {
    if (_isSubmitting) return;

    setState(() {
      _validationErrors = null;
      _isSubmitting = true;
    });

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      final notifier = ref.read(menuMutationNotifierProvider.notifier);

      final nameEn = values['name_en'] as String;
      final descriptionEn = values['description_en'] as String;
      final nameJa = values['name_ja'] as String?;
      final descriptionJa = values['description_ja'] as String?;
      final requiredTime = int.parse(values['required_time'] as String);

      // Clean price value by removing commas and currency symbols before parsing
      final priceString = values['price'] as String;
      final price = _parseFormattedNumber(priceString);

      final displayOrder = int.parse(values['display_order'] as String);

      final color = values['color'] as String;
      final isActive = values['is_active'] as bool;

      final menuTranslation = MenuTranslation(
        en: MenuContent(name: nameEn, description: descriptionEn),
        ja: MenuContent(name: nameJa, description: descriptionJa),
      );

      if (_isEditMode) {
        notifier.updateMenu(
          UpdateMenuParams(
            id: widget.menu!.id,
            translations: menuTranslation,
            requiredTime: requiredTime,
            price: price,
            displayOrder: displayOrder,
            color: color,
            isActive: isActive,
          ),
        );
      } else {
        notifier.createMenu(
          CreateMenuParams(
            translations: menuTranslation,
            requiredTime: requiredTime,
            price: price,
            photoPath: '', // Default empty for now
            displayOrder: 0, // Default order
            color: color,
            isActive: isActive,
          ),
        );
      }
    } else {
      setState(() {
        _isSubmitting = false;
      });
      AppToast.showError(
        context,
        message: 'Please correct the errors in the form.',
      );
    }
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              context.theme.dialogTheme.backgroundColor ??
              context.theme.colorScheme.surface,
          title: AppText(context.l10n.adminUpsertMenuScreenDeleteModalTitle),
          content: AppText(
            context.l10n.adminUpsertMenuScreenDeleteModalContent,
          ),
          actions: [
            AppButton(
              text: context.l10n.adminUpsertMenuScreenDeleteModalCancelButton,
              onPressed: () => Navigator.of(context).pop(),
              variant: AppButtonVariant.outlined,
              color: AppButtonColor.neutral,
              isFullWidth: false,
            ),
            const SizedBox(width: 8),
            AppButton(
              text: context.l10n.adminUpsertMenuScreenDeleteModalDeleteButton,
              onPressed: () {
                Navigator.of(context).pop();
                final notifier = ref.read(
                  menuMutationNotifierProvider.notifier,
                );
                notifier.deleteMenu(DeleteMenuParams(widget.menu!.id));
              },
              variant: AppButtonVariant.filled,
              color: AppButtonColor.error,
              isFullWidth: false,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    ref.listen(menuMutationNotifierProvider, (previous, next) {
      if (next.status != MenuMutationStatus.loading) {
        setState(() {
          _isSubmitting = false;
        });
      }

      if (next.status == MenuMutationStatus.success) {
        AppToast.showSuccess(
          context,
          message:
              next.successMessage ??
              (_isEditMode
                  ? l10n.adminUpsertMenuScreenUpdateMenu
                  : l10n.adminUpsertMenuScreenSaveMenu),
        );
        context.router.pop();
      } else if (next.status == MenuMutationStatus.error &&
          next.failure != null) {
        if (next.failure is ValidationFailure) {
          setState(() {
            _validationErrors = (next.failure as ValidationFailure).errors;
          });
        } else {
          debugPrint(next.failure.toString());
          debugPrint(next.failure?.message);
          AppToast.showError(context, message: next.failure!.message);
        }
      }
    });

    final mutationState = ref.watch(menuMutationNotifierProvider);
    final isLoading = mutationState.status == MenuMutationStatus.loading;

    return Scaffold(
      appBar: const AdminAppBar(),
      endDrawer: const AdminEndDrawer(),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: ScreenWrapper(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(l10n),
                const SizedBox(height: 24),
                _buildForm(l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          _isEditMode
              ? l10n.adminUpsertMenuScreenEditTitle
              : 'Add Menu', // Fallback since adminUpsertMenuScreenPageTitle doesn't exist
          style: AppTextStyle.headlineSmall,
        ),
        const SizedBox(height: 4),
        AppText(
          _isEditMode
              ? l10n.adminUpsertMenuScreenEditSubtitle
              : l10n.adminUpsertMenuScreenAddSubtitle,
          style: AppTextStyle.bodyMedium,
          softWrap: true,
        ),
      ],
    );
  }

  Widget _buildForm(L10n l10n) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_validationErrors != null)
            ErrorSummaryBox(errors: _validationErrors!),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEnglishSection(l10n),
                  const SizedBox(height: 24),
                  _buildJapaneseSection(l10n),
                  const SizedBox(height: 24),
                  _buildBasicSettings(l10n),
                  const SizedBox(height: 24),
                  _buildVisualSettings(l10n),
                  const SizedBox(height: 24),
                  _buildStatusSettings(l10n),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildActionButtons(l10n),
        ],
      ),
    );
  }

  Widget _buildEnglishSection(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          l10n.adminUpsertMenuScreenEnglishInfo,
          style: AppTextStyle.titleMedium,
        ),
        const SizedBox(height: 8),
        const AppText(
          'Primary language information for the menu',
          style: AppTextStyle.bodySmall,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'name_en',
          label: l10n.adminUpsertMenuScreenMenuNameEn,
          placeHolder: l10n.adminUpsertMenuScreenPlaceholderNameEn,
          validator: MenuValidators.nameEn(context),
          type: AppTextFieldType.text,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'description_en',
          label: l10n.adminUpsertMenuScreenDescriptionEn,
          placeHolder: l10n.adminUpsertMenuScreenPlaceholderDescEn,
          validator: MenuValidators.descriptionEn(context),
          type: AppTextFieldType.multiline,
          maxLines: 5,
        ),
      ],
    );
  }

  Widget _buildJapaneseSection(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          l10n.adminUpsertMenuScreenJapaneseInfo,
          style: AppTextStyle.titleMedium,
        ),
        const SizedBox(height: 8),
        const AppText(
          'Optional Japanese translation for the menu',
          style: AppTextStyle.bodySmall,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'name_ja',
          label: l10n.adminUpsertMenuScreenMenuNameJa,
          placeHolder: l10n.adminUpsertMenuScreenPlaceholderNameJa,
          validator: MenuValidators.nameJa(context),
          type: AppTextFieldType.text,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'description_ja',
          label: l10n.adminUpsertMenuScreenDescriptionJa,
          placeHolder: l10n.adminUpsertMenuScreenPlaceholderDescJa,
          validator: MenuValidators.descriptionJa(context),
          type: AppTextFieldType.multiline,
          maxLines: 5,
        ),
      ],
    );
  }

  Widget _buildBasicSettings(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          l10n.adminUpsertMenuScreenBasicSettings,
          style: AppTextStyle.titleMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                name: 'required_time',
                label: l10n.adminUpsertMenuScreenFormRequiredTime,
                placeHolder: '60',
                validator: MenuValidators.requiredTime(context),
                type: AppTextFieldType.number,
                suffixText: 'min',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppTextField(
                name: 'price',
                label: l10n.adminUpsertMenuScreenFormPrice,
                placeHolder: '5000',
                validator: MenuValidators.price(context),
                type: AppTextFieldType.priceJP,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AppText(
          l10n.adminUpsertMenuScreenHelpRequiredTime,
          style: AppTextStyle.bodySmall,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'display_order',
          label: 'Display Order',
          placeHolder: '0',
          validator: MenuValidators.displayOrder(context),
          type: AppTextFieldType.number,
        ),
      ],
    );
  }

  Widget _buildVisualSettings(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          l10n.adminUpsertMenuScreenVisualSettings,
          style: AppTextStyle.titleMedium,
        ),
        const SizedBox(height: 16),
        FormBuilderField<String>(
          name: 'color',
          initialValue: '#2196F3',
          builder: (field) {
            final colors = [
              {'name': 'Blue', 'value': '#2196F3'},
              {'name': 'Green', 'value': '#4CAF50'},
              {'name': 'Yellow', 'value': '#FFC107'},
              {'name': 'Red', 'value': '#F44336'},
              {'name': 'Purple', 'value': '#9C27B0'},
              {'name': 'Pink', 'value': '#E91E63'},
              {'name': 'Cyan', 'value': '#00BCD4'},
              {'name': 'Lime', 'value': '#8BC34A'},
              {'name': 'Orange', 'value': '#FF9800'},
              {'name': 'Gray', 'value': '#9E9E9E'},
            ];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  'Menu Color',
                  style: AppTextStyle.bodyMedium,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: colors.map((color) {
                    final isSelected = field.value == color['value'];
                    final colorValue = _colorFromHex(color['value'] as String);

                    return GestureDetector(
                      onTap: () => field.didChange(color['value'] as String),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: colorValue,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? context.colorScheme.primary
                                : Colors.grey.shade300,
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )
                            : null,
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        AppText(
          l10n.adminUpsertMenuScreenHelpColor,
          style: AppTextStyle.bodySmall,
        ),
      ],
    );
  }

  Widget _buildStatusSettings(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          l10n.adminUpsertMenuScreenStatusSettings,
          style: AppTextStyle.titleMedium,
        ),
        const SizedBox(height: 16),
        AppRadioGroup<bool>(
          name: 'is_active',
          label: l10n.adminUpsertMenuScreenFormActiveStatus,
          options: [
            FormBuilderFieldOption(
              value: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(l10n.adminUpsertMenuScreenStatusActive),
                  AppText(
                    l10n.adminUpsertMenuScreenHelpActiveStatus,
                    style: AppTextStyle.bodySmall,
                  ),
                ],
              ),
            ),
            FormBuilderFieldOption(
              value: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(l10n.adminUpsertMenuScreenStatusInactive),
                  AppText(
                    l10n.adminUpsertMenuScreenHelpInactiveStatus,
                    style: AppTextStyle.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(L10n l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (_isEditMode)
          AppButton(
            text: l10n.adminUpsertMenuScreenDeleteModalDeleteButton,
            onPressed: _showDeleteConfirmationDialog,
            variant: AppButtonVariant.outlined,
            color: AppButtonColor.error,
            isFullWidth: false,
          )
        else
          AppButton(
            text: l10n.adminUpsertMenuScreenBack,
            onPressed: () => context.router.pop(),
            variant: AppButtonVariant.outlined,
            color: AppButtonColor.neutral,
            isFullWidth: false,
          ),
        const SizedBox(width: 16),
        AppButton(
          text: _isEditMode
              ? l10n.adminUpsertMenuScreenUpdateMenu
              : l10n.adminUpsertMenuScreenSaveMenu,
          onPressed: () => _handleSubmit(ref),
          isLoading: _isSubmitting,
          isFullWidth: false,
        ),
      ],
    );
  }
}
