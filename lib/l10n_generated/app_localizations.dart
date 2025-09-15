import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n_generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n? of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
    Locale('ja'),
  ];

  /// No description provided for @adminUpsertAnnouncementScreenPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Announcement'**
  String get adminUpsertAnnouncementScreenPageTitle;

  /// No description provided for @adminUpsertAnnouncementScreenPageDescription.
  ///
  /// In en, this message translates to:
  /// **'Create a new announcement with multilingual support.'**
  String get adminUpsertAnnouncementScreenPageDescription;

  /// No description provided for @adminUpsertAnnouncementScreenHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Announcement'**
  String get adminUpsertAnnouncementScreenHeaderTitle;

  /// No description provided for @adminUpsertAnnouncementScreenHeaderDescription.
  ///
  /// In en, this message translates to:
  /// **'Create a new announcement with multilingual support.'**
  String get adminUpsertAnnouncementScreenHeaderDescription;

  /// No description provided for @adminUpsertAnnouncementScreenBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get adminUpsertAnnouncementScreenBackButton;

  /// No description provided for @adminUpsertAnnouncementScreenFormSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Announcement Information'**
  String get adminUpsertAnnouncementScreenFormSectionTitle;

  /// No description provided for @adminUpsertAnnouncementScreenFormSectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Fill out the form below to create a new announcement with English and Japanese support.'**
  String get adminUpsertAnnouncementScreenFormSectionDescription;

  /// No description provided for @adminUpsertAnnouncementScreenTabEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get adminUpsertAnnouncementScreenTabEnglish;

  /// No description provided for @adminUpsertAnnouncementScreenTabJapanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese (日本語)'**
  String get adminUpsertAnnouncementScreenTabJapanese;

  /// No description provided for @adminUpsertAnnouncementScreenEnSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'English Content'**
  String get adminUpsertAnnouncementScreenEnSectionTitle;

  /// No description provided for @adminUpsertAnnouncementScreenEnSectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Fill in the title and content in English.'**
  String get adminUpsertAnnouncementScreenEnSectionDescription;

  /// No description provided for @adminUpsertAnnouncementScreenEnTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title (English)'**
  String get adminUpsertAnnouncementScreenEnTitleLabel;

  /// No description provided for @adminUpsertAnnouncementScreenEnTitlePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter the announcement title in English...'**
  String get adminUpsertAnnouncementScreenEnTitlePlaceholder;

  /// No description provided for @adminUpsertAnnouncementScreenEnContentLabel.
  ///
  /// In en, this message translates to:
  /// **'Content (English)'**
  String get adminUpsertAnnouncementScreenEnContentLabel;

  /// No description provided for @adminUpsertAnnouncementScreenEnContentPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter the announcement content in English...'**
  String get adminUpsertAnnouncementScreenEnContentPlaceholder;

  /// No description provided for @adminUpsertAnnouncementScreenEnContentHelper.
  ///
  /// In en, this message translates to:
  /// **'Write the announcement content in English.'**
  String get adminUpsertAnnouncementScreenEnContentHelper;

  /// No description provided for @adminUpsertAnnouncementScreenJaSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'コンテンツ (Japanese Content)'**
  String get adminUpsertAnnouncementScreenJaSectionTitle;

  /// No description provided for @adminUpsertAnnouncementScreenJaSectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Fill in the title and content in Japanese.'**
  String get adminUpsertAnnouncementScreenJaSectionDescription;

  /// No description provided for @adminUpsertAnnouncementScreenJaTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'タイトル (Japanese Title)'**
  String get adminUpsertAnnouncementScreenJaTitleLabel;

  /// No description provided for @adminUpsertAnnouncementScreenJaTitlePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'日本語でお知らせのタイトルを入力してください...'**
  String get adminUpsertAnnouncementScreenJaTitlePlaceholder;

  /// No description provided for @adminUpsertAnnouncementScreenJaContentLabel.
  ///
  /// In en, this message translates to:
  /// **'コンテンツ (Japanese Content)'**
  String get adminUpsertAnnouncementScreenJaContentLabel;

  /// No description provided for @adminUpsertAnnouncementScreenJaContentPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'日本語でお知らせの内容を入力してください...'**
  String get adminUpsertAnnouncementScreenJaContentPlaceholder;

  /// No description provided for @adminUpsertAnnouncementScreenJaContentHelper.
  ///
  /// In en, this message translates to:
  /// **'日本語でお知らせの内容を記入してください。'**
  String get adminUpsertAnnouncementScreenJaContentHelper;

  /// No description provided for @adminUpsertAnnouncementScreenCommonSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Common Settings'**
  String get adminUpsertAnnouncementScreenCommonSettingsTitle;

  /// No description provided for @adminUpsertAnnouncementScreenPublishedAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Publication Date & Time'**
  String get adminUpsertAnnouncementScreenPublishedAtLabel;

  /// No description provided for @adminUpsertAnnouncementScreenPublishedAtHelper.
  ///
  /// In en, this message translates to:
  /// **'If left empty, the current time will be used.'**
  String get adminUpsertAnnouncementScreenPublishedAtHelper;

  /// No description provided for @adminUpsertAnnouncementScreenStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminUpsertAnnouncementScreenStatusLabel;

  /// No description provided for @adminUpsertAnnouncementScreenStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminUpsertAnnouncementScreenStatusActive;

  /// No description provided for @adminUpsertAnnouncementScreenStatusInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get adminUpsertAnnouncementScreenStatusInactive;

  /// No description provided for @adminUpsertAnnouncementScreenPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get adminUpsertAnnouncementScreenPreviewTitle;

  /// No description provided for @adminUpsertAnnouncementScreenPreviewShow.
  ///
  /// In en, this message translates to:
  /// **'Show Preview'**
  String get adminUpsertAnnouncementScreenPreviewShow;

  /// No description provided for @adminUpsertAnnouncementScreenPreviewHide.
  ///
  /// In en, this message translates to:
  /// **'Hide Preview'**
  String get adminUpsertAnnouncementScreenPreviewHide;

  /// No description provided for @adminUpsertAnnouncementScreenPreviewTitlePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Announcement title will appear here'**
  String get adminUpsertAnnouncementScreenPreviewTitlePlaceholder;

  /// No description provided for @adminUpsertAnnouncementScreenPreviewContentPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Announcement content will appear here'**
  String get adminUpsertAnnouncementScreenPreviewContentPlaceholder;

  /// No description provided for @adminUpsertAnnouncementScreenPreviewDateNotSelected.
  ///
  /// In en, this message translates to:
  /// **'Date not selected'**
  String get adminUpsertAnnouncementScreenPreviewDateNotSelected;

  /// No description provided for @adminUpsertAnnouncementScreenCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminUpsertAnnouncementScreenCancelButton;

  /// No description provided for @adminUpsertAnnouncementScreenSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Announcement'**
  String get adminUpsertAnnouncementScreenSaveButton;

  /// No description provided for @adminUpsertAnnouncementScreenRequiredField.
  ///
  /// In en, this message translates to:
  /// **'*'**
  String get adminUpsertAnnouncementScreenRequiredField;

  /// No description provided for @adminUpsertAnnouncementScreenMaxCharacters.
  ///
  /// In en, this message translates to:
  /// **'Maximum 255 characters'**
  String get adminUpsertAnnouncementScreenMaxCharacters;

  /// No description provided for @adminUpsertAnnouncementScreenMaxCharactersJa.
  ///
  /// In en, this message translates to:
  /// **'最大255文字'**
  String get adminUpsertAnnouncementScreenMaxCharactersJa;

  /// No description provided for @adminUpsertAnnouncementScreenEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Announcement'**
  String get adminUpsertAnnouncementScreenEditTitle;

  /// No description provided for @adminUpsertAnnouncementScreenEditSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update multilingual announcement information'**
  String get adminUpsertAnnouncementScreenEditSubtitle;

  /// No description provided for @adminUpsertAnnouncementScreenFormCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Announcement Information'**
  String get adminUpsertAnnouncementScreenFormCardTitle;

  /// No description provided for @adminUpsertAnnouncementScreenFormCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update the form below to edit the multilingual announcement'**
  String get adminUpsertAnnouncementScreenFormCardSubtitle;

  /// No description provided for @adminUpsertAnnouncementScreenFormCreatedAt.
  ///
  /// In en, this message translates to:
  /// **'Created at'**
  String get adminUpsertAnnouncementScreenFormCreatedAt;

  /// No description provided for @adminUpsertAnnouncementScreenFormTabsTranslationFilledTooltip.
  ///
  /// In en, this message translates to:
  /// **'Translation filled'**
  String get adminUpsertAnnouncementScreenFormTabsTranslationFilledTooltip;

  /// No description provided for @adminUpsertAnnouncementScreenFormJapaneseSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Japanese Content'**
  String get adminUpsertAnnouncementScreenFormJapaneseSectionTitle;

  /// No description provided for @adminUpsertAnnouncementScreenFormJapaneseSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Edit the title and content in Japanese'**
  String get adminUpsertAnnouncementScreenFormJapaneseSectionSubtitle;

  /// No description provided for @adminUpsertAnnouncementScreenFormCommonSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get adminUpsertAnnouncementScreenFormCommonSettingsTitle;

  /// No description provided for @adminUpsertAnnouncementScreenFormTranslationInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Translation Information'**
  String get adminUpsertAnnouncementScreenFormTranslationInfoTitle;

  /// No description provided for @adminUpsertAnnouncementScreenFormTranslationInfoLanguageEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get adminUpsertAnnouncementScreenFormTranslationInfoLanguageEn;

  /// No description provided for @adminUpsertAnnouncementScreenFormTranslationInfoLanguageJa.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get adminUpsertAnnouncementScreenFormTranslationInfoLanguageJa;

  /// No description provided for @adminUpsertAnnouncementScreenFormTranslationInfoAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get adminUpsertAnnouncementScreenFormTranslationInfoAvailable;

  /// No description provided for @adminUpsertAnnouncementScreenFormTranslationInfoNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get adminUpsertAnnouncementScreenFormTranslationInfoNotAvailable;

  /// No description provided for @adminUpsertAnnouncementScreenFormAnnouncementInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Announcement Information'**
  String get adminUpsertAnnouncementScreenFormAnnouncementInfoTitle;

  /// No description provided for @adminUpsertAnnouncementScreenFormAnnouncementInfoUpdatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated at'**
  String get adminUpsertAnnouncementScreenFormAnnouncementInfoUpdatedAt;

  /// No description provided for @adminUpsertAnnouncementScreenFormAnnouncementInfoPublishedAt.
  ///
  /// In en, this message translates to:
  /// **'Published at'**
  String get adminUpsertAnnouncementScreenFormAnnouncementInfoPublishedAt;

  /// No description provided for @adminUpsertAnnouncementScreenFormAnnouncementInfoId.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get adminUpsertAnnouncementScreenFormAnnouncementInfoId;

  /// No description provided for @adminUpsertAnnouncementScreenFormPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview Changes'**
  String get adminUpsertAnnouncementScreenFormPreviewTitle;

  /// No description provided for @adminUpsertAnnouncementScreenFormPreviewLangEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get adminUpsertAnnouncementScreenFormPreviewLangEn;

  /// No description provided for @adminUpsertAnnouncementScreenFormPreviewLangJa.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get adminUpsertAnnouncementScreenFormPreviewLangJa;

  /// No description provided for @adminUpsertAnnouncementScreenFormButtonsViewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get adminUpsertAnnouncementScreenFormButtonsViewDetails;

  /// No description provided for @adminUpsertAnnouncementScreenFormButtonsUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update Announcement'**
  String get adminUpsertAnnouncementScreenFormButtonsUpdate;

  /// No description provided for @announcementNotificationCreated.
  ///
  /// In en, this message translates to:
  /// **'Announcement created successfully.'**
  String get announcementNotificationCreated;

  /// No description provided for @announcementNotificationUpdated.
  ///
  /// In en, this message translates to:
  /// **'Announcement updated successfully.'**
  String get announcementNotificationUpdated;

  /// No description provided for @announcementNotificationDeleted.
  ///
  /// In en, this message translates to:
  /// **'Announcement deleted successfully.'**
  String get announcementNotificationDeleted;

  /// No description provided for @announcementNotificationNotFound.
  ///
  /// In en, this message translates to:
  /// **'Announcement not found.'**
  String get announcementNotificationNotFound;

  /// No description provided for @announcementNotificationStatusChanged.
  ///
  /// In en, this message translates to:
  /// **'Announcement status changed successfully.'**
  String get announcementNotificationStatusChanged;

  /// No description provided for @announcementNotificationBulkDeleted.
  ///
  /// In en, this message translates to:
  /// **'Announcements deleted successfully.'**
  String get announcementNotificationBulkDeleted;

  /// No description provided for @announcementNotificationBulkStatusChanged.
  ///
  /// In en, this message translates to:
  /// **'Announcements status changed successfully.'**
  String get announcementNotificationBulkStatusChanged;

  /// No description provided for @announcementNotificationNoneDeleted.
  ///
  /// In en, this message translates to:
  /// **'No announcements were deleted.'**
  String get announcementNotificationNoneDeleted;

  /// No description provided for @announcementNotificationInvalidData.
  ///
  /// In en, this message translates to:
  /// **'Invalid data provided.'**
  String get announcementNotificationInvalidData;

  /// No description provided for @announcementNotificationError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {message}'**
  String announcementNotificationError(String message);

  /// No description provided for @adminListAnnouncementScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Announcement Management'**
  String get adminListAnnouncementScreenTitle;

  /// No description provided for @adminListAnnouncementScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage announcements for customers'**
  String get adminListAnnouncementScreenSubtitle;

  /// No description provided for @adminListAnnouncementScreenAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add Announcement'**
  String get adminListAnnouncementScreenAddButton;

  /// No description provided for @adminListAnnouncementScreenStatsTotal.
  ///
  /// In en, this message translates to:
  /// **'Total Announcements'**
  String get adminListAnnouncementScreenStatsTotal;

  /// No description provided for @adminListAnnouncementScreenStatsActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminListAnnouncementScreenStatsActive;

  /// No description provided for @adminListAnnouncementScreenStatsInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get adminListAnnouncementScreenStatsInactive;

  /// No description provided for @adminListAnnouncementScreenStatsToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get adminListAnnouncementScreenStatsToday;

  /// No description provided for @adminListAnnouncementScreenFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter & Search'**
  String get adminListAnnouncementScreenFiltersTitle;

  /// No description provided for @adminListAnnouncementScreenFiltersStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminListAnnouncementScreenFiltersStatusLabel;

  /// No description provided for @adminListAnnouncementScreenFiltersAllStatuses.
  ///
  /// In en, this message translates to:
  /// **'All Statuses'**
  String get adminListAnnouncementScreenFiltersAllStatuses;

  /// No description provided for @adminListAnnouncementScreenFiltersStartDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get adminListAnnouncementScreenFiltersStartDateLabel;

  /// No description provided for @adminListAnnouncementScreenFiltersEndDateLabel.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get adminListAnnouncementScreenFiltersEndDateLabel;

  /// No description provided for @adminListAnnouncementScreenFiltersSearchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get adminListAnnouncementScreenFiltersSearchLabel;

  /// No description provided for @adminListAnnouncementScreenFiltersSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search title or content...'**
  String get adminListAnnouncementScreenFiltersSearchPlaceholder;

  /// No description provided for @adminListAnnouncementScreenFiltersFilterButton.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get adminListAnnouncementScreenFiltersFilterButton;

  /// No description provided for @adminListAnnouncementScreenFiltersResetButton.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get adminListAnnouncementScreenFiltersResetButton;

  /// No description provided for @adminListAnnouncementScreenBulkActionsActivateButton.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get adminListAnnouncementScreenBulkActionsActivateButton;

  /// No description provided for @adminListAnnouncementScreenBulkActionsDeactivateButton.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get adminListAnnouncementScreenBulkActionsDeactivateButton;

  /// No description provided for @adminListAnnouncementScreenBulkActionsDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminListAnnouncementScreenBulkActionsDeleteButton;

  /// No description provided for @adminListAnnouncementScreenListTitle.
  ///
  /// In en, this message translates to:
  /// **'Announcements List'**
  String get adminListAnnouncementScreenListTitle;

  /// No description provided for @adminListAnnouncementScreenTableHeadersTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get adminListAnnouncementScreenTableHeadersTitle;

  /// No description provided for @adminListAnnouncementScreenTableHeadersContent.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get adminListAnnouncementScreenTableHeadersContent;

  /// No description provided for @adminListAnnouncementScreenTableHeadersPublishDate.
  ///
  /// In en, this message translates to:
  /// **'Publish Date'**
  String get adminListAnnouncementScreenTableHeadersPublishDate;

  /// No description provided for @adminListAnnouncementScreenTableHeadersStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminListAnnouncementScreenTableHeadersStatus;

  /// No description provided for @adminListAnnouncementScreenTableHeadersActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get adminListAnnouncementScreenTableHeadersActions;

  /// No description provided for @adminListAnnouncementScreenTableStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminListAnnouncementScreenTableStatusActive;

  /// No description provided for @adminListAnnouncementScreenTableStatusInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get adminListAnnouncementScreenTableStatusInactive;

  /// No description provided for @adminListAnnouncementScreenTableActionsTooltipView.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get adminListAnnouncementScreenTableActionsTooltipView;

  /// No description provided for @adminListAnnouncementScreenTableActionsTooltipEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get adminListAnnouncementScreenTableActionsTooltipEdit;

  /// No description provided for @adminListAnnouncementScreenTableActionsTooltipDeactivate.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get adminListAnnouncementScreenTableActionsTooltipDeactivate;

  /// No description provided for @adminListAnnouncementScreenTableActionsTooltipActivate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get adminListAnnouncementScreenTableActionsTooltipActivate;

  /// No description provided for @adminListAnnouncementScreenTableActionsTooltipDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminListAnnouncementScreenTableActionsTooltipDelete;

  /// No description provided for @adminListAnnouncementScreenEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No announcements found'**
  String get adminListAnnouncementScreenEmptyTitle;

  /// No description provided for @adminListAnnouncementScreenEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'There are no announcements created yet, or none match the applied filters.'**
  String get adminListAnnouncementScreenEmptyDescription;

  /// No description provided for @adminListAnnouncementScreenDeleteModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get adminListAnnouncementScreenDeleteModalTitle;

  /// No description provided for @adminListAnnouncementScreenDeleteModalCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminListAnnouncementScreenDeleteModalCancelButton;

  /// No description provided for @adminListAnnouncementScreenDeleteModalDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminListAnnouncementScreenDeleteModalDeleteButton;

  /// No description provided for @adminListAnnouncementScreenJsShowFilters.
  ///
  /// In en, this message translates to:
  /// **'Show Filters'**
  String get adminListAnnouncementScreenJsShowFilters;

  /// No description provided for @adminListAnnouncementScreenJsHideFilters.
  ///
  /// In en, this message translates to:
  /// **'Hide Filters'**
  String get adminListAnnouncementScreenJsHideFilters;

  /// No description provided for @adminListAnnouncementScreenJsSelectedText.
  ///
  /// In en, this message translates to:
  /// **'{count} item(s) selected'**
  String adminListAnnouncementScreenJsSelectedText(String count);

  /// No description provided for @adminListAnnouncementScreenJsDeleteSingleConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this announcement?'**
  String get adminListAnnouncementScreenJsDeleteSingleConfirm;

  /// No description provided for @adminListAnnouncementScreenJsDeleteMultipleConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {count} announcement(s)?'**
  String adminListAnnouncementScreenJsDeleteMultipleConfirm(String count);

  /// No description provided for @adminListAnnouncementScreenJsSelectAtLeastOne.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one announcement.'**
  String get adminListAnnouncementScreenJsSelectAtLeastOne;

  /// No description provided for @adminListAnnouncementScreenJsErrorStatus.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while changing the status.'**
  String get adminListAnnouncementScreenJsErrorStatus;

  /// No description provided for @adminListAnnouncementScreenJsErrorDelete.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while deleting.'**
  String get adminListAnnouncementScreenJsErrorDelete;

  /// No description provided for @adminListAnnouncementScreenJsErrorToggleStatus.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while changing the status'**
  String get adminListAnnouncementScreenJsErrorToggleStatus;

  /// No description provided for @adminListAnnouncementScreenDetailHeaderBackToList.
  ///
  /// In en, this message translates to:
  /// **'Back to List'**
  String get adminListAnnouncementScreenDetailHeaderBackToList;

  /// No description provided for @adminListAnnouncementScreenDetailHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Announcement Detail'**
  String get adminListAnnouncementScreenDetailHeaderTitle;

  /// No description provided for @adminListAnnouncementScreenDetailStatusCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Announcement Status'**
  String get adminListAnnouncementScreenDetailStatusCardTitle;

  /// No description provided for @adminListAnnouncementScreenDetailStatusCardDescriptionPrefix.
  ///
  /// In en, this message translates to:
  /// **'This announcement is currently'**
  String get adminListAnnouncementScreenDetailStatusCardDescriptionPrefix;

  /// No description provided for @adminListAnnouncementScreenDetailStatusCardActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminListAnnouncementScreenDetailStatusCardActive;

  /// No description provided for @adminListAnnouncementScreenDetailStatusCardInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get adminListAnnouncementScreenDetailStatusCardInactive;

  /// No description provided for @adminListAnnouncementScreenDetailStatusCardCreatedAt.
  ///
  /// In en, this message translates to:
  /// **'Created at'**
  String get adminListAnnouncementScreenDetailStatusCardCreatedAt;

  /// No description provided for @adminListAnnouncementScreenDetailStatusCardUpdatedAtPrefix.
  ///
  /// In en, this message translates to:
  /// **'Updated:'**
  String get adminListAnnouncementScreenDetailStatusCardUpdatedAtPrefix;

  /// No description provided for @adminListAnnouncementScreenDetailMainCardPublishDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Publish Date:'**
  String get adminListAnnouncementScreenDetailMainCardPublishDateLabel;

  /// No description provided for @adminListAnnouncementScreenDetailMainCardNotPublishedYet.
  ///
  /// In en, this message translates to:
  /// **'Not published yet'**
  String get adminListAnnouncementScreenDetailMainCardNotPublishedYet;

  /// No description provided for @adminListAnnouncementScreenDetailMainCardContentTitle.
  ///
  /// In en, this message translates to:
  /// **'Announcement Content'**
  String get adminListAnnouncementScreenDetailMainCardContentTitle;

  /// No description provided for @adminListAnnouncementScreenDetailMainCardAdditionalInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Additional Information'**
  String get adminListAnnouncementScreenDetailMainCardAdditionalInfoTitle;

  /// No description provided for @adminListAnnouncementScreenDetailAdditionalInfoId.
  ///
  /// In en, this message translates to:
  /// **'ID:'**
  String get adminListAnnouncementScreenDetailAdditionalInfoId;

  /// No description provided for @adminListAnnouncementScreenDetailAdditionalInfoStatus.
  ///
  /// In en, this message translates to:
  /// **'Status:'**
  String get adminListAnnouncementScreenDetailAdditionalInfoStatus;

  /// No description provided for @adminListAnnouncementScreenDetailAdditionalInfoPublished.
  ///
  /// In en, this message translates to:
  /// **'Published:'**
  String get adminListAnnouncementScreenDetailAdditionalInfoPublished;

  /// No description provided for @adminListAnnouncementScreenDetailAdditionalInfoCreated.
  ///
  /// In en, this message translates to:
  /// **'Created:'**
  String get adminListAnnouncementScreenDetailAdditionalInfoCreated;

  /// No description provided for @adminListAnnouncementScreenDetailAdditionalInfoUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated:'**
  String get adminListAnnouncementScreenDetailAdditionalInfoUpdated;

  /// No description provided for @adminListAnnouncementScreenDetailAdditionalInfoCharactersLabel.
  ///
  /// In en, this message translates to:
  /// **'Characters:'**
  String get adminListAnnouncementScreenDetailAdditionalInfoCharactersLabel;

  /// No description provided for @adminListAnnouncementScreenDetailAdditionalInfoCharactersUnit.
  ///
  /// In en, this message translates to:
  /// **'characters'**
  String get adminListAnnouncementScreenDetailAdditionalInfoCharactersUnit;

  /// No description provided for @adminListAnnouncementScreenDetailActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get adminListAnnouncementScreenDetailActionsTitle;

  /// No description provided for @adminListAnnouncementScreenDetailActionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage this announcement easily'**
  String get adminListAnnouncementScreenDetailActionsDescription;

  /// No description provided for @adminListAnnouncementScreenDetailActionsEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Announcement'**
  String get adminListAnnouncementScreenDetailActionsEdit;

  /// No description provided for @adminListAnnouncementScreenDetailActionsDeactivate.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get adminListAnnouncementScreenDetailActionsDeactivate;

  /// No description provided for @adminListAnnouncementScreenDetailActionsActivate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get adminListAnnouncementScreenDetailActionsActivate;

  /// No description provided for @adminListAnnouncementScreenDetailDeleteModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get adminListAnnouncementScreenDetailDeleteModalTitle;

  /// No description provided for @adminListAnnouncementScreenDetailDeleteModalTextLine1.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this announcement?'**
  String get adminListAnnouncementScreenDetailDeleteModalTextLine1;

  /// No description provided for @adminListAnnouncementScreenDetailDeleteModalTextLine2.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get adminListAnnouncementScreenDetailDeleteModalTextLine2;

  /// No description provided for @adminListAnnouncementScreenDetailDeleteModalCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminListAnnouncementScreenDetailDeleteModalCancelButton;

  /// No description provided for @adminListAnnouncementScreenDetailDeleteModalDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminListAnnouncementScreenDetailDeleteModalDeleteButton;

  /// No description provided for @adminListAnnouncementScreenDetailAlertsToggleStatusError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while changing the status'**
  String get adminListAnnouncementScreenDetailAlertsToggleStatusError;

  /// No description provided for @adminListAnnouncementScreenDetailAlertsDeleteError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while deleting the announcement'**
  String get adminListAnnouncementScreenDetailAlertsDeleteError;

  /// No description provided for @registerBrandName.
  ///
  /// In en, this message translates to:
  /// **'RESERVATION ID'**
  String get registerBrandName;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Your Account'**
  String get registerTitle;

  /// No description provided for @registerLabelFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get registerLabelFullName;

  /// No description provided for @registerLabelFullNameKana.
  ///
  /// In en, this message translates to:
  /// **'Full Name (Kana)'**
  String get registerLabelFullNameKana;

  /// No description provided for @registerLabelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get registerLabelEmail;

  /// No description provided for @registerLabelPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get registerLabelPhoneNumber;

  /// No description provided for @registerLabelCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get registerLabelCompanyName;

  /// No description provided for @registerLabelDepartment.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get registerLabelDepartment;

  /// No description provided for @registerLabelCompanyAddress.
  ///
  /// In en, this message translates to:
  /// **'Company Address'**
  String get registerLabelCompanyAddress;

  /// No description provided for @registerLabelHomeAddress.
  ///
  /// In en, this message translates to:
  /// **'Home Address'**
  String get registerLabelHomeAddress;

  /// No description provided for @registerLabelDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get registerLabelDateOfBirth;

  /// No description provided for @registerLabelGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get registerLabelGender;

  /// No description provided for @registerLabelPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get registerLabelPassword;

  /// No description provided for @registerLabelConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get registerLabelConfirmPassword;

  /// No description provided for @registerPlaceholderFullName.
  ///
  /// In en, this message translates to:
  /// **'e.g., John Doe'**
  String get registerPlaceholderFullName;

  /// No description provided for @registerPlaceholderFullNameKana.
  ///
  /// In en, this message translates to:
  /// **'e.g., JOHN DOE'**
  String get registerPlaceholderFullNameKana;

  /// No description provided for @registerPlaceholderEmail.
  ///
  /// In en, this message translates to:
  /// **'example@reservation.be'**
  String get registerPlaceholderEmail;

  /// No description provided for @registerPlaceholderPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'e.g., 08012345678'**
  String get registerPlaceholderPhoneNumber;

  /// No description provided for @registerPlaceholderCompanyName.
  ///
  /// In en, this message translates to:
  /// **'e.g., Acme Corporation'**
  String get registerPlaceholderCompanyName;

  /// No description provided for @registerPlaceholderDepartment.
  ///
  /// In en, this message translates to:
  /// **'e.g., Sales'**
  String get registerPlaceholderDepartment;

  /// No description provided for @registerPlaceholderCompanyAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter company address'**
  String get registerPlaceholderCompanyAddress;

  /// No description provided for @registerPlaceholderHomeAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter home address'**
  String get registerPlaceholderHomeAddress;

  /// No description provided for @registerPlaceholderPassword.
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters'**
  String get registerPlaceholderPassword;

  /// No description provided for @registerPlaceholderConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get registerPlaceholderConfirmPassword;

  /// No description provided for @registerGenderSelect.
  ///
  /// In en, this message translates to:
  /// **'Select gender'**
  String get registerGenderSelect;

  /// No description provided for @registerGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get registerGenderMale;

  /// No description provided for @registerGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get registerGenderFemale;

  /// No description provided for @registerGenderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get registerGenderOther;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @registerAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have a RESERVATION account?'**
  String get registerAlreadyHaveAccount;

  /// No description provided for @registerSignInLink.
  ///
  /// In en, this message translates to:
  /// **'Sign in here'**
  String get registerSignInLink;

  /// No description provided for @registerTermsAgreement.
  ///
  /// In en, this message translates to:
  /// **'By registering, you agree to our terms of service and privacy policy.'**
  String get registerTermsAgreement;

  /// No description provided for @registerTermsOfServiceLink.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get registerTermsOfServiceLink;

  /// No description provided for @registerPrivacyPolicyLink.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get registerPrivacyPolicyLink;

  /// No description provided for @registerContactUsLink.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get registerContactUsLink;

  /// No description provided for @registerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© RESERVATION'**
  String get registerCopyright;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'RESERVATION ID'**
  String get loginTitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address*'**
  String get loginEmailLabel;

  /// No description provided for @loginEmailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'example@reservation.be'**
  String get loginEmailPlaceholder;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password*'**
  String get loginPasswordLabel;

  /// No description provided for @loginPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get loginPasswordPlaceholder;

  /// No description provided for @loginRememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get loginRememberMe;

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get loginForgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @loginNoAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have a RESERVATION account?'**
  String get loginNoAccountPrompt;

  /// No description provided for @loginSignupLink.
  ///
  /// In en, this message translates to:
  /// **'Sign up now'**
  String get loginSignupLink;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Your Password?'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No worries! Enter your email and we will send you a reset link.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @forgotPasswordEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get forgotPasswordEmailLabel;

  /// No description provided for @forgotPasswordEmailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get forgotPasswordEmailPlaceholder;

  /// No description provided for @forgotPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get forgotPasswordButton;

  /// No description provided for @forgotPasswordSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'An email with a password reset link has been sent. Please check your inbox.'**
  String get forgotPasswordSuccessMessage;

  /// No description provided for @forgotPasswordFormError.
  ///
  /// In en, this message translates to:
  /// **'Please correct the errors in the form.'**
  String get forgotPasswordFormError;

  /// No description provided for @forgotPasswordRemembered.
  ///
  /// In en, this message translates to:
  /// **'Remembered your password?'**
  String get forgotPasswordRemembered;

  /// No description provided for @forgotPasswordBackToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get forgotPasswordBackToLogin;

  /// No description provided for @adminListAvailabilityScreenPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Availability Check'**
  String get adminListAvailabilityScreenPageTitle;

  /// No description provided for @adminListAvailabilityScreenPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Check time availability for reservations'**
  String get adminListAvailabilityScreenPageSubtitle;

  /// No description provided for @adminListAvailabilityScreenFormDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Reservation Date'**
  String get adminListAvailabilityScreenFormDateLabel;

  /// No description provided for @adminListAvailabilityScreenFormMenuLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Menu'**
  String get adminListAvailabilityScreenFormMenuLabel;

  /// No description provided for @adminListAvailabilityScreenFormMenuPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'-- Select Menu --'**
  String get adminListAvailabilityScreenFormMenuPlaceholder;

  /// No description provided for @adminListAvailabilityScreenFormMenuMinutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get adminListAvailabilityScreenFormMenuMinutes;

  /// No description provided for @adminListAvailabilityScreenButtonsPrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get adminListAvailabilityScreenButtonsPrevious;

  /// No description provided for @adminListAvailabilityScreenButtonsNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get adminListAvailabilityScreenButtonsNext;

  /// No description provided for @adminListAvailabilityScreenSummaryDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get adminListAvailabilityScreenSummaryDate;

  /// No description provided for @adminListAvailabilityScreenSummaryYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get adminListAvailabilityScreenSummaryYear;

  /// No description provided for @adminListAvailabilityScreenSummaryMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get adminListAvailabilityScreenSummaryMonth;

  /// No description provided for @adminListAvailabilityScreenSummaryCurrentTime.
  ///
  /// In en, this message translates to:
  /// **'Current Time'**
  String get adminListAvailabilityScreenSummaryCurrentTime;

  /// No description provided for @adminListAvailabilityScreenLoadingText.
  ///
  /// In en, this message translates to:
  /// **'Loading availability data...'**
  String get adminListAvailabilityScreenLoadingText;

  /// No description provided for @adminListAvailabilityScreenAvailabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Time Availability'**
  String get adminListAvailabilityScreenAvailabilityTitle;

  /// No description provided for @adminListAvailabilityScreenAvailabilityAvailableSlots.
  ///
  /// In en, this message translates to:
  /// **'available slots'**
  String get adminListAvailabilityScreenAvailabilityAvailableSlots;

  /// No description provided for @adminListAvailabilityScreenAvailabilityReservedSlots.
  ///
  /// In en, this message translates to:
  /// **'reserved slots'**
  String get adminListAvailabilityScreenAvailabilityReservedSlots;

  /// No description provided for @adminListAvailabilityScreenAvailabilityBlockedSlots.
  ///
  /// In en, this message translates to:
  /// **'blocked slots'**
  String get adminListAvailabilityScreenAvailabilityBlockedSlots;

  /// No description provided for @adminListAvailabilityScreenStatusAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get adminListAvailabilityScreenStatusAvailable;

  /// No description provided for @adminListAvailabilityScreenStatusReserved.
  ///
  /// In en, this message translates to:
  /// **'Reserved'**
  String get adminListAvailabilityScreenStatusReserved;

  /// No description provided for @adminListAvailabilityScreenStatusBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get adminListAvailabilityScreenStatusBlocked;

  /// No description provided for @adminListAvailabilityScreenLegendAvailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get adminListAvailabilityScreenLegendAvailableTitle;

  /// No description provided for @adminListAvailabilityScreenLegendAvailableDescription.
  ///
  /// In en, this message translates to:
  /// **'Can make reservation'**
  String get adminListAvailabilityScreenLegendAvailableDescription;

  /// No description provided for @adminListAvailabilityScreenLegendReservedTitle.
  ///
  /// In en, this message translates to:
  /// **'Reserved'**
  String get adminListAvailabilityScreenLegendReservedTitle;

  /// No description provided for @adminListAvailabilityScreenLegendReservedDescription.
  ///
  /// In en, this message translates to:
  /// **'Already has reservation'**
  String get adminListAvailabilityScreenLegendReservedDescription;

  /// No description provided for @adminListAvailabilityScreenLegendBlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get adminListAvailabilityScreenLegendBlockedTitle;

  /// No description provided for @adminListAvailabilityScreenLegendBlockedDescription.
  ///
  /// In en, this message translates to:
  /// **'Blocked Period'**
  String get adminListAvailabilityScreenLegendBlockedDescription;

  /// No description provided for @adminListAvailabilityScreenEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No availability data'**
  String get adminListAvailabilityScreenEmptyTitle;

  /// No description provided for @adminListAvailabilityScreenEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'for the selected menu on this date'**
  String get adminListAvailabilityScreenEmptyDescription;

  /// No description provided for @adminListAvailabilityScreenScriptTextsMonthsJanuary.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get adminListAvailabilityScreenScriptTextsMonthsJanuary;

  /// No description provided for @adminListAvailabilityScreenScriptTextsMonthsFebruary.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get adminListAvailabilityScreenScriptTextsMonthsFebruary;

  /// No description provided for @adminListAvailabilityScreenScriptTextsMonthsMarch.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get adminListAvailabilityScreenScriptTextsMonthsMarch;

  /// No description provided for @adminListAvailabilityScreenScriptTextsMonthsApril.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get adminListAvailabilityScreenScriptTextsMonthsApril;

  /// No description provided for @adminListAvailabilityScreenScriptTextsMonthsMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get adminListAvailabilityScreenScriptTextsMonthsMay;

  /// No description provided for @adminListAvailabilityScreenScriptTextsMonthsJune.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get adminListAvailabilityScreenScriptTextsMonthsJune;

  /// No description provided for @adminListAvailabilityScreenScriptTextsMonthsJuly.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get adminListAvailabilityScreenScriptTextsMonthsJuly;

  /// No description provided for @adminListAvailabilityScreenScriptTextsMonthsAugust.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get adminListAvailabilityScreenScriptTextsMonthsAugust;

  /// No description provided for @adminListAvailabilityScreenScriptTextsMonthsSeptember.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get adminListAvailabilityScreenScriptTextsMonthsSeptember;

  /// No description provided for @adminListAvailabilityScreenScriptTextsMonthsOctober.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get adminListAvailabilityScreenScriptTextsMonthsOctober;

  /// No description provided for @adminListAvailabilityScreenScriptTextsMonthsNovember.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get adminListAvailabilityScreenScriptTextsMonthsNovember;

  /// No description provided for @adminListAvailabilityScreenScriptTextsMonthsDecember.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get adminListAvailabilityScreenScriptTextsMonthsDecember;

  /// No description provided for @adminListAvailabilityScreenScriptTextsDaysSunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get adminListAvailabilityScreenScriptTextsDaysSunday;

  /// No description provided for @adminListAvailabilityScreenScriptTextsDaysMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get adminListAvailabilityScreenScriptTextsDaysMonday;

  /// No description provided for @adminListAvailabilityScreenScriptTextsDaysTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get adminListAvailabilityScreenScriptTextsDaysTuesday;

  /// No description provided for @adminListAvailabilityScreenScriptTextsDaysWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get adminListAvailabilityScreenScriptTextsDaysWednesday;

  /// No description provided for @adminListAvailabilityScreenScriptTextsDaysThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get adminListAvailabilityScreenScriptTextsDaysThursday;

  /// No description provided for @adminListAvailabilityScreenScriptTextsDaysFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get adminListAvailabilityScreenScriptTextsDaysFriday;

  /// No description provided for @adminListAvailabilityScreenScriptTextsDaysSaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get adminListAvailabilityScreenScriptTextsDaysSaturday;

  /// No description provided for @adminListAvailabilityScreenScriptTextsAlertsLoadFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to load availability data'**
  String get adminListAvailabilityScreenScriptTextsAlertsLoadFail;

  /// No description provided for @adminListAvailabilityScreenScriptTextsAlertsLoadError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading data'**
  String get adminListAvailabilityScreenScriptTextsAlertsLoadError;

  /// No description provided for @adminListAvailabilityScreenScriptTextsAlertsSlotUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This time slot is not available for reservation'**
  String get adminListAvailabilityScreenScriptTextsAlertsSlotUnavailable;

  /// No description provided for @adminListAvailabilityScreenScriptTextsAlertsSelectSlotFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select a time slot first'**
  String get adminListAvailabilityScreenScriptTextsAlertsSelectSlotFirst;

  /// No description provided for @adminListAvailabilityScreenScriptTextsSelectedTimeAt.
  ///
  /// In en, this message translates to:
  /// **'at'**
  String get adminListAvailabilityScreenScriptTextsSelectedTimeAt;

  /// No description provided for @blockedPeriodNotificationCreateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Blocked period created successfully.'**
  String get blockedPeriodNotificationCreateSuccess;

  /// No description provided for @blockedPeriodNotificationCreateError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {message}'**
  String blockedPeriodNotificationCreateError(String message);

  /// No description provided for @blockedPeriodNotificationConflictError.
  ///
  /// In en, this message translates to:
  /// **'A time conflict occurred with an existing blocked period.'**
  String get blockedPeriodNotificationConflictError;

  /// No description provided for @blockedPeriodNotificationNotFound.
  ///
  /// In en, this message translates to:
  /// **'Blocked period not found.'**
  String get blockedPeriodNotificationNotFound;

  /// No description provided for @blockedPeriodNotificationUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Blocked period updated successfully.'**
  String get blockedPeriodNotificationUpdateSuccess;

  /// No description provided for @blockedPeriodNotificationUpdateError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {message}'**
  String blockedPeriodNotificationUpdateError(String message);

  /// No description provided for @blockedPeriodNotificationDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Blocked period has been deleted successfully.'**
  String get blockedPeriodNotificationDeleteSuccess;

  /// No description provided for @blockedPeriodNotificationDeleteError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while deleting the blocked period: {message}'**
  String blockedPeriodNotificationDeleteError(String message);

  /// No description provided for @blockedPeriodNotificationBulkDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully deleted {count} blocked period(s).'**
  String blockedPeriodNotificationBulkDeleteSuccess(String count);

  /// No description provided for @blockedPeriodNotificationBulkDeleteError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred during bulk deletion: {message}'**
  String blockedPeriodNotificationBulkDeleteError(String message);

  /// No description provided for @blockedPeriodValidationMenuRequiredIfNotAll.
  ///
  /// In en, this message translates to:
  /// **'The menu field is required when not blocking all menus.'**
  String get blockedPeriodValidationMenuRequiredIfNotAll;

  /// No description provided for @blockedPeriodValidationStartBeforeEnd.
  ///
  /// In en, this message translates to:
  /// **'The start time must be a date before the end time.'**
  String get blockedPeriodValidationStartBeforeEnd;

  /// No description provided for @blockedPeriodValidationMinDuration.
  ///
  /// In en, this message translates to:
  /// **'The minimum duration is 15 minutes.'**
  String get blockedPeriodValidationMinDuration;

  /// No description provided for @blockedPeriodValidationMaxDuration.
  ///
  /// In en, this message translates to:
  /// **'The maximum duration is 30 days.'**
  String get blockedPeriodValidationMaxDuration;

  /// No description provided for @blockedPeriodValidationAllMenusBoolean.
  ///
  /// In en, this message translates to:
  /// **'The all menus field must be true or false.'**
  String get blockedPeriodValidationAllMenusBoolean;

  /// No description provided for @blockedPeriodValidationConflictMessage.
  ///
  /// In en, this message translates to:
  /// **'Time conflict with the following blocked period(s):\n{details}'**
  String blockedPeriodValidationConflictMessage(String details);

  /// No description provided for @blockedPeriodValidationMenuIdExists.
  ///
  /// In en, this message translates to:
  /// **'The selected menu is invalid.'**
  String get blockedPeriodValidationMenuIdExists;

  /// No description provided for @blockedPeriodValidationStartDatetimeRequired.
  ///
  /// In en, this message translates to:
  /// **'The start time is required.'**
  String get blockedPeriodValidationStartDatetimeRequired;

  /// No description provided for @blockedPeriodValidationStartDatetimeDate.
  ///
  /// In en, this message translates to:
  /// **'The start time format is invalid.'**
  String get blockedPeriodValidationStartDatetimeDate;

  /// No description provided for @blockedPeriodValidationStartDatetimeAfterOrEqual.
  ///
  /// In en, this message translates to:
  /// **'The start time must be a date after or equal to now.'**
  String get blockedPeriodValidationStartDatetimeAfterOrEqual;

  /// No description provided for @blockedPeriodValidationEndDatetimeRequired.
  ///
  /// In en, this message translates to:
  /// **'The end time is required.'**
  String get blockedPeriodValidationEndDatetimeRequired;

  /// No description provided for @blockedPeriodValidationEndDatetimeDate.
  ///
  /// In en, this message translates to:
  /// **'The end time format is invalid.'**
  String get blockedPeriodValidationEndDatetimeDate;

  /// No description provided for @blockedPeriodValidationEndDatetimeAfter.
  ///
  /// In en, this message translates to:
  /// **'The end time must be a date after the start time.'**
  String get blockedPeriodValidationEndDatetimeAfter;

  /// No description provided for @blockedPeriodValidationReasonRequired.
  ///
  /// In en, this message translates to:
  /// **'The reason is required.'**
  String get blockedPeriodValidationReasonRequired;

  /// No description provided for @blockedPeriodValidationReasonString.
  ///
  /// In en, this message translates to:
  /// **'The reason must be a string.'**
  String get blockedPeriodValidationReasonString;

  /// No description provided for @blockedPeriodValidationReasonMax.
  ///
  /// In en, this message translates to:
  /// **'The reason may not be greater than 500 characters.'**
  String get blockedPeriodValidationReasonMax;

  /// No description provided for @blockedPeriodValidationReasonMin.
  ///
  /// In en, this message translates to:
  /// **'The reason must be at least 3 characters.'**
  String get blockedPeriodValidationReasonMin;

  /// No description provided for @blockedPeriodAttributesMenuId.
  ///
  /// In en, this message translates to:
  /// **'menu'**
  String get blockedPeriodAttributesMenuId;

  /// No description provided for @blockedPeriodAttributesStartDatetime.
  ///
  /// In en, this message translates to:
  /// **'start time'**
  String get blockedPeriodAttributesStartDatetime;

  /// No description provided for @blockedPeriodAttributesEndDatetime.
  ///
  /// In en, this message translates to:
  /// **'end time'**
  String get blockedPeriodAttributesEndDatetime;

  /// No description provided for @blockedPeriodAttributesReason.
  ///
  /// In en, this message translates to:
  /// **'reason'**
  String get blockedPeriodAttributesReason;

  /// No description provided for @blockedPeriodAttributesAllMenus.
  ///
  /// In en, this message translates to:
  /// **'all menus'**
  String get blockedPeriodAttributesAllMenus;

  /// No description provided for @adminUpsertBlockedPeriodScreenCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'Create New Blocked Period'**
  String get adminUpsertBlockedPeriodScreenCreateTitle;

  /// No description provided for @adminUpsertBlockedPeriodScreenCreateDescription.
  ///
  /// In en, this message translates to:
  /// **'Set a time period during which a specific menu or all menus are unavailable for reservation.'**
  String get adminUpsertBlockedPeriodScreenCreateDescription;

  /// No description provided for @adminUpsertBlockedPeriodScreenBackToListButton.
  ///
  /// In en, this message translates to:
  /// **'Back to List'**
  String get adminUpsertBlockedPeriodScreenBackToListButton;

  /// No description provided for @adminUpsertBlockedPeriodScreenCreateSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Blocked Period'**
  String get adminUpsertBlockedPeriodScreenCreateSaveButton;

  /// No description provided for @adminUpsertBlockedPeriodScreenCreateSavingButton.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get adminUpsertBlockedPeriodScreenCreateSavingButton;

  /// No description provided for @adminUpsertBlockedPeriodScreenCalendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Calendar View - Click on dates to select'**
  String get adminUpsertBlockedPeriodScreenCalendarTitle;

  /// No description provided for @adminUpsertBlockedPeriodScreenDurationPresetsFullDay.
  ///
  /// In en, this message translates to:
  /// **'Full Day (00:00 - 23:59)'**
  String get adminUpsertBlockedPeriodScreenDurationPresetsFullDay;

  /// No description provided for @adminUpsertBlockedPeriodScreenDurationPresetsFull2Days.
  ///
  /// In en, this message translates to:
  /// **'Full 2 Days'**
  String get adminUpsertBlockedPeriodScreenDurationPresetsFull2Days;

  /// No description provided for @adminUpsertBlockedPeriodScreenDurationPresetsFullWeek.
  ///
  /// In en, this message translates to:
  /// **'Full Week (7 days)'**
  String get adminUpsertBlockedPeriodScreenDurationPresetsFullWeek;

  /// No description provided for @adminUpsertBlockedPeriodScreenDurationPresetsCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom Duration'**
  String get adminUpsertBlockedPeriodScreenDurationPresetsCustom;

  /// No description provided for @adminUpsertBlockedPeriodScreenCreateFormAllMenusLabel.
  ///
  /// In en, this message translates to:
  /// **'Block All Menus?'**
  String get adminUpsertBlockedPeriodScreenCreateFormAllMenusLabel;

  /// No description provided for @adminUpsertBlockedPeriodScreenCreateFormSelectMenuLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Specific Menu'**
  String get adminUpsertBlockedPeriodScreenCreateFormSelectMenuLabel;

  /// No description provided for @adminUpsertBlockedPeriodScreenCreateFormSelectMenuPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'-- Select a menu --'**
  String get adminUpsertBlockedPeriodScreenCreateFormSelectMenuPlaceholder;

  /// No description provided for @adminUpsertBlockedPeriodScreenCreateFormDurationPresetLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration Preset'**
  String get adminUpsertBlockedPeriodScreenCreateFormDurationPresetLabel;

  /// No description provided for @adminUpsertBlockedPeriodScreenCreateFormStartDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get adminUpsertBlockedPeriodScreenCreateFormStartDateLabel;

  /// No description provided for @adminUpsertBlockedPeriodScreenCreateFormEndDateLabel.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get adminUpsertBlockedPeriodScreenCreateFormEndDateLabel;

  /// No description provided for @adminUpsertBlockedPeriodScreenCreateFormStartTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get adminUpsertBlockedPeriodScreenCreateFormStartTimeLabel;

  /// No description provided for @adminUpsertBlockedPeriodScreenCreateFormEndTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get adminUpsertBlockedPeriodScreenCreateFormEndTimeLabel;

  /// No description provided for @adminUpsertBlockedPeriodScreenCreateFormReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get adminUpsertBlockedPeriodScreenCreateFormReasonLabel;

  /// No description provided for @adminUpsertBlockedPeriodScreenCreateFormReasonPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g., Regular maintenance, holiday, private event, etc.'**
  String get adminUpsertBlockedPeriodScreenCreateFormReasonPlaceholder;

  /// No description provided for @adminUpsertBlockedPeriodScreenConflictAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule Conflict Detected!'**
  String get adminUpsertBlockedPeriodScreenConflictAlertTitle;

  /// No description provided for @adminUpsertBlockedPeriodScreenCreateConflictAlertMessage.
  ///
  /// In en, this message translates to:
  /// **'The entered period overlaps with the following schedule(s):'**
  String get adminUpsertBlockedPeriodScreenCreateConflictAlertMessage;

  /// No description provided for @adminUpsertBlockedPeriodScreenEditPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Blocked Period'**
  String get adminUpsertBlockedPeriodScreenEditPageTitle;

  /// No description provided for @adminUpsertBlockedPeriodScreenEditPageDescription.
  ///
  /// In en, this message translates to:
  /// **'Update the time period when a menu is unavailable for reservation.'**
  String get adminUpsertBlockedPeriodScreenEditPageDescription;

  /// No description provided for @adminUpsertBlockedPeriodScreenEditFormAllMenusLabel.
  ///
  /// In en, this message translates to:
  /// **'Block for All Menus?'**
  String get adminUpsertBlockedPeriodScreenEditFormAllMenusLabel;

  /// No description provided for @adminUpsertBlockedPeriodScreenEditFormSpecificMenuLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Specific Menu'**
  String get adminUpsertBlockedPeriodScreenEditFormSpecificMenuLabel;

  /// No description provided for @adminUpsertBlockedPeriodScreenEditFormReasonPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Example: Routine maintenance, public holiday, private event, etc.'**
  String get adminUpsertBlockedPeriodScreenEditFormReasonPlaceholder;

  /// No description provided for @adminUpsertBlockedPeriodScreenEditConflictDescription.
  ///
  /// In en, this message translates to:
  /// **'The period you entered overlaps with the following schedule:'**
  String get adminUpsertBlockedPeriodScreenEditConflictDescription;

  /// No description provided for @adminUpsertBlockedPeriodScreenEditButtonSaveText.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get adminUpsertBlockedPeriodScreenEditButtonSaveText;

  /// No description provided for @adminUpsertBlockedPeriodScreenEditButtonCheckingText.
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get adminUpsertBlockedPeriodScreenEditButtonCheckingText;

  /// No description provided for @adminListBlockedPeriodScreenPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Blocked Period Management'**
  String get adminListBlockedPeriodScreenPageTitle;

  /// No description provided for @adminListBlockedPeriodScreenPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage blocked time periods for reservations'**
  String get adminListBlockedPeriodScreenPageSubtitle;

  /// No description provided for @adminListBlockedPeriodScreenAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add Period'**
  String get adminListBlockedPeriodScreenAddButton;

  /// No description provided for @adminListBlockedPeriodScreenStatsTotal.
  ///
  /// In en, this message translates to:
  /// **'Total Periods'**
  String get adminListBlockedPeriodScreenStatsTotal;

  /// No description provided for @adminListBlockedPeriodScreenStatsActive.
  ///
  /// In en, this message translates to:
  /// **'Currently Active'**
  String get adminListBlockedPeriodScreenStatsActive;

  /// No description provided for @adminListBlockedPeriodScreenStatsUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get adminListBlockedPeriodScreenStatsUpcoming;

  /// No description provided for @adminListBlockedPeriodScreenStatsExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get adminListBlockedPeriodScreenStatsExpired;

  /// No description provided for @adminListBlockedPeriodScreenFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters & Search'**
  String get adminListBlockedPeriodScreenFiltersTitle;

  /// No description provided for @adminListBlockedPeriodScreenFiltersShow.
  ///
  /// In en, this message translates to:
  /// **'Show Filters'**
  String get adminListBlockedPeriodScreenFiltersShow;

  /// No description provided for @adminListBlockedPeriodScreenFiltersHide.
  ///
  /// In en, this message translates to:
  /// **'Hide Filters'**
  String get adminListBlockedPeriodScreenFiltersHide;

  /// No description provided for @adminListBlockedPeriodScreenFiltersMenuLabel.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get adminListBlockedPeriodScreenFiltersMenuLabel;

  /// No description provided for @adminListBlockedPeriodScreenFiltersMenuAll.
  ///
  /// In en, this message translates to:
  /// **'All Menus'**
  String get adminListBlockedPeriodScreenFiltersMenuAll;

  /// No description provided for @adminListBlockedPeriodScreenFiltersStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminListBlockedPeriodScreenFiltersStatusLabel;

  /// No description provided for @adminListBlockedPeriodScreenFiltersStatusAll.
  ///
  /// In en, this message translates to:
  /// **'All Status'**
  String get adminListBlockedPeriodScreenFiltersStatusAll;

  /// No description provided for @adminListBlockedPeriodScreenFiltersStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminListBlockedPeriodScreenFiltersStatusActive;

  /// No description provided for @adminListBlockedPeriodScreenFiltersStatusUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get adminListBlockedPeriodScreenFiltersStatusUpcoming;

  /// No description provided for @adminListBlockedPeriodScreenFiltersStatusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get adminListBlockedPeriodScreenFiltersStatusExpired;

  /// No description provided for @adminListBlockedPeriodScreenFiltersStartDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get adminListBlockedPeriodScreenFiltersStartDateLabel;

  /// No description provided for @adminListBlockedPeriodScreenFiltersEndDateLabel.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get adminListBlockedPeriodScreenFiltersEndDateLabel;

  /// No description provided for @adminListBlockedPeriodScreenFiltersAllMenusLabel.
  ///
  /// In en, this message translates to:
  /// **'Block All Menus Only'**
  String get adminListBlockedPeriodScreenFiltersAllMenusLabel;

  /// No description provided for @adminListBlockedPeriodScreenFiltersSearchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get adminListBlockedPeriodScreenFiltersSearchLabel;

  /// No description provided for @adminListBlockedPeriodScreenFiltersSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search by reason or menu name...'**
  String get adminListBlockedPeriodScreenFiltersSearchPlaceholder;

  /// No description provided for @adminListBlockedPeriodScreenFiltersFilterButton.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get adminListBlockedPeriodScreenFiltersFilterButton;

  /// No description provided for @adminListBlockedPeriodScreenFiltersResetButton.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get adminListBlockedPeriodScreenFiltersResetButton;

  /// No description provided for @adminListBlockedPeriodScreenBulkActionsItemsSelected.
  ///
  /// In en, this message translates to:
  /// **'items selected'**
  String get adminListBlockedPeriodScreenBulkActionsItemsSelected;

  /// No description provided for @adminListBlockedPeriodScreenBulkActionsDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminListBlockedPeriodScreenBulkActionsDeleteButton;

  /// No description provided for @adminListBlockedPeriodScreenListTitle.
  ///
  /// In en, this message translates to:
  /// **'Blocked Periods List'**
  String get adminListBlockedPeriodScreenListTitle;

  /// No description provided for @adminListBlockedPeriodScreenTableHeaderMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get adminListBlockedPeriodScreenTableHeaderMenu;

  /// No description provided for @adminListBlockedPeriodScreenTableHeaderTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get adminListBlockedPeriodScreenTableHeaderTime;

  /// No description provided for @adminListBlockedPeriodScreenTableHeaderDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get adminListBlockedPeriodScreenTableHeaderDuration;

  /// No description provided for @adminListBlockedPeriodScreenTableHeaderReason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get adminListBlockedPeriodScreenTableHeaderReason;

  /// No description provided for @adminListBlockedPeriodScreenTableHeaderStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminListBlockedPeriodScreenTableHeaderStatus;

  /// No description provided for @adminListBlockedPeriodScreenTableHeaderActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get adminListBlockedPeriodScreenTableHeaderActions;

  /// No description provided for @adminListBlockedPeriodScreenTableBodyAllMenusBadge.
  ///
  /// In en, this message translates to:
  /// **'All Menus'**
  String get adminListBlockedPeriodScreenTableBodyAllMenusBadge;

  /// No description provided for @adminListBlockedPeriodScreenTableBodyMenuNotFound.
  ///
  /// In en, this message translates to:
  /// **'Menu not found'**
  String get adminListBlockedPeriodScreenTableBodyMenuNotFound;

  /// No description provided for @adminListBlockedPeriodScreenTableBodyActionTooltipsDetail.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get adminListBlockedPeriodScreenTableBodyActionTooltipsDetail;

  /// No description provided for @adminListBlockedPeriodScreenTableBodyActionTooltipsEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get adminListBlockedPeriodScreenTableBodyActionTooltipsEdit;

  /// No description provided for @adminListBlockedPeriodScreenTableBodyActionTooltipsDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminListBlockedPeriodScreenTableBodyActionTooltipsDelete;

  /// No description provided for @adminListBlockedPeriodScreenEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No blocked periods'**
  String get adminListBlockedPeriodScreenEmptyTitle;

  /// No description provided for @adminListBlockedPeriodScreenEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No blocked periods have been created or match the applied filters.'**
  String get adminListBlockedPeriodScreenEmptyMessage;

  /// No description provided for @adminListBlockedPeriodScreenEmptyAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add First Period'**
  String get adminListBlockedPeriodScreenEmptyAddButton;

  /// No description provided for @adminListBlockedPeriodScreenDeleteModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Confirmation'**
  String get adminListBlockedPeriodScreenDeleteModalTitle;

  /// No description provided for @adminListBlockedPeriodScreenDeleteModalConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminListBlockedPeriodScreenDeleteModalConfirmButton;

  /// No description provided for @adminListBlockedPeriodScreenDeleteModalCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminListBlockedPeriodScreenDeleteModalCancelButton;

  /// No description provided for @adminListBlockedPeriodScreenDeleteModalMessageSingle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this blocked period?'**
  String get adminListBlockedPeriodScreenDeleteModalMessageSingle;

  /// No description provided for @adminListBlockedPeriodScreenDeleteModalMessageMultiple.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {count} blocked periods?'**
  String adminListBlockedPeriodScreenDeleteModalMessageMultiple(String count);

  /// No description provided for @adminListBlockedPeriodScreenAlertsDeleteError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while deleting.'**
  String get adminListBlockedPeriodScreenAlertsDeleteError;

  /// No description provided for @adminListBlockedPeriodScreenCalendarAllMenusLabel.
  ///
  /// In en, this message translates to:
  /// **'All Menus'**
  String get adminListBlockedPeriodScreenCalendarAllMenusLabel;

  /// No description provided for @adminListBlockedPeriodScreenConfirmationDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Blocked Period'**
  String get adminListBlockedPeriodScreenConfirmationDeleteTitle;

  /// No description provided for @adminListBlockedPeriodScreenConfirmationDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this blocked period?'**
  String get adminListBlockedPeriodScreenConfirmationDeleteMessage;

  /// No description provided for @adminListBlockedPeriodScreenConfirmationBulkDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Selected Periods'**
  String get adminListBlockedPeriodScreenConfirmationBulkDeleteTitle;

  /// No description provided for @adminListBlockedPeriodScreenConfirmationBulkDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the selected blocked periods?'**
  String get adminListBlockedPeriodScreenConfirmationBulkDeleteMessage;

  /// No description provided for @adminListBlockedPeriodScreenDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Blocked Period Details'**
  String get adminListBlockedPeriodScreenDetailTitle;

  /// No description provided for @adminListBlockedPeriodScreenDetailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Displaying the details of the selected blocked period.'**
  String get adminListBlockedPeriodScreenDetailSubtitle;

  /// No description provided for @adminListBlockedPeriodScreenDetailBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get adminListBlockedPeriodScreenDetailBackButton;

  /// No description provided for @adminListBlockedPeriodScreenDetailDetailsBlockedMenu.
  ///
  /// In en, this message translates to:
  /// **'Blocked Menu'**
  String get adminListBlockedPeriodScreenDetailDetailsBlockedMenu;

  /// No description provided for @adminListBlockedPeriodScreenDetailDetailsAllMenus.
  ///
  /// In en, this message translates to:
  /// **'All Menus'**
  String get adminListBlockedPeriodScreenDetailDetailsAllMenus;

  /// No description provided for @adminListBlockedPeriodScreenDetailDetailsMenuNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Menu not available'**
  String get adminListBlockedPeriodScreenDetailDetailsMenuNotAvailable;

  /// No description provided for @adminListBlockedPeriodScreenDetailDetailsStartTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get adminListBlockedPeriodScreenDetailDetailsStartTime;

  /// No description provided for @adminListBlockedPeriodScreenDetailDetailsEndTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get adminListBlockedPeriodScreenDetailDetailsEndTime;

  /// No description provided for @adminListBlockedPeriodScreenDetailDetailsDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get adminListBlockedPeriodScreenDetailDetailsDuration;

  /// No description provided for @adminListBlockedPeriodScreenDetailDetailsReason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get adminListBlockedPeriodScreenDetailDetailsReason;

  /// No description provided for @adminListBlockedPeriodScreenDetailDetailsStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminListBlockedPeriodScreenDetailDetailsStatus;

  /// No description provided for @adminListBlockedPeriodScreenDetailDetailsCreatedAt.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get adminListBlockedPeriodScreenDetailDetailsCreatedAt;

  /// No description provided for @adminListBlockedPeriodScreenDetailDetailsUpdatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get adminListBlockedPeriodScreenDetailDetailsUpdatedAt;

  /// No description provided for @adminListBlockedPeriodScreenDetailStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminListBlockedPeriodScreenDetailStatusActive;

  /// No description provided for @adminListBlockedPeriodScreenDetailStatusUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get adminListBlockedPeriodScreenDetailStatusUpcoming;

  /// No description provided for @adminListBlockedPeriodScreenDetailStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get adminListBlockedPeriodScreenDetailStatusCompleted;

  /// No description provided for @adminListBlockedPeriodScreenDetailActionsEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get adminListBlockedPeriodScreenDetailActionsEdit;

  /// No description provided for @adminListBlockedPeriodScreenDetailActionsDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminListBlockedPeriodScreenDetailActionsDelete;

  /// No description provided for @adminListBlockedPeriodScreenDetailDeleteModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get adminListBlockedPeriodScreenDetailDeleteModalTitle;

  /// No description provided for @adminListBlockedPeriodScreenDetailDeleteModalText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this blocked period? This action cannot be undone.'**
  String get adminListBlockedPeriodScreenDetailDeleteModalText;

  /// No description provided for @adminListBlockedPeriodScreenDetailDeleteModalCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminListBlockedPeriodScreenDetailDeleteModalCancelButton;

  /// No description provided for @adminListBlockedPeriodScreenDetailDeleteModalConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete'**
  String get adminListBlockedPeriodScreenDetailDeleteModalConfirmButton;

  /// No description provided for @adminUpsertBusinessInformationScreenPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Business Settings'**
  String get adminUpsertBusinessInformationScreenPageTitle;

  /// No description provided for @adminUpsertBusinessInformationScreenPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your business information and operating hours'**
  String get adminUpsertBusinessInformationScreenPageSubtitle;

  /// No description provided for @adminUpsertBusinessInformationScreenPageBackToSettings.
  ///
  /// In en, this message translates to:
  /// **'Back to Settings'**
  String get adminUpsertBusinessInformationScreenPageBackToSettings;

  /// No description provided for @adminUpsertBusinessInformationScreenSectionHeadersBasicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get adminUpsertBusinessInformationScreenSectionHeadersBasicInfo;

  /// No description provided for @adminUpsertBusinessInformationScreenSectionHeadersBusinessHours.
  ///
  /// In en, this message translates to:
  /// **'Business Hours'**
  String get adminUpsertBusinessInformationScreenSectionHeadersBusinessHours;

  /// No description provided for @adminUpsertBusinessInformationScreenSectionHeadersSiteSettings.
  ///
  /// In en, this message translates to:
  /// **'Site Settings'**
  String get adminUpsertBusinessInformationScreenSectionHeadersSiteSettings;

  /// No description provided for @adminUpsertBusinessInformationScreenSectionHeadersDescImage.
  ///
  /// In en, this message translates to:
  /// **'Description & Image'**
  String get adminUpsertBusinessInformationScreenSectionHeadersDescImage;

  /// No description provided for @adminUpsertBusinessInformationScreenSectionHeadersPoliciesTerms.
  ///
  /// In en, this message translates to:
  /// **'Policies & Terms'**
  String get adminUpsertBusinessInformationScreenSectionHeadersPoliciesTerms;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsShopName.
  ///
  /// In en, this message translates to:
  /// **'Shop Name'**
  String get adminUpsertBusinessInformationScreenLabelsShopName;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get adminUpsertBusinessInformationScreenLabelsPhoneNumber;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get adminUpsertBusinessInformationScreenLabelsAddress;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsWebsiteUrl.
  ///
  /// In en, this message translates to:
  /// **'Website URL'**
  String get adminUpsertBusinessInformationScreenLabelsWebsiteUrl;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get adminUpsertBusinessInformationScreenLabelsClosed;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsOpenTime.
  ///
  /// In en, this message translates to:
  /// **'Open Time'**
  String get adminUpsertBusinessInformationScreenLabelsOpenTime;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsCloseTime.
  ///
  /// In en, this message translates to:
  /// **'Close Time'**
  String get adminUpsertBusinessInformationScreenLabelsCloseTime;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsSiteName.
  ///
  /// In en, this message translates to:
  /// **'Site Name'**
  String get adminUpsertBusinessInformationScreenLabelsSiteName;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsMakeSitePublic.
  ///
  /// In en, this message translates to:
  /// **'Make site public'**
  String get adminUpsertBusinessInformationScreenLabelsMakeSitePublic;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsReplyEmail.
  ///
  /// In en, this message translates to:
  /// **'Reply Email'**
  String get adminUpsertBusinessInformationScreenLabelsReplyEmail;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsGoogleAnalyticsId.
  ///
  /// In en, this message translates to:
  /// **'Google Analytics ID'**
  String get adminUpsertBusinessInformationScreenLabelsGoogleAnalyticsId;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsShopDescription.
  ///
  /// In en, this message translates to:
  /// **'Shop Description'**
  String get adminUpsertBusinessInformationScreenLabelsShopDescription;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsAccessInformation.
  ///
  /// In en, this message translates to:
  /// **'Access Information'**
  String get adminUpsertBusinessInformationScreenLabelsAccessInformation;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsTopImage.
  ///
  /// In en, this message translates to:
  /// **'Top Image'**
  String get adminUpsertBusinessInformationScreenLabelsTopImage;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsImagePreview.
  ///
  /// In en, this message translates to:
  /// **'Image Preview'**
  String get adminUpsertBusinessInformationScreenLabelsImagePreview;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsTermsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get adminUpsertBusinessInformationScreenLabelsTermsOfUse;

  /// No description provided for @adminUpsertBusinessInformationScreenLabelsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get adminUpsertBusinessInformationScreenLabelsPrivacyPolicy;

  /// No description provided for @adminUpsertBusinessInformationScreenPlaceholdersWebsiteUrl.
  ///
  /// In en, this message translates to:
  /// **'https://example.com'**
  String get adminUpsertBusinessInformationScreenPlaceholdersWebsiteUrl;

  /// No description provided for @adminUpsertBusinessInformationScreenPlaceholdersGoogleAnalyticsId.
  ///
  /// In en, this message translates to:
  /// **'GA-XXXXXXXXX-X'**
  String get adminUpsertBusinessInformationScreenPlaceholdersGoogleAnalyticsId;

  /// No description provided for @adminUpsertBusinessInformationScreenPlaceholdersShopDescription.
  ///
  /// In en, this message translates to:
  /// **'Describe your business...'**
  String get adminUpsertBusinessInformationScreenPlaceholdersShopDescription;

  /// No description provided for @adminUpsertBusinessInformationScreenPlaceholdersAccessInformation.
  ///
  /// In en, this message translates to:
  /// **'How to get to your business...'**
  String get adminUpsertBusinessInformationScreenPlaceholdersAccessInformation;

  /// No description provided for @adminUpsertBusinessInformationScreenPlaceholdersTermsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Enter your terms of use...'**
  String get adminUpsertBusinessInformationScreenPlaceholdersTermsOfUse;

  /// No description provided for @adminUpsertBusinessInformationScreenPlaceholdersPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Enter your privacy policy...'**
  String get adminUpsertBusinessInformationScreenPlaceholdersPrivacyPolicy;

  /// No description provided for @adminUpsertBusinessInformationScreenDaysMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get adminUpsertBusinessInformationScreenDaysMonday;

  /// No description provided for @adminUpsertBusinessInformationScreenDaysTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get adminUpsertBusinessInformationScreenDaysTuesday;

  /// No description provided for @adminUpsertBusinessInformationScreenDaysWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get adminUpsertBusinessInformationScreenDaysWednesday;

  /// No description provided for @adminUpsertBusinessInformationScreenDaysThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get adminUpsertBusinessInformationScreenDaysThursday;

  /// No description provided for @adminUpsertBusinessInformationScreenDaysFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get adminUpsertBusinessInformationScreenDaysFriday;

  /// No description provided for @adminUpsertBusinessInformationScreenDaysSaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get adminUpsertBusinessInformationScreenDaysSaturday;

  /// No description provided for @adminUpsertBusinessInformationScreenDaysSunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get adminUpsertBusinessInformationScreenDaysSunday;

  /// No description provided for @adminUpsertBusinessInformationScreenButtonsCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminUpsertBusinessInformationScreenButtonsCancel;

  /// No description provided for @adminUpsertBusinessInformationScreenButtonsSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get adminUpsertBusinessInformationScreenButtonsSaveChanges;

  /// No description provided for @businessSettingsNotificationSuccessUpdate.
  ///
  /// In en, this message translates to:
  /// **'Business settings updated successfully.'**
  String get businessSettingsNotificationSuccessUpdate;

  /// No description provided for @businessSettingsNotificationErrorUpdate.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: '**
  String get businessSettingsNotificationErrorUpdate;

  /// No description provided for @adminListBusinessInformationScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Business Settings'**
  String get adminListBusinessInformationScreenTitle;

  /// No description provided for @adminListBusinessInformationScreenDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage your business information and settings'**
  String get adminListBusinessInformationScreenDescription;

  /// No description provided for @adminListBusinessInformationScreenEditButton.
  ///
  /// In en, this message translates to:
  /// **'Edit Settings'**
  String get adminListBusinessInformationScreenEditButton;

  /// No description provided for @adminListBusinessInformationScreenCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create Settings'**
  String get adminListBusinessInformationScreenCreateButton;

  /// No description provided for @adminListBusinessInformationScreenNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get adminListBusinessInformationScreenNotSet;

  /// No description provided for @adminListBusinessInformationScreenBasicInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get adminListBusinessInformationScreenBasicInfoTitle;

  /// No description provided for @adminListBusinessInformationScreenBasicInfoShopName.
  ///
  /// In en, this message translates to:
  /// **'Shop Name'**
  String get adminListBusinessInformationScreenBasicInfoShopName;

  /// No description provided for @adminListBusinessInformationScreenBasicInfoPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get adminListBusinessInformationScreenBasicInfoPhoneNumber;

  /// No description provided for @adminListBusinessInformationScreenBasicInfoAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get adminListBusinessInformationScreenBasicInfoAddress;

  /// No description provided for @adminListBusinessInformationScreenBasicInfoWebsiteUrl.
  ///
  /// In en, this message translates to:
  /// **'Website URL'**
  String get adminListBusinessInformationScreenBasicInfoWebsiteUrl;

  /// No description provided for @adminListBusinessInformationScreenBusinessHoursTitle.
  ///
  /// In en, this message translates to:
  /// **'Business Hours'**
  String get adminListBusinessInformationScreenBusinessHoursTitle;

  /// No description provided for @adminListBusinessInformationScreenBusinessHoursNotSet.
  ///
  /// In en, this message translates to:
  /// **'Business hours not set'**
  String get adminListBusinessInformationScreenBusinessHoursNotSet;

  /// No description provided for @adminListBusinessInformationScreenBusinessHoursClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get adminListBusinessInformationScreenBusinessHoursClosed;

  /// No description provided for @adminListBusinessInformationScreenBusinessHoursDaysMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get adminListBusinessInformationScreenBusinessHoursDaysMonday;

  /// No description provided for @adminListBusinessInformationScreenBusinessHoursDaysTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get adminListBusinessInformationScreenBusinessHoursDaysTuesday;

  /// No description provided for @adminListBusinessInformationScreenBusinessHoursDaysWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get adminListBusinessInformationScreenBusinessHoursDaysWednesday;

  /// No description provided for @adminListBusinessInformationScreenBusinessHoursDaysThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get adminListBusinessInformationScreenBusinessHoursDaysThursday;

  /// No description provided for @adminListBusinessInformationScreenBusinessHoursDaysFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get adminListBusinessInformationScreenBusinessHoursDaysFriday;

  /// No description provided for @adminListBusinessInformationScreenBusinessHoursDaysSaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get adminListBusinessInformationScreenBusinessHoursDaysSaturday;

  /// No description provided for @adminListBusinessInformationScreenBusinessHoursDaysSunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get adminListBusinessInformationScreenBusinessHoursDaysSunday;

  /// No description provided for @adminListBusinessInformationScreenSiteSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Site Settings'**
  String get adminListBusinessInformationScreenSiteSettingsTitle;

  /// No description provided for @adminListBusinessInformationScreenSiteSettingsSiteName.
  ///
  /// In en, this message translates to:
  /// **'Site Name'**
  String get adminListBusinessInformationScreenSiteSettingsSiteName;

  /// No description provided for @adminListBusinessInformationScreenSiteSettingsSiteStatus.
  ///
  /// In en, this message translates to:
  /// **'Site Status'**
  String get adminListBusinessInformationScreenSiteSettingsSiteStatus;

  /// No description provided for @adminListBusinessInformationScreenSiteSettingsPublic.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get adminListBusinessInformationScreenSiteSettingsPublic;

  /// No description provided for @adminListBusinessInformationScreenSiteSettingsPrivate.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get adminListBusinessInformationScreenSiteSettingsPrivate;

  /// No description provided for @adminListBusinessInformationScreenSiteSettingsReplyEmail.
  ///
  /// In en, this message translates to:
  /// **'Reply Email'**
  String get adminListBusinessInformationScreenSiteSettingsReplyEmail;

  /// No description provided for @adminListBusinessInformationScreenSiteSettingsGoogleAnalyticsId.
  ///
  /// In en, this message translates to:
  /// **'Google Analytics ID'**
  String get adminListBusinessInformationScreenSiteSettingsGoogleAnalyticsId;

  /// No description provided for @adminListBusinessInformationScreenDescriptionImageTitle.
  ///
  /// In en, this message translates to:
  /// **'Description & Image'**
  String get adminListBusinessInformationScreenDescriptionImageTitle;

  /// No description provided for @adminListBusinessInformationScreenDescriptionImageShopDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Shop Description'**
  String
  get adminListBusinessInformationScreenDescriptionImageShopDescriptionLabel;

  /// No description provided for @adminListBusinessInformationScreenDescriptionImageShopDescriptionNotSet.
  ///
  /// In en, this message translates to:
  /// **'No description set'**
  String
  get adminListBusinessInformationScreenDescriptionImageShopDescriptionNotSet;

  /// No description provided for @adminListBusinessInformationScreenDescriptionImageTopImageLabel.
  ///
  /// In en, this message translates to:
  /// **'Top Image'**
  String get adminListBusinessInformationScreenDescriptionImageTopImageLabel;

  /// No description provided for @adminListBusinessInformationScreenDescriptionImageTopImageNotSet.
  ///
  /// In en, this message translates to:
  /// **'No image uploaded'**
  String get adminListBusinessInformationScreenDescriptionImageTopImageNotSet;

  /// No description provided for @adminListBusinessInformationScreenDescriptionImageAccessInformationLabel.
  ///
  /// In en, this message translates to:
  /// **'Access Information'**
  String
  get adminListBusinessInformationScreenDescriptionImageAccessInformationLabel;

  /// No description provided for @adminListBusinessInformationScreenDescriptionImageAccessInformationNotSet.
  ///
  /// In en, this message translates to:
  /// **'No access information set'**
  String
  get adminListBusinessInformationScreenDescriptionImageAccessInformationNotSet;

  /// No description provided for @adminListBusinessInformationScreenPoliciesTermsTitle.
  ///
  /// In en, this message translates to:
  /// **'Policies & Terms'**
  String get adminListBusinessInformationScreenPoliciesTermsTitle;

  /// No description provided for @adminListBusinessInformationScreenPoliciesTermsTermsOfUseLabel.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get adminListBusinessInformationScreenPoliciesTermsTermsOfUseLabel;

  /// No description provided for @adminListBusinessInformationScreenPoliciesTermsTermsOfUseNotSet.
  ///
  /// In en, this message translates to:
  /// **'Terms of use not set'**
  String get adminListBusinessInformationScreenPoliciesTermsTermsOfUseNotSet;

  /// No description provided for @adminListBusinessInformationScreenPoliciesTermsPrivacyPolicyLabel.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get adminListBusinessInformationScreenPoliciesTermsPrivacyPolicyLabel;

  /// No description provided for @adminListBusinessInformationScreenPoliciesTermsPrivacyPolicyNotSet.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy not set'**
  String get adminListBusinessInformationScreenPoliciesTermsPrivacyPolicyNotSet;

  /// No description provided for @adminListBusinessInformationScreenNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'No Business Settings Found'**
  String get adminListBusinessInformationScreenNotFoundTitle;

  /// No description provided for @adminListBusinessInformationScreenNotFoundDescription.
  ///
  /// In en, this message translates to:
  /// **'Get started by creating your business settings.'**
  String get adminListBusinessInformationScreenNotFoundDescription;

  /// No description provided for @adminListBusinessInformationScreenNotFoundCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create Business Settings'**
  String get adminListBusinessInformationScreenNotFoundCreateButton;

  /// No description provided for @reservationNotificationReservationNotFound.
  ///
  /// In en, this message translates to:
  /// **'Reservation not found.'**
  String get reservationNotificationReservationNotFound;

  /// No description provided for @reservationNotificationUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Reservation updated successfully.'**
  String get reservationNotificationUpdateSuccess;

  /// No description provided for @reservationNotificationUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update reservation: {error}'**
  String reservationNotificationUpdateFailed(String error);

  /// No description provided for @reservationNotificationDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Reservation deleted successfully.'**
  String get reservationNotificationDeleteSuccess;

  /// No description provided for @reservationNotificationDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete reservation: {error}'**
  String reservationNotificationDeleteFailed(String error);

  /// No description provided for @reservationNotificationConfirmSuccess.
  ///
  /// In en, this message translates to:
  /// **'Reservation confirmed successfully.'**
  String get reservationNotificationConfirmSuccess;

  /// No description provided for @reservationNotificationCancelSuccess.
  ///
  /// In en, this message translates to:
  /// **'Reservation cancelled successfully.'**
  String get reservationNotificationCancelSuccess;

  /// No description provided for @reservationNotificationCompleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Reservation completed successfully.'**
  String get reservationNotificationCompleteSuccess;

  /// No description provided for @reservationNotificationBulkUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Reservation statuses updated successfully.'**
  String get reservationNotificationBulkUpdateSuccess;

  /// No description provided for @reservationNotificationBulkUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update reservation statuses.'**
  String get reservationNotificationBulkUpdateFailed;

  /// No description provided for @reservationNotificationAvailabilityCheckError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while checking availability.'**
  String get reservationNotificationAvailabilityCheckError;

  /// No description provided for @reservationAvailabilityAvailable.
  ///
  /// In en, this message translates to:
  /// **'Time is available.'**
  String get reservationAvailabilityAvailable;

  /// No description provided for @reservationAvailabilityUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Time is not available.'**
  String get reservationAvailabilityUnavailable;

  /// No description provided for @reservationValidationUserIdRequired.
  ///
  /// In en, this message translates to:
  /// **'The user ID field is required.'**
  String get reservationValidationUserIdRequired;

  /// No description provided for @reservationValidationUserIdExists.
  ///
  /// In en, this message translates to:
  /// **'The selected user does not exist.'**
  String get reservationValidationUserIdExists;

  /// No description provided for @reservationValidationMenuIdRequired.
  ///
  /// In en, this message translates to:
  /// **'The menu field is required.'**
  String get reservationValidationMenuIdRequired;

  /// No description provided for @reservationValidationMenuIdExists.
  ///
  /// In en, this message translates to:
  /// **'The selected menu does not exist.'**
  String get reservationValidationMenuIdExists;

  /// No description provided for @reservationValidationReservationDatetimeRequired.
  ///
  /// In en, this message translates to:
  /// **'The reservation datetime field is required.'**
  String get reservationValidationReservationDatetimeRequired;

  /// No description provided for @reservationValidationReservationDatetimeDate.
  ///
  /// In en, this message translates to:
  /// **'The reservation datetime must be a valid date.'**
  String get reservationValidationReservationDatetimeDate;

  /// No description provided for @reservationValidationReservationDatetimeAfter.
  ///
  /// In en, this message translates to:
  /// **'The reservation datetime must be after now.'**
  String get reservationValidationReservationDatetimeAfter;

  /// No description provided for @reservationValidationNumberOfPeopleRequired.
  ///
  /// In en, this message translates to:
  /// **'The number of people field is required.'**
  String get reservationValidationNumberOfPeopleRequired;

  /// No description provided for @reservationValidationNumberOfPeopleInteger.
  ///
  /// In en, this message translates to:
  /// **'The number of people must be an integer.'**
  String get reservationValidationNumberOfPeopleInteger;

  /// No description provided for @reservationValidationNumberOfPeopleMin.
  ///
  /// In en, this message translates to:
  /// **'The number of people must be at least 1.'**
  String get reservationValidationNumberOfPeopleMin;

  /// No description provided for @reservationValidationAmountRequired.
  ///
  /// In en, this message translates to:
  /// **'The amount field is required.'**
  String get reservationValidationAmountRequired;

  /// No description provided for @reservationValidationAmountNumeric.
  ///
  /// In en, this message translates to:
  /// **'The amount must be a number.'**
  String get reservationValidationAmountNumeric;

  /// No description provided for @reservationValidationAmountMin.
  ///
  /// In en, this message translates to:
  /// **'The amount must be at least 0.'**
  String get reservationValidationAmountMin;

  /// No description provided for @reservationValidationStatusIn.
  ///
  /// In en, this message translates to:
  /// **'The selected status is invalid.'**
  String get reservationValidationStatusIn;

  /// No description provided for @reservationValidationNotesString.
  ///
  /// In en, this message translates to:
  /// **'The notes must be a string.'**
  String get reservationValidationNotesString;

  /// No description provided for @reservationValidationFullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'The full name field is required for a guest customer.'**
  String get reservationValidationFullNameRequired;

  /// No description provided for @reservationValidationFullNameString.
  ///
  /// In en, this message translates to:
  /// **'The full name must be a string.'**
  String get reservationValidationFullNameString;

  /// No description provided for @reservationValidationFullNameMax.
  ///
  /// In en, this message translates to:
  /// **'The full name may not be greater than 255 characters.'**
  String get reservationValidationFullNameMax;

  /// No description provided for @reservationValidationFullNameKanaRequired.
  ///
  /// In en, this message translates to:
  /// **'The full name (kana) field is required for a guest customer.'**
  String get reservationValidationFullNameKanaRequired;

  /// No description provided for @reservationValidationFullNameKanaString.
  ///
  /// In en, this message translates to:
  /// **'The full name (kana) must be a string.'**
  String get reservationValidationFullNameKanaString;

  /// No description provided for @reservationValidationFullNameKanaMax.
  ///
  /// In en, this message translates to:
  /// **'The full name (kana) may not be greater than 255 characters.'**
  String get reservationValidationFullNameKanaMax;

  /// No description provided for @reservationValidationEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'The email field is required for a guest customer.'**
  String get reservationValidationEmailRequired;

  /// No description provided for @reservationValidationEmailEmail.
  ///
  /// In en, this message translates to:
  /// **'The email must be a valid email address.'**
  String get reservationValidationEmailEmail;

  /// No description provided for @reservationValidationEmailMax.
  ///
  /// In en, this message translates to:
  /// **'The email may not be greater than 255 characters.'**
  String get reservationValidationEmailMax;

  /// No description provided for @reservationValidationPhoneNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'The phone number field is required for a guest customer.'**
  String get reservationValidationPhoneNumberRequired;

  /// No description provided for @reservationValidationPhoneNumberString.
  ///
  /// In en, this message translates to:
  /// **'The phone number must be a string.'**
  String get reservationValidationPhoneNumberString;

  /// No description provided for @reservationValidationPhoneNumberMax.
  ///
  /// In en, this message translates to:
  /// **'The phone number may not be greater than 20 characters.'**
  String get reservationValidationPhoneNumberMax;

  /// No description provided for @reservationValidationReservationDatetimeUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The selected reservation datetime is unavailable. Please choose another time.'**
  String get reservationValidationReservationDatetimeUnavailable;

  /// No description provided for @adminListCalendarScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Reservation Management'**
  String get adminListCalendarScreenTitle;

  /// No description provided for @adminListCalendarScreenStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminListCalendarScreenStatusActive;

  /// No description provided for @adminListCalendarScreenTabsCalendarView.
  ///
  /// In en, this message translates to:
  /// **'Calendar View'**
  String get adminListCalendarScreenTabsCalendarView;

  /// No description provided for @adminListCalendarScreenTabsListView.
  ///
  /// In en, this message translates to:
  /// **'List View'**
  String get adminListCalendarScreenTabsListView;

  /// No description provided for @adminListCalendarScreenModeDescriptionCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar Mode - Visual overview of reservations'**
  String get adminListCalendarScreenModeDescriptionCalendar;

  /// No description provided for @adminListCalendarScreenModeDescriptionList.
  ///
  /// In en, this message translates to:
  /// **'List Mode - Detailed reservation data'**
  String get adminListCalendarScreenModeDescriptionList;

  /// No description provided for @adminListCalendarScreenButtonsNewReservation.
  ///
  /// In en, this message translates to:
  /// **'New Reservation'**
  String get adminListCalendarScreenButtonsNewReservation;

  /// No description provided for @adminListCalendarScreenButtonsRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get adminListCalendarScreenButtonsRefresh;

  /// No description provided for @adminListCalendarScreenButtonsSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get adminListCalendarScreenButtonsSettings;

  /// No description provided for @adminListCalendarScreenViewsMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get adminListCalendarScreenViewsMonth;

  /// No description provided for @adminListCalendarScreenViewsWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get adminListCalendarScreenViewsWeek;

  /// No description provided for @adminListCalendarScreenViewsDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get adminListCalendarScreenViewsDay;

  /// No description provided for @adminListCalendarScreenViewsSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get adminListCalendarScreenViewsSelectDate;

  /// No description provided for @adminListCalendarScreenNavigationPreviousMonth.
  ///
  /// In en, this message translates to:
  /// **'Previous Month'**
  String get adminListCalendarScreenNavigationPreviousMonth;

  /// No description provided for @adminListCalendarScreenNavigationNextMonth.
  ///
  /// In en, this message translates to:
  /// **'Next Month'**
  String get adminListCalendarScreenNavigationNextMonth;

  /// No description provided for @adminListCalendarScreenNavigationPreviousWeek.
  ///
  /// In en, this message translates to:
  /// **'Previous Week'**
  String get adminListCalendarScreenNavigationPreviousWeek;

  /// No description provided for @adminListCalendarScreenNavigationNextWeek.
  ///
  /// In en, this message translates to:
  /// **'Next Week'**
  String get adminListCalendarScreenNavigationNextWeek;

  /// No description provided for @adminListCalendarScreenNavigationPreviousDay.
  ///
  /// In en, this message translates to:
  /// **'Previous Day'**
  String get adminListCalendarScreenNavigationPreviousDay;

  /// No description provided for @adminListCalendarScreenNavigationNextDay.
  ///
  /// In en, this message translates to:
  /// **'Next Day'**
  String get adminListCalendarScreenNavigationNextDay;

  /// No description provided for @adminListCalendarScreenFilterTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter Reservations'**
  String get adminListCalendarScreenFilterTitle;

  /// No description provided for @adminListCalendarScreenFilterTotalReservations.
  ///
  /// In en, this message translates to:
  /// **'total reservations'**
  String get adminListCalendarScreenFilterTotalReservations;

  /// No description provided for @adminListCalendarScreenFilterQuickSearch.
  ///
  /// In en, this message translates to:
  /// **'Quick Search'**
  String get adminListCalendarScreenFilterQuickSearch;

  /// No description provided for @adminListCalendarScreenFilterSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Customer name, phone, email...'**
  String get adminListCalendarScreenFilterSearchPlaceholder;

  /// No description provided for @adminListCalendarScreenFilterMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get adminListCalendarScreenFilterMenu;

  /// No description provided for @adminListCalendarScreenFilterAllMenus.
  ///
  /// In en, this message translates to:
  /// **'All Menus'**
  String get adminListCalendarScreenFilterAllMenus;

  /// No description provided for @adminListCalendarScreenFilterStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminListCalendarScreenFilterStatus;

  /// No description provided for @adminListCalendarScreenFilterAllStatuses.
  ///
  /// In en, this message translates to:
  /// **'All Statuses'**
  String get adminListCalendarScreenFilterAllStatuses;

  /// No description provided for @adminListCalendarScreenFilterDateRange.
  ///
  /// In en, this message translates to:
  /// **'Date Range'**
  String get adminListCalendarScreenFilterDateRange;

  /// No description provided for @adminListCalendarScreenFilterSelectRange.
  ///
  /// In en, this message translates to:
  /// **'Select Range'**
  String get adminListCalendarScreenFilterSelectRange;

  /// No description provided for @adminListCalendarScreenFilterStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get adminListCalendarScreenFilterStartDate;

  /// No description provided for @adminListCalendarScreenFilterEndDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get adminListCalendarScreenFilterEndDate;

  /// No description provided for @adminListCalendarScreenFilterApplyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get adminListCalendarScreenFilterApplyFilters;

  /// No description provided for @adminListCalendarScreenFilterClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get adminListCalendarScreenFilterClearAll;

  /// No description provided for @adminListCalendarScreenFilterShowing.
  ///
  /// In en, this message translates to:
  /// **'Showing'**
  String get adminListCalendarScreenFilterShowing;

  /// No description provided for @adminListCalendarScreenFilterOf.
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get adminListCalendarScreenFilterOf;

  /// No description provided for @adminListCalendarScreenFilterResults.
  ///
  /// In en, this message translates to:
  /// **'results'**
  String get adminListCalendarScreenFilterResults;

  /// No description provided for @adminListCalendarScreenFilterExport.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get adminListCalendarScreenFilterExport;

  /// No description provided for @adminListCalendarScreenTableCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get adminListCalendarScreenTableCustomer;

  /// No description provided for @adminListCalendarScreenTableDateTime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get adminListCalendarScreenTableDateTime;

  /// No description provided for @adminListCalendarScreenTableMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get adminListCalendarScreenTableMenu;

  /// No description provided for @adminListCalendarScreenTablePeople.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get adminListCalendarScreenTablePeople;

  /// No description provided for @adminListCalendarScreenTableStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminListCalendarScreenTableStatus;

  /// No description provided for @adminListCalendarScreenTableActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get adminListCalendarScreenTableActions;

  /// No description provided for @adminListCalendarScreenTableMinutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get adminListCalendarScreenTableMinutes;

  /// No description provided for @adminListCalendarScreenActionsViewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get adminListCalendarScreenActionsViewDetails;

  /// No description provided for @adminListCalendarScreenActionsEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get adminListCalendarScreenActionsEdit;

  /// No description provided for @adminListCalendarScreenActionsConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get adminListCalendarScreenActionsConfirm;

  /// No description provided for @adminListCalendarScreenActionsCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminListCalendarScreenActionsCancel;

  /// No description provided for @adminListCalendarScreenActionsMoreActions.
  ///
  /// In en, this message translates to:
  /// **'More Actions'**
  String get adminListCalendarScreenActionsMoreActions;

  /// No description provided for @adminListCalendarScreenActionsPrintDetails.
  ///
  /// In en, this message translates to:
  /// **'Print Details'**
  String get adminListCalendarScreenActionsPrintDetails;

  /// No description provided for @adminListCalendarScreenActionsSendEmail.
  ///
  /// In en, this message translates to:
  /// **'Send Email'**
  String get adminListCalendarScreenActionsSendEmail;

  /// No description provided for @adminListCalendarScreenEmptyStateNoReservations.
  ///
  /// In en, this message translates to:
  /// **'No reservations found'**
  String get adminListCalendarScreenEmptyStateNoReservations;

  /// No description provided for @adminListCalendarScreenEmptyStateAdjustFilters.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filters or search criteria'**
  String get adminListCalendarScreenEmptyStateAdjustFilters;

  /// No description provided for @adminListCalendarScreenPaginationShow.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get adminListCalendarScreenPaginationShow;

  /// No description provided for @adminListCalendarScreenPaginationEntriesPerPage.
  ///
  /// In en, this message translates to:
  /// **'entries per page'**
  String get adminListCalendarScreenPaginationEntriesPerPage;

  /// No description provided for @adminListCalendarScreenCalendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get adminListCalendarScreenCalendarTitle;

  /// No description provided for @adminListCalendarScreenCalendarDaysMonday.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get adminListCalendarScreenCalendarDaysMonday;

  /// No description provided for @adminListCalendarScreenCalendarDaysTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get adminListCalendarScreenCalendarDaysTuesday;

  /// No description provided for @adminListCalendarScreenCalendarDaysWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get adminListCalendarScreenCalendarDaysWednesday;

  /// No description provided for @adminListCalendarScreenCalendarDaysThursday.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get adminListCalendarScreenCalendarDaysThursday;

  /// No description provided for @adminListCalendarScreenCalendarDaysFriday.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get adminListCalendarScreenCalendarDaysFriday;

  /// No description provided for @adminListCalendarScreenCalendarDaysSaturday.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get adminListCalendarScreenCalendarDaysSaturday;

  /// No description provided for @adminListCalendarScreenCalendarDaysSunday.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get adminListCalendarScreenCalendarDaysSunday;

  /// No description provided for @adminListCalendarScreenCalendarDaysFullMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get adminListCalendarScreenCalendarDaysFullMonday;

  /// No description provided for @adminListCalendarScreenCalendarDaysFullTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get adminListCalendarScreenCalendarDaysFullTuesday;

  /// No description provided for @adminListCalendarScreenCalendarDaysFullWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get adminListCalendarScreenCalendarDaysFullWednesday;

  /// No description provided for @adminListCalendarScreenCalendarDaysFullThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get adminListCalendarScreenCalendarDaysFullThursday;

  /// No description provided for @adminListCalendarScreenCalendarDaysFullFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get adminListCalendarScreenCalendarDaysFullFriday;

  /// No description provided for @adminListCalendarScreenCalendarDaysFullSaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get adminListCalendarScreenCalendarDaysFullSaturday;

  /// No description provided for @adminListCalendarScreenCalendarDaysFullSunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get adminListCalendarScreenCalendarDaysFullSunday;

  /// No description provided for @adminListCalendarScreenCalendarDaysShortMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get adminListCalendarScreenCalendarDaysShortMon;

  /// No description provided for @adminListCalendarScreenCalendarDaysShortTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get adminListCalendarScreenCalendarDaysShortTue;

  /// No description provided for @adminListCalendarScreenCalendarDaysShortWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get adminListCalendarScreenCalendarDaysShortWed;

  /// No description provided for @adminListCalendarScreenCalendarDaysShortThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get adminListCalendarScreenCalendarDaysShortThu;

  /// No description provided for @adminListCalendarScreenCalendarDaysShortFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get adminListCalendarScreenCalendarDaysShortFri;

  /// No description provided for @adminListCalendarScreenCalendarDaysShortSat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get adminListCalendarScreenCalendarDaysShortSat;

  /// No description provided for @adminListCalendarScreenCalendarDaysShortSun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get adminListCalendarScreenCalendarDaysShortSun;

  /// No description provided for @adminListCalendarScreenCalendarMoreReservations.
  ///
  /// In en, this message translates to:
  /// **'more reservations'**
  String get adminListCalendarScreenCalendarMoreReservations;

  /// No description provided for @adminListCalendarScreenCalendarMenuLegend.
  ///
  /// In en, this message translates to:
  /// **'Menu Legend:'**
  String get adminListCalendarScreenCalendarMenuLegend;

  /// No description provided for @adminListCalendarScreenBlockedPeriodTitle.
  ///
  /// In en, this message translates to:
  /// **'Blocked Period'**
  String get adminListCalendarScreenBlockedPeriodTitle;

  /// No description provided for @adminListCalendarScreenBlockedPeriodReason.
  ///
  /// In en, this message translates to:
  /// **'Reason:'**
  String get adminListCalendarScreenBlockedPeriodReason;

  /// No description provided for @adminListCalendarScreenBlockedPeriodAffectedMenu.
  ///
  /// In en, this message translates to:
  /// **'Affected Menu:'**
  String get adminListCalendarScreenBlockedPeriodAffectedMenu;

  /// No description provided for @adminListCalendarScreenBlockedPeriodAllMenusBlocked.
  ///
  /// In en, this message translates to:
  /// **'All Menus Blocked'**
  String get adminListCalendarScreenBlockedPeriodAllMenusBlocked;

  /// No description provided for @adminListCalendarScreenBlockedPeriodSpecificMenu.
  ///
  /// In en, this message translates to:
  /// **'Specific Menu'**
  String get adminListCalendarScreenBlockedPeriodSpecificMenu;

  /// No description provided for @adminListCalendarScreenReservationTooltipCustomerInfo.
  ///
  /// In en, this message translates to:
  /// **'Customer Info'**
  String get adminListCalendarScreenReservationTooltipCustomerInfo;

  /// No description provided for @adminListCalendarScreenReservationTooltipMenuInfo.
  ///
  /// In en, this message translates to:
  /// **'Menu Info'**
  String get adminListCalendarScreenReservationTooltipMenuInfo;

  /// No description provided for @adminListCalendarScreenReservationTooltipMinute.
  ///
  /// In en, this message translates to:
  /// **'minute'**
  String get adminListCalendarScreenReservationTooltipMinute;

  /// No description provided for @adminListCalendarScreenReservationTooltipPeople.
  ///
  /// In en, this message translates to:
  /// **'people'**
  String get adminListCalendarScreenReservationTooltipPeople;

  /// No description provided for @adminListCalendarScreenReservationTooltipMenuPrice.
  ///
  /// In en, this message translates to:
  /// **'Menu Price:'**
  String get adminListCalendarScreenReservationTooltipMenuPrice;

  /// No description provided for @adminListCalendarScreenReservationTooltipNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes:'**
  String get adminListCalendarScreenReservationTooltipNotes;

  /// No description provided for @adminListCalendarScreenReservationTooltipClickToView.
  ///
  /// In en, this message translates to:
  /// **'Click to view full details'**
  String get adminListCalendarScreenReservationTooltipClickToView;

  /// No description provided for @adminListCalendarScreenLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Loading data...'**
  String get adminListCalendarScreenLoadingData;

  /// No description provided for @adminListCalendarScreenPrintCalendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Reservation Calendar'**
  String get adminListCalendarScreenPrintCalendarTitle;

  /// No description provided for @adminListCalendarScreenStatusLabelsPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get adminListCalendarScreenStatusLabelsPending;

  /// No description provided for @adminListCalendarScreenStatusLabelsConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get adminListCalendarScreenStatusLabelsConfirmed;

  /// No description provided for @adminListCalendarScreenStatusLabelsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get adminListCalendarScreenStatusLabelsCompleted;

  /// No description provided for @adminListCalendarScreenStatusLabelsCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get adminListCalendarScreenStatusLabelsCancelled;

  /// No description provided for @adminListCalendarScreenConfirmationChangeStatus.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to change the status of this reservation?'**
  String get adminListCalendarScreenConfirmationChangeStatus;

  /// No description provided for @adminListCalendarScreenAlertsError.
  ///
  /// In en, this message translates to:
  /// **'Error:'**
  String get adminListCalendarScreenAlertsError;

  /// No description provided for @adminListCalendarScreenAlertsUpdateError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while updating the status'**
  String get adminListCalendarScreenAlertsUpdateError;

  /// No description provided for @adminListCalendarScreenMonthsJanuary.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get adminListCalendarScreenMonthsJanuary;

  /// No description provided for @adminListCalendarScreenMonthsFebruary.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get adminListCalendarScreenMonthsFebruary;

  /// No description provided for @adminListCalendarScreenMonthsMarch.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get adminListCalendarScreenMonthsMarch;

  /// No description provided for @adminListCalendarScreenMonthsApril.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get adminListCalendarScreenMonthsApril;

  /// No description provided for @adminListCalendarScreenMonthsMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get adminListCalendarScreenMonthsMay;

  /// No description provided for @adminListCalendarScreenMonthsJune.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get adminListCalendarScreenMonthsJune;

  /// No description provided for @adminListCalendarScreenMonthsJuly.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get adminListCalendarScreenMonthsJuly;

  /// No description provided for @adminListCalendarScreenMonthsAugust.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get adminListCalendarScreenMonthsAugust;

  /// No description provided for @adminListCalendarScreenMonthsSeptember.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get adminListCalendarScreenMonthsSeptember;

  /// No description provided for @adminListCalendarScreenMonthsOctober.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get adminListCalendarScreenMonthsOctober;

  /// No description provided for @adminListCalendarScreenMonthsNovember.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get adminListCalendarScreenMonthsNovember;

  /// No description provided for @adminListCalendarScreenMonthsDecember.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get adminListCalendarScreenMonthsDecember;

  /// No description provided for @adminListCalendarScreenMonthsShortJan.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get adminListCalendarScreenMonthsShortJan;

  /// No description provided for @adminListCalendarScreenMonthsShortFeb.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get adminListCalendarScreenMonthsShortFeb;

  /// No description provided for @adminListCalendarScreenMonthsShortMar.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get adminListCalendarScreenMonthsShortMar;

  /// No description provided for @adminListCalendarScreenMonthsShortApr.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get adminListCalendarScreenMonthsShortApr;

  /// No description provided for @adminListCalendarScreenMonthsShortMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get adminListCalendarScreenMonthsShortMay;

  /// No description provided for @adminListCalendarScreenMonthsShortJun.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get adminListCalendarScreenMonthsShortJun;

  /// No description provided for @adminListCalendarScreenMonthsShortJul.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get adminListCalendarScreenMonthsShortJul;

  /// No description provided for @adminListCalendarScreenMonthsShortAug.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get adminListCalendarScreenMonthsShortAug;

  /// No description provided for @adminListCalendarScreenMonthsShortSep.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get adminListCalendarScreenMonthsShortSep;

  /// No description provided for @adminListCalendarScreenMonthsShortOct.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get adminListCalendarScreenMonthsShortOct;

  /// No description provided for @adminListCalendarScreenMonthsShortNov.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get adminListCalendarScreenMonthsShortNov;

  /// No description provided for @adminListCalendarScreenMonthsShortDec.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get adminListCalendarScreenMonthsShortDec;

  /// No description provided for @adminListCalendarScreenShowTitle.
  ///
  /// In en, this message translates to:
  /// **'Reservation Details #{id}'**
  String adminListCalendarScreenShowTitle(String id);

  /// No description provided for @adminListCalendarScreenShowCustomerInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Information'**
  String get adminListCalendarScreenShowCustomerInfoTitle;

  /// No description provided for @adminListCalendarScreenShowCustomerInfoTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer Type'**
  String get adminListCalendarScreenShowCustomerInfoTypeLabel;

  /// No description provided for @adminListCalendarScreenShowCustomerInfoTypeRegistered.
  ///
  /// In en, this message translates to:
  /// **'Registered Customer'**
  String get adminListCalendarScreenShowCustomerInfoTypeRegistered;

  /// No description provided for @adminListCalendarScreenShowCustomerInfoTypeGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest Customer'**
  String get adminListCalendarScreenShowCustomerInfoTypeGuest;

  /// No description provided for @adminListCalendarScreenShowCustomerInfoRegisteredLabel.
  ///
  /// In en, this message translates to:
  /// **'Registered Customer'**
  String get adminListCalendarScreenShowCustomerInfoRegisteredLabel;

  /// No description provided for @adminListCalendarScreenShowCustomerInfoFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get adminListCalendarScreenShowCustomerInfoFullNameLabel;

  /// No description provided for @adminListCalendarScreenShowCustomerInfoFullNameKanaLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name (Kana)'**
  String get adminListCalendarScreenShowCustomerInfoFullNameKanaLabel;

  /// No description provided for @adminListCalendarScreenShowCustomerInfoEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get adminListCalendarScreenShowCustomerInfoEmailLabel;

  /// No description provided for @adminListCalendarScreenShowCustomerInfoPhoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get adminListCalendarScreenShowCustomerInfoPhoneNumberLabel;

  /// No description provided for @adminListCalendarScreenShowReservationDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reservation Details'**
  String get adminListCalendarScreenShowReservationDetailsTitle;

  /// No description provided for @adminListCalendarScreenShowReservationDetailsMenuLabel.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get adminListCalendarScreenShowReservationDetailsMenuLabel;

  /// No description provided for @adminListCalendarScreenShowReservationDetailsYen.
  ///
  /// In en, this message translates to:
  /// **'yen'**
  String get adminListCalendarScreenShowReservationDetailsYen;

  /// No description provided for @adminListCalendarScreenShowReservationDetailsMinutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get adminListCalendarScreenShowReservationDetailsMinutes;

  /// No description provided for @adminListCalendarScreenShowReservationDetailsDatetimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Reservation Date & Time'**
  String get adminListCalendarScreenShowReservationDetailsDatetimeLabel;

  /// No description provided for @adminListCalendarScreenShowReservationDetailsEstimatedCompletionLabel.
  ///
  /// In en, this message translates to:
  /// **'Estimated completion:'**
  String
  get adminListCalendarScreenShowReservationDetailsEstimatedCompletionLabel;

  /// No description provided for @adminListCalendarScreenShowReservationDetailsNumberOfPeopleLabel.
  ///
  /// In en, this message translates to:
  /// **'Number of People'**
  String get adminListCalendarScreenShowReservationDetailsNumberOfPeopleLabel;

  /// No description provided for @adminListCalendarScreenShowReservationDetailsPeople.
  ///
  /// In en, this message translates to:
  /// **'people'**
  String get adminListCalendarScreenShowReservationDetailsPeople;

  /// No description provided for @adminListCalendarScreenShowReservationDetailsTotalCostLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Cost'**
  String get adminListCalendarScreenShowReservationDetailsTotalCostLabel;

  /// No description provided for @adminListCalendarScreenShowAdditionalInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Additional Information'**
  String get adminListCalendarScreenShowAdditionalInfoTitle;

  /// No description provided for @adminListCalendarScreenShowAdditionalInfoStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Reservation Status'**
  String get adminListCalendarScreenShowAdditionalInfoStatusLabel;

  /// No description provided for @adminListCalendarScreenShowAdditionalInfoCreatedAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Created At'**
  String get adminListCalendarScreenShowAdditionalInfoCreatedAtLabel;

  /// No description provided for @adminListCalendarScreenShowAdditionalInfoLastUpdatedLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get adminListCalendarScreenShowAdditionalInfoLastUpdatedLabel;

  /// No description provided for @adminListCalendarScreenShowAdditionalInfoNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get adminListCalendarScreenShowAdditionalInfoNotesLabel;

  /// No description provided for @adminListCalendarScreenShowBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back to Calendar'**
  String get adminListCalendarScreenShowBackButton;

  /// No description provided for @adminListCalendarScreenShowEditButton.
  ///
  /// In en, this message translates to:
  /// **'Edit Reservation'**
  String get adminListCalendarScreenShowEditButton;

  /// No description provided for @adminUpsertCalendarScreenCreatePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Create New Reservation'**
  String get adminUpsertCalendarScreenCreatePageTitle;

  /// No description provided for @adminUpsertCalendarScreenCreateFormCustomerType.
  ///
  /// In en, this message translates to:
  /// **'Customer Type'**
  String get adminUpsertCalendarScreenCreateFormCustomerType;

  /// No description provided for @adminUpsertCalendarScreenCreateFormRegisteredCustomer.
  ///
  /// In en, this message translates to:
  /// **'Registered Customer'**
  String get adminUpsertCalendarScreenCreateFormRegisteredCustomer;

  /// No description provided for @adminUpsertCalendarScreenCreateFormGuestCustomer.
  ///
  /// In en, this message translates to:
  /// **'Guest Customer'**
  String get adminUpsertCalendarScreenCreateFormGuestCustomer;

  /// No description provided for @adminUpsertCalendarScreenCreateFormSelectCustomer.
  ///
  /// In en, this message translates to:
  /// **'Select Customer'**
  String get adminUpsertCalendarScreenCreateFormSelectCustomer;

  /// No description provided for @adminUpsertCalendarScreenCreateFormSelectCustomerPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Select Customer...'**
  String get adminUpsertCalendarScreenCreateFormSelectCustomerPlaceholder;

  /// No description provided for @adminUpsertCalendarScreenCreateFormFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name *'**
  String get adminUpsertCalendarScreenCreateFormFullName;

  /// No description provided for @adminUpsertCalendarScreenCreateFormFullNameKana.
  ///
  /// In en, this message translates to:
  /// **'Full Name (Kana) *'**
  String get adminUpsertCalendarScreenCreateFormFullNameKana;

  /// No description provided for @adminUpsertCalendarScreenCreateFormEmail.
  ///
  /// In en, this message translates to:
  /// **'Email *'**
  String get adminUpsertCalendarScreenCreateFormEmail;

  /// No description provided for @adminUpsertCalendarScreenCreateFormPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number *'**
  String get adminUpsertCalendarScreenCreateFormPhoneNumber;

  /// No description provided for @adminUpsertCalendarScreenCreateFormMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu *'**
  String get adminUpsertCalendarScreenCreateFormMenu;

  /// No description provided for @adminUpsertCalendarScreenCreateFormSelectMenuPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Select Menu...'**
  String get adminUpsertCalendarScreenCreateFormSelectMenuPlaceholder;

  /// No description provided for @adminUpsertCalendarScreenCreateFormYen.
  ///
  /// In en, this message translates to:
  /// **'yen'**
  String get adminUpsertCalendarScreenCreateFormYen;

  /// No description provided for @adminUpsertCalendarScreenCreateFormMinutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get adminUpsertCalendarScreenCreateFormMinutes;

  /// No description provided for @adminUpsertCalendarScreenCreateFormReservationDatetime.
  ///
  /// In en, this message translates to:
  /// **'Reservation Date & Time *'**
  String get adminUpsertCalendarScreenCreateFormReservationDatetime;

  /// No description provided for @adminUpsertCalendarScreenCreateFormNumberOfPeople.
  ///
  /// In en, this message translates to:
  /// **'Number of People *'**
  String get adminUpsertCalendarScreenCreateFormNumberOfPeople;

  /// No description provided for @adminUpsertCalendarScreenCreateFormTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount *'**
  String get adminUpsertCalendarScreenCreateFormTotalAmount;

  /// No description provided for @adminUpsertCalendarScreenCreateFormStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminUpsertCalendarScreenCreateFormStatus;

  /// No description provided for @adminUpsertCalendarScreenCreateFormNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get adminUpsertCalendarScreenCreateFormNotes;

  /// No description provided for @adminUpsertCalendarScreenCreateStatusOptionsPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get adminUpsertCalendarScreenCreateStatusOptionsPending;

  /// No description provided for @adminUpsertCalendarScreenCreateStatusOptionsConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get adminUpsertCalendarScreenCreateStatusOptionsConfirmed;

  /// No description provided for @adminUpsertCalendarScreenCreateStatusOptionsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get adminUpsertCalendarScreenCreateStatusOptionsCompleted;

  /// No description provided for @adminUpsertCalendarScreenCreateStatusOptionsCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get adminUpsertCalendarScreenCreateStatusOptionsCancelled;

  /// No description provided for @adminUpsertCalendarScreenCreateButtonsSelectFromCalendar.
  ///
  /// In en, this message translates to:
  /// **'Select from Calendar'**
  String get adminUpsertCalendarScreenCreateButtonsSelectFromCalendar;

  /// No description provided for @adminUpsertCalendarScreenCreateButtonsCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminUpsertCalendarScreenCreateButtonsCancel;

  /// No description provided for @adminUpsertCalendarScreenCreateButtonsCheckAvailability.
  ///
  /// In en, this message translates to:
  /// **'Check Availability'**
  String get adminUpsertCalendarScreenCreateButtonsCheckAvailability;

  /// No description provided for @adminUpsertCalendarScreenCreateButtonsSaveReservation.
  ///
  /// In en, this message translates to:
  /// **'Save Reservation'**
  String get adminUpsertCalendarScreenCreateButtonsSaveReservation;

  /// No description provided for @adminUpsertCalendarScreenCreateButtonsConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get adminUpsertCalendarScreenCreateButtonsConfirm;

  /// No description provided for @adminUpsertCalendarScreenCreateAvailabilitySelectMenuAndDate.
  ///
  /// In en, this message translates to:
  /// **'Please select menu and date/time first.'**
  String get adminUpsertCalendarScreenCreateAvailabilitySelectMenuAndDate;

  /// No description provided for @adminUpsertCalendarScreenCreateAvailabilityAvailable.
  ///
  /// In en, this message translates to:
  /// **'Time slot is available for reservation.'**
  String get adminUpsertCalendarScreenCreateAvailabilityAvailable;

  /// No description provided for @adminUpsertCalendarScreenCreateAvailabilityUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Time slot is not available - conflicts with blocked periods or other reservations.'**
  String get adminUpsertCalendarScreenCreateAvailabilityUnavailable;

  /// No description provided for @adminUpsertCalendarScreenCreateAvailabilityError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while checking availability.'**
  String get adminUpsertCalendarScreenCreateAvailabilityError;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Select the date you want to book'**
  String get adminUpsertCalendarScreenCreateCalendarModalTitle;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get adminUpsertCalendarScreenCreateCalendarModalSelectDate;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalSelectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get adminUpsertCalendarScreenCreateCalendarModalSelectTime;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalPreviousMonth.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get adminUpsertCalendarScreenCreateCalendarModalPreviousMonth;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalNextMonth.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get adminUpsertCalendarScreenCreateCalendarModalNextMonth;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalFullyBlockedMessage.
  ///
  /// In en, this message translates to:
  /// **'This date is fully blocked and not available for reservations.'**
  String get adminUpsertCalendarScreenCreateCalendarModalFullyBlockedMessage;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalLegendTitle.
  ///
  /// In en, this message translates to:
  /// **'Legend:'**
  String get adminUpsertCalendarScreenCreateCalendarModalLegendTitle;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalLegendsFullyBlocked.
  ///
  /// In en, this message translates to:
  /// **'Fully Blocked'**
  String get adminUpsertCalendarScreenCreateCalendarModalLegendsFullyBlocked;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalLegendsBlockedPeriod.
  ///
  /// In en, this message translates to:
  /// **'Blocked Period'**
  String get adminUpsertCalendarScreenCreateCalendarModalLegendsBlockedPeriod;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalLegendsHasReservation.
  ///
  /// In en, this message translates to:
  /// **'Has Reservation'**
  String get adminUpsertCalendarScreenCreateCalendarModalLegendsHasReservation;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalLegendsMixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed (Blocked + Reservation)'**
  String get adminUpsertCalendarScreenCreateCalendarModalLegendsMixed;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalLegendsAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get adminUpsertCalendarScreenCreateCalendarModalLegendsAvailable;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalLegendsPastDate.
  ///
  /// In en, this message translates to:
  /// **'Past Date'**
  String get adminUpsertCalendarScreenCreateCalendarModalLegendsPastDate;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalDaysShort.
  ///
  /// In en, this message translates to:
  /// **'Sun,Mon,Tue,Wed,Thu,Fri,Sat'**
  String get adminUpsertCalendarScreenCreateCalendarModalDaysShort;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalMonths.
  ///
  /// In en, this message translates to:
  /// **'January,February,March,April,May,June,July,August,September,October,November,December'**
  String get adminUpsertCalendarScreenCreateCalendarModalMonths;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalAlertSelectMenu.
  ///
  /// In en, this message translates to:
  /// **'Please select a menu first.'**
  String get adminUpsertCalendarScreenCreateCalendarModalAlertSelectMenu;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalAlertDateFullyBlocked.
  ///
  /// In en, this message translates to:
  /// **'Selected date is fully blocked and not available for reservations.'**
  String get adminUpsertCalendarScreenCreateCalendarModalAlertDateFullyBlocked;

  /// No description provided for @adminUpsertCalendarScreenCreateCalendarModalAlertSelectDateTime.
  ///
  /// In en, this message translates to:
  /// **'Please select both date and time.'**
  String get adminUpsertCalendarScreenCreateCalendarModalAlertSelectDateTime;

  /// No description provided for @adminUpsertCalendarScreenEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Reservation #{id}'**
  String adminUpsertCalendarScreenEditTitle(String id);

  /// No description provided for @adminUpsertCalendarScreenEditErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred:'**
  String get adminUpsertCalendarScreenEditErrorOccurred;

  /// No description provided for @adminUpsertCalendarScreenEditCustomerTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer Type'**
  String get adminUpsertCalendarScreenEditCustomerTypeLabel;

  /// No description provided for @adminUpsertCalendarScreenEditRegisteredCustomer.
  ///
  /// In en, this message translates to:
  /// **'Registered Customer'**
  String get adminUpsertCalendarScreenEditRegisteredCustomer;

  /// No description provided for @adminUpsertCalendarScreenEditGuestCustomer.
  ///
  /// In en, this message translates to:
  /// **'Guest Customer'**
  String get adminUpsertCalendarScreenEditGuestCustomer;

  /// No description provided for @adminUpsertCalendarScreenEditSelectCustomerLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Customer'**
  String get adminUpsertCalendarScreenEditSelectCustomerLabel;

  /// No description provided for @adminUpsertCalendarScreenEditSelectCustomerOption.
  ///
  /// In en, this message translates to:
  /// **'Select Customer...'**
  String get adminUpsertCalendarScreenEditSelectCustomerOption;

  /// No description provided for @adminUpsertCalendarScreenEditFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name *'**
  String get adminUpsertCalendarScreenEditFullNameLabel;

  /// No description provided for @adminUpsertCalendarScreenEditFullNameKanaLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name (Kana) *'**
  String get adminUpsertCalendarScreenEditFullNameKanaLabel;

  /// No description provided for @adminUpsertCalendarScreenEditEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email *'**
  String get adminUpsertCalendarScreenEditEmailLabel;

  /// No description provided for @adminUpsertCalendarScreenEditPhoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number *'**
  String get adminUpsertCalendarScreenEditPhoneNumberLabel;

  /// No description provided for @adminUpsertCalendarScreenEditMenuLabel.
  ///
  /// In en, this message translates to:
  /// **'Menu *'**
  String get adminUpsertCalendarScreenEditMenuLabel;

  /// No description provided for @adminUpsertCalendarScreenEditSelectMenuOption.
  ///
  /// In en, this message translates to:
  /// **'Select Menu...'**
  String get adminUpsertCalendarScreenEditSelectMenuOption;

  /// No description provided for @adminUpsertCalendarScreenEditYen.
  ///
  /// In en, this message translates to:
  /// **'yen'**
  String get adminUpsertCalendarScreenEditYen;

  /// No description provided for @adminUpsertCalendarScreenEditMinutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get adminUpsertCalendarScreenEditMinutes;

  /// No description provided for @adminUpsertCalendarScreenEditReservationDatetimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Reservation Date & Time *'**
  String get adminUpsertCalendarScreenEditReservationDatetimeLabel;

  /// No description provided for @adminUpsertCalendarScreenEditSelectFromCalendarButton.
  ///
  /// In en, this message translates to:
  /// **'Select from Calendar'**
  String get adminUpsertCalendarScreenEditSelectFromCalendarButton;

  /// No description provided for @adminUpsertCalendarScreenEditNumberOfPeopleLabel.
  ///
  /// In en, this message translates to:
  /// **'Number of People *'**
  String get adminUpsertCalendarScreenEditNumberOfPeopleLabel;

  /// No description provided for @adminUpsertCalendarScreenEditTotalAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Amount *'**
  String get adminUpsertCalendarScreenEditTotalAmountLabel;

  /// No description provided for @adminUpsertCalendarScreenEditStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminUpsertCalendarScreenEditStatusLabel;

  /// No description provided for @adminUpsertCalendarScreenEditNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get adminUpsertCalendarScreenEditNotesLabel;

  /// No description provided for @adminUpsertCalendarScreenEditStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get adminUpsertCalendarScreenEditStatusPending;

  /// No description provided for @adminUpsertCalendarScreenEditStatusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get adminUpsertCalendarScreenEditStatusConfirmed;

  /// No description provided for @adminUpsertCalendarScreenEditStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get adminUpsertCalendarScreenEditStatusCompleted;

  /// No description provided for @adminUpsertCalendarScreenEditStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get adminUpsertCalendarScreenEditStatusCancelled;

  /// No description provided for @adminUpsertCalendarScreenEditCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminUpsertCalendarScreenEditCancelButton;

  /// No description provided for @adminUpsertCalendarScreenEditCheckAvailabilityButton.
  ///
  /// In en, this message translates to:
  /// **'Check Availability'**
  String get adminUpsertCalendarScreenEditCheckAvailabilityButton;

  /// No description provided for @adminUpsertCalendarScreenEditUpdateReservationButton.
  ///
  /// In en, this message translates to:
  /// **'Update Reservation'**
  String get adminUpsertCalendarScreenEditUpdateReservationButton;

  /// No description provided for @adminUpsertCalendarScreenEditModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Select the date you want to book'**
  String get adminUpsertCalendarScreenEditModalTitle;

  /// No description provided for @adminUpsertCalendarScreenEditSelectDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get adminUpsertCalendarScreenEditSelectDateLabel;

  /// No description provided for @adminUpsertCalendarScreenEditSelectTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get adminUpsertCalendarScreenEditSelectTimeLabel;

  /// No description provided for @adminUpsertCalendarScreenEditPreviousButton.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get adminUpsertCalendarScreenEditPreviousButton;

  /// No description provided for @adminUpsertCalendarScreenEditNextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get adminUpsertCalendarScreenEditNextButton;

  /// No description provided for @adminUpsertCalendarScreenEditDateFullyBlockedMessage.
  ///
  /// In en, this message translates to:
  /// **'This date is fully blocked and not available for reservations.'**
  String get adminUpsertCalendarScreenEditDateFullyBlockedMessage;

  /// No description provided for @adminUpsertCalendarScreenEditModalCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminUpsertCalendarScreenEditModalCancelButton;

  /// No description provided for @adminUpsertCalendarScreenEditModalConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get adminUpsertCalendarScreenEditModalConfirmButton;

  /// No description provided for @adminUpsertCalendarScreenEditMonths.
  ///
  /// In en, this message translates to:
  /// **'January,February,March,April,May,June,July,August,September,October,November,December'**
  String get adminUpsertCalendarScreenEditMonths;

  /// No description provided for @adminUpsertCalendarScreenEditDaysOfWeek.
  ///
  /// In en, this message translates to:
  /// **'Sun,Mon,Tue,Wed,Thu,Fri,Sat'**
  String get adminUpsertCalendarScreenEditDaysOfWeek;

  /// No description provided for @adminUpsertCalendarScreenEditLegendTitle.
  ///
  /// In en, this message translates to:
  /// **'Legend:'**
  String get adminUpsertCalendarScreenEditLegendTitle;

  /// No description provided for @adminUpsertCalendarScreenEditLegendFullyBlocked.
  ///
  /// In en, this message translates to:
  /// **'Fully Blocked'**
  String get adminUpsertCalendarScreenEditLegendFullyBlocked;

  /// No description provided for @adminUpsertCalendarScreenEditLegendBlockedPeriod.
  ///
  /// In en, this message translates to:
  /// **'Blocked Period'**
  String get adminUpsertCalendarScreenEditLegendBlockedPeriod;

  /// No description provided for @adminUpsertCalendarScreenEditLegendHasReservation.
  ///
  /// In en, this message translates to:
  /// **'Has Reservation'**
  String get adminUpsertCalendarScreenEditLegendHasReservation;

  /// No description provided for @adminUpsertCalendarScreenEditLegendMixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed (Blocked + Reservation)'**
  String get adminUpsertCalendarScreenEditLegendMixed;

  /// No description provided for @adminUpsertCalendarScreenEditLegendAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get adminUpsertCalendarScreenEditLegendAvailable;

  /// No description provided for @adminUpsertCalendarScreenEditLegendPastDate.
  ///
  /// In en, this message translates to:
  /// **'Past Date'**
  String get adminUpsertCalendarScreenEditLegendPastDate;

  /// No description provided for @adminUpsertCalendarScreenEditSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Reservation updated successfully.'**
  String get adminUpsertCalendarScreenEditSuccessMessage;

  /// No description provided for @adminUpsertCalendarScreenEditReservationNotFound.
  ///
  /// In en, this message translates to:
  /// **'Reservation not found.'**
  String get adminUpsertCalendarScreenEditReservationNotFound;

  /// No description provided for @adminUpsertCalendarScreenEditUpdateFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to update reservation: '**
  String get adminUpsertCalendarScreenEditUpdateFailedMessage;

  /// No description provided for @adminUpsertCalendarScreenEditJsSelectMenuDatetimeFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select menu and date/time first.'**
  String get adminUpsertCalendarScreenEditJsSelectMenuDatetimeFirst;

  /// No description provided for @adminUpsertCalendarScreenEditJsTimeslotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Time slot is available for reservation.'**
  String get adminUpsertCalendarScreenEditJsTimeslotAvailable;

  /// No description provided for @adminUpsertCalendarScreenEditJsTimeslotUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Time slot is not available - conflicts with blocked periods or other reservations.'**
  String get adminUpsertCalendarScreenEditJsTimeslotUnavailable;

  /// No description provided for @adminUpsertCalendarScreenEditJsAvailabilityError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while checking availability.'**
  String get adminUpsertCalendarScreenEditJsAvailabilityError;

  /// No description provided for @adminUpsertCalendarScreenEditJsSelectMenuFirstAlert.
  ///
  /// In en, this message translates to:
  /// **'Please select a menu first.'**
  String get adminUpsertCalendarScreenEditJsSelectMenuFirstAlert;

  /// No description provided for @adminUpsertCalendarScreenEditJsSelectDateTimeAlert.
  ///
  /// In en, this message translates to:
  /// **'Please select both date and time.'**
  String get adminUpsertCalendarScreenEditJsSelectDateTimeAlert;

  /// No description provided for @contactNotificationNotFound.
  ///
  /// In en, this message translates to:
  /// **'Contact not found.'**
  String get contactNotificationNotFound;

  /// No description provided for @contactNotificationUpdated.
  ///
  /// In en, this message translates to:
  /// **'Contact updated successfully.'**
  String get contactNotificationUpdated;

  /// No description provided for @contactNotificationErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {message}'**
  String contactNotificationErrorOccurred(String message);

  /// No description provided for @contactNotificationDeleted.
  ///
  /// In en, this message translates to:
  /// **'Contact deleted successfully.'**
  String get contactNotificationDeleted;

  /// No description provided for @contactNotificationDeletedError.
  ///
  /// In en, this message translates to:
  /// **'Contact could not be deleted.'**
  String get contactNotificationDeletedError;

  /// No description provided for @contactNotificationReplySent.
  ///
  /// In en, this message translates to:
  /// **'Reply sent and status updated successfully.'**
  String get contactNotificationReplySent;

  /// No description provided for @contactNotificationReplyError.
  ///
  /// In en, this message translates to:
  /// **'Contact not found or failed to update.'**
  String get contactNotificationReplyError;

  /// No description provided for @contactNotificationBulkDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Contacts deleted successfully.'**
  String get contactNotificationBulkDeleteSuccess;

  /// No description provided for @contactNotificationBulkDeleteError.
  ///
  /// In en, this message translates to:
  /// **'No contacts were successfully deleted.'**
  String get contactNotificationBulkDeleteError;

  /// No description provided for @contactNotificationBulkRepliedSuccess.
  ///
  /// In en, this message translates to:
  /// **'{count} contacts successfully marked as replied.'**
  String contactNotificationBulkRepliedSuccess(String count);

  /// No description provided for @contactNotificationBulkRepliedError.
  ///
  /// In en, this message translates to:
  /// **'No contacts were successfully updated.'**
  String get contactNotificationBulkRepliedError;

  /// No description provided for @adminListContactScreenPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Management'**
  String get adminListContactScreenPageTitle;

  /// No description provided for @adminListContactScreenPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage contact messages from customers'**
  String get adminListContactScreenPageSubtitle;

  /// No description provided for @adminListContactScreenAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add Contact'**
  String get adminListContactScreenAddButton;

  /// No description provided for @adminListContactScreenStatsTotal.
  ///
  /// In en, this message translates to:
  /// **'Total Contacts'**
  String get adminListContactScreenStatsTotal;

  /// No description provided for @adminListContactScreenStatsPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get adminListContactScreenStatsPending;

  /// No description provided for @adminListContactScreenStatsReplied.
  ///
  /// In en, this message translates to:
  /// **'Replied'**
  String get adminListContactScreenStatsReplied;

  /// No description provided for @adminListContactScreenStatsToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get adminListContactScreenStatsToday;

  /// No description provided for @adminListContactScreenFilterTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter & Search'**
  String get adminListContactScreenFilterTitle;

  /// No description provided for @adminListContactScreenFilterShowButton.
  ///
  /// In en, this message translates to:
  /// **'Show Filters'**
  String get adminListContactScreenFilterShowButton;

  /// No description provided for @adminListContactScreenFilterHideButton.
  ///
  /// In en, this message translates to:
  /// **'Hide Filters'**
  String get adminListContactScreenFilterHideButton;

  /// No description provided for @adminListContactScreenFilterStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminListContactScreenFilterStatusLabel;

  /// No description provided for @adminListContactScreenFilterStatusAll.
  ///
  /// In en, this message translates to:
  /// **'All Status'**
  String get adminListContactScreenFilterStatusAll;

  /// No description provided for @adminListContactScreenFilterStartDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get adminListContactScreenFilterStartDateLabel;

  /// No description provided for @adminListContactScreenFilterEndDateLabel.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get adminListContactScreenFilterEndDateLabel;

  /// No description provided for @adminListContactScreenFilterSearchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get adminListContactScreenFilterSearchLabel;

  /// No description provided for @adminListContactScreenFilterSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search name, email, subject...'**
  String get adminListContactScreenFilterSearchPlaceholder;

  /// No description provided for @adminListContactScreenFilterFilterButton.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get adminListContactScreenFilterFilterButton;

  /// No description provided for @adminListContactScreenFilterResetButton.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get adminListContactScreenFilterResetButton;

  /// No description provided for @adminListContactScreenBulkActionsItemsSelected.
  ///
  /// In en, this message translates to:
  /// **'{count} items selected'**
  String adminListContactScreenBulkActionsItemsSelected(String count);

  /// No description provided for @adminListContactScreenBulkActionsDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminListContactScreenBulkActionsDeleteButton;

  /// No description provided for @adminListContactScreenTableTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact List'**
  String get adminListContactScreenTableTitle;

  /// No description provided for @adminListContactScreenTableHeaderSender.
  ///
  /// In en, this message translates to:
  /// **'Sender'**
  String get adminListContactScreenTableHeaderSender;

  /// No description provided for @adminListContactScreenTableHeaderSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get adminListContactScreenTableHeaderSubject;

  /// No description provided for @adminListContactScreenTableHeaderMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get adminListContactScreenTableHeaderMessage;

  /// No description provided for @adminListContactScreenTableHeaderDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get adminListContactScreenTableHeaderDate;

  /// No description provided for @adminListContactScreenTableHeaderStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminListContactScreenTableHeaderStatus;

  /// No description provided for @adminListContactScreenTableHeaderActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get adminListContactScreenTableHeaderActions;

  /// No description provided for @adminListContactScreenTableActionViewTooltip.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get adminListContactScreenTableActionViewTooltip;

  /// No description provided for @adminListContactScreenTableActionReplyTooltip.
  ///
  /// In en, this message translates to:
  /// **'Quick Reply'**
  String get adminListContactScreenTableActionReplyTooltip;

  /// No description provided for @adminListContactScreenTableActionDeleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminListContactScreenTableActionDeleteTooltip;

  /// No description provided for @adminListContactScreenStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get adminListContactScreenStatusPending;

  /// No description provided for @adminListContactScreenStatusReplied.
  ///
  /// In en, this message translates to:
  /// **'Replied'**
  String get adminListContactScreenStatusReplied;

  /// No description provided for @adminListContactScreenEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No contacts'**
  String get adminListContactScreenEmptyTitle;

  /// No description provided for @adminListContactScreenEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No contact messages have been received or match the applied filters.'**
  String get adminListContactScreenEmptyMessage;

  /// No description provided for @adminListContactScreenModalCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminListContactScreenModalCancelButton;

  /// No description provided for @adminListContactScreenModalReplyTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Reply'**
  String get adminListContactScreenModalReplyTitle;

  /// No description provided for @adminListContactScreenModalReplyPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write your reply...'**
  String get adminListContactScreenModalReplyPlaceholder;

  /// No description provided for @adminListContactScreenModalReplySendButton.
  ///
  /// In en, this message translates to:
  /// **'Send Reply'**
  String get adminListContactScreenModalReplySendButton;

  /// No description provided for @adminListContactScreenModalDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get adminListContactScreenModalDeleteTitle;

  /// No description provided for @adminListContactScreenModalDeleteConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminListContactScreenModalDeleteConfirmButton;

  /// No description provided for @adminListContactScreenModalDeleteConfirmMessageSingle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this contact?'**
  String get adminListContactScreenModalDeleteConfirmMessageSingle;

  /// No description provided for @adminListContactScreenModalDeleteConfirmMessageMultiple.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {count} contacts?'**
  String adminListContactScreenModalDeleteConfirmMessageMultiple(String count);

  /// No description provided for @adminListContactScreenAlertReplyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Reply message cannot be empty.'**
  String get adminListContactScreenAlertReplyEmpty;

  /// No description provided for @adminListContactScreenAlertReplyError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while sending the reply.'**
  String get adminListContactScreenAlertReplyError;

  /// No description provided for @adminListContactScreenAlertDeleteError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while deleting.'**
  String get adminListContactScreenAlertDeleteError;

  /// No description provided for @adminListContactScreenAlertDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Contact(s) deleted successfully.'**
  String get adminListContactScreenAlertDeleteSuccess;

  /// No description provided for @adminListContactScreenAlertReplySuccess.
  ///
  /// In en, this message translates to:
  /// **'Reply sent successfully.'**
  String get adminListContactScreenAlertReplySuccess;

  /// No description provided for @adminUpsertContactScreenPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Details'**
  String get adminUpsertContactScreenPageTitle;

  /// No description provided for @adminUpsertContactScreenPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View and update contact message'**
  String get adminUpsertContactScreenPageSubtitle;

  /// No description provided for @adminUpsertContactScreenButtonsBackToList.
  ///
  /// In en, this message translates to:
  /// **'Back to List'**
  String get adminUpsertContactScreenButtonsBackToList;

  /// No description provided for @adminUpsertContactScreenButtonsUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update Contact'**
  String get adminUpsertContactScreenButtonsUpdate;

  /// No description provided for @adminUpsertContactScreenButtonsDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminUpsertContactScreenButtonsDelete;

  /// No description provided for @adminUpsertContactScreenButtonsCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminUpsertContactScreenButtonsCancel;

  /// No description provided for @adminUpsertContactScreenCardContactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get adminUpsertContactScreenCardContactInfo;

  /// No description provided for @adminUpsertContactScreenCardUpdateContact.
  ///
  /// In en, this message translates to:
  /// **'Update Contact'**
  String get adminUpsertContactScreenCardUpdateContact;

  /// No description provided for @adminUpsertContactScreenCardQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get adminUpsertContactScreenCardQuickActions;

  /// No description provided for @adminUpsertContactScreenLabelsSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get adminUpsertContactScreenLabelsSubject;

  /// No description provided for @adminUpsertContactScreenLabelsMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get adminUpsertContactScreenLabelsMessage;

  /// No description provided for @adminUpsertContactScreenLabelsAdminReply.
  ///
  /// In en, this message translates to:
  /// **'Admin Reply'**
  String get adminUpsertContactScreenLabelsAdminReply;

  /// No description provided for @adminUpsertContactScreenLabelsStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminUpsertContactScreenLabelsStatus;

  /// No description provided for @adminUpsertContactScreenStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get adminUpsertContactScreenStatusPending;

  /// No description provided for @adminUpsertContactScreenStatusReplied.
  ///
  /// In en, this message translates to:
  /// **'Replied'**
  String get adminUpsertContactScreenStatusReplied;

  /// No description provided for @adminUpsertContactScreenFormReplyPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write your reply to the customer...'**
  String get adminUpsertContactScreenFormReplyPlaceholder;

  /// No description provided for @adminUpsertContactScreenFormReplyHelpText.
  ///
  /// In en, this message translates to:
  /// **'Maximum 2000 characters'**
  String get adminUpsertContactScreenFormReplyHelpText;

  /// No description provided for @adminUpsertContactScreenQuickActionsMarkAsReplied.
  ///
  /// In en, this message translates to:
  /// **'Mark as Replied'**
  String get adminUpsertContactScreenQuickActionsMarkAsReplied;

  /// No description provided for @adminUpsertContactScreenQuickActionsMarkAsPending.
  ///
  /// In en, this message translates to:
  /// **'Mark as Pending'**
  String get adminUpsertContactScreenQuickActionsMarkAsPending;

  /// No description provided for @adminUpsertContactScreenQuickActionsDefaultReply.
  ///
  /// In en, this message translates to:
  /// **'Thank you for contacting us. We have received your message and will get back to you soon.'**
  String get adminUpsertContactScreenQuickActionsDefaultReply;

  /// No description provided for @adminUpsertContactScreenDeleteModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get adminUpsertContactScreenDeleteModalTitle;

  /// No description provided for @adminUpsertContactScreenDeleteModalText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this contact? This action cannot be undone.'**
  String get adminUpsertContactScreenDeleteModalText;

  /// No description provided for @adminUpsertContactScreenAlertsErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred:'**
  String get adminUpsertContactScreenAlertsErrorOccurred;

  /// No description provided for @adminUpsertContactScreenAlertsDeleteError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while deleting'**
  String get adminUpsertContactScreenAlertsDeleteError;

  /// No description provided for @adminListCustomerManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Management'**
  String get adminListCustomerManagementTitle;

  /// No description provided for @adminListCustomerManagementDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage customer data and their reservation history.'**
  String get adminListCustomerManagementDescription;

  /// No description provided for @adminListCustomerManagementStatsFirstTime.
  ///
  /// In en, this message translates to:
  /// **'First Time'**
  String get adminListCustomerManagementStatsFirstTime;

  /// No description provided for @adminListCustomerManagementStatsRepeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get adminListCustomerManagementStatsRepeat;

  /// No description provided for @adminListCustomerManagementStatsDormant.
  ///
  /// In en, this message translates to:
  /// **'Dormant'**
  String get adminListCustomerManagementStatsDormant;

  /// No description provided for @adminListCustomerManagementFiltersSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search by name, email, or phone number...'**
  String get adminListCustomerManagementFiltersSearchPlaceholder;

  /// No description provided for @adminListCustomerManagementFiltersAllTypes.
  ///
  /// In en, this message translates to:
  /// **'All Customer Types'**
  String get adminListCustomerManagementFiltersAllTypes;

  /// No description provided for @adminListCustomerManagementFiltersFirstTime.
  ///
  /// In en, this message translates to:
  /// **'First Time'**
  String get adminListCustomerManagementFiltersFirstTime;

  /// No description provided for @adminListCustomerManagementFiltersRepeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat Customer'**
  String get adminListCustomerManagementFiltersRepeat;

  /// No description provided for @adminListCustomerManagementFiltersDormant.
  ///
  /// In en, this message translates to:
  /// **'Dormant'**
  String get adminListCustomerManagementFiltersDormant;

  /// No description provided for @adminListCustomerManagementFiltersReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get adminListCustomerManagementFiltersReset;

  /// No description provided for @adminListCustomerManagementTableHeaderCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get adminListCustomerManagementTableHeaderCustomer;

  /// No description provided for @adminListCustomerManagementTableHeaderContactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Info'**
  String get adminListCustomerManagementTableHeaderContactInfo;

  /// No description provided for @adminListCustomerManagementTableHeaderStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminListCustomerManagementTableHeaderStatus;

  /// No description provided for @adminListCustomerManagementTableHeaderReservations.
  ///
  /// In en, this message translates to:
  /// **'Reservations'**
  String get adminListCustomerManagementTableHeaderReservations;

  /// No description provided for @adminListCustomerManagementTableHeaderTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get adminListCustomerManagementTableHeaderTotalAmount;

  /// No description provided for @adminListCustomerManagementTableHeaderLastReservation.
  ///
  /// In en, this message translates to:
  /// **'Last Reservation'**
  String get adminListCustomerManagementTableHeaderLastReservation;

  /// No description provided for @adminListCustomerManagementTableHeaderActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get adminListCustomerManagementTableHeaderActions;

  /// No description provided for @adminListCustomerManagementTableStatusBadgeRegistered.
  ///
  /// In en, this message translates to:
  /// **'Registered'**
  String get adminListCustomerManagementTableStatusBadgeRegistered;

  /// No description provided for @adminListCustomerManagementTableStatusBadgeGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get adminListCustomerManagementTableStatusBadgeGuest;

  /// No description provided for @adminListCustomerManagementTableTypeBadgeFirstTime.
  ///
  /// In en, this message translates to:
  /// **'First Time'**
  String get adminListCustomerManagementTableTypeBadgeFirstTime;

  /// No description provided for @adminListCustomerManagementTableTypeBadgeRepeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get adminListCustomerManagementTableTypeBadgeRepeat;

  /// No description provided for @adminListCustomerManagementTableTypeBadgeDormant.
  ///
  /// In en, this message translates to:
  /// **'Dormant'**
  String get adminListCustomerManagementTableTypeBadgeDormant;

  /// No description provided for @adminListCustomerManagementTableReservationsCount.
  ///
  /// In en, this message translates to:
  /// **':count times'**
  String get adminListCustomerManagementTableReservationsCount;

  /// No description provided for @adminListCustomerManagementTableActionsTooltipViewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get adminListCustomerManagementTableActionsTooltipViewDetails;

  /// No description provided for @adminListCustomerManagementTableActionsTooltipSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get adminListCustomerManagementTableActionsTooltipSendMessage;

  /// No description provided for @adminListCustomerManagementTableEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No customers found'**
  String get adminListCustomerManagementTableEmptyTitle;

  /// No description provided for @adminListCustomerManagementTableEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'There are no customers registered or matching the selected filters.'**
  String get adminListCustomerManagementTableEmptyDescription;

  /// No description provided for @adminListCustomerManagementPaginationPrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get adminListCustomerManagementPaginationPrevious;

  /// No description provided for @adminListCustomerManagementPaginationNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get adminListCustomerManagementPaginationNext;

  /// No description provided for @adminListCustomerManagementModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get adminListCustomerManagementModalTitle;

  /// No description provided for @adminListCustomerManagementModalSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get adminListCustomerManagementModalSubject;

  /// No description provided for @adminListCustomerManagementModalSubjectPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter subject'**
  String get adminListCustomerManagementModalSubjectPlaceholder;

  /// No description provided for @adminListCustomerManagementModalMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get adminListCustomerManagementModalMessage;

  /// No description provided for @adminListCustomerManagementModalMessagePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your message'**
  String get adminListCustomerManagementModalMessagePlaceholder;

  /// No description provided for @adminListCustomerManagementModalCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminListCustomerManagementModalCancel;

  /// No description provided for @adminListCustomerManagementModalSend.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get adminListCustomerManagementModalSend;

  /// No description provided for @adminListCustomerManagementAlertsValidationError.
  ///
  /// In en, this message translates to:
  /// **'Please fill in both subject and message'**
  String get adminListCustomerManagementAlertsValidationError;

  /// No description provided for @adminListCustomerManagementAlertsSendSuccess.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully!'**
  String get adminListCustomerManagementAlertsSendSuccess;

  /// No description provided for @adminListCustomerManagementAlertsSendError.
  ///
  /// In en, this message translates to:
  /// **'Failed to send message'**
  String get adminListCustomerManagementAlertsSendError;

  /// No description provided for @adminUpsertCustomerManagementHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Detail'**
  String get adminUpsertCustomerManagementHeaderTitle;

  /// No description provided for @adminUpsertCustomerManagementHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View detailed customer information and history.'**
  String get adminUpsertCustomerManagementHeaderSubtitle;

  /// No description provided for @adminUpsertCustomerManagementHeaderSendMessageButton.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get adminUpsertCustomerManagementHeaderSendMessageButton;

  /// No description provided for @adminUpsertCustomerManagementHeaderExportButton.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get adminUpsertCustomerManagementHeaderExportButton;

  /// No description provided for @adminUpsertCustomerManagementStatsTotalReservations.
  ///
  /// In en, this message translates to:
  /// **'Total Reservations'**
  String get adminUpsertCustomerManagementStatsTotalReservations;

  /// No description provided for @adminUpsertCustomerManagementStatsTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get adminUpsertCustomerManagementStatsTotalAmount;

  /// No description provided for @adminUpsertCustomerManagementStatsTireStorage.
  ///
  /// In en, this message translates to:
  /// **'Tire Storage'**
  String get adminUpsertCustomerManagementStatsTireStorage;

  /// No description provided for @adminUpsertCustomerManagementSidebarStatusRegistered.
  ///
  /// In en, this message translates to:
  /// **'Registered'**
  String get adminUpsertCustomerManagementSidebarStatusRegistered;

  /// No description provided for @adminUpsertCustomerManagementSidebarStatusGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get adminUpsertCustomerManagementSidebarStatusGuest;

  /// No description provided for @adminUpsertCustomerManagementSidebarEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get adminUpsertCustomerManagementSidebarEmail;

  /// No description provided for @adminUpsertCustomerManagementSidebarPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get adminUpsertCustomerManagementSidebarPhone;

  /// No description provided for @adminUpsertCustomerManagementSidebarCompany.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get adminUpsertCustomerManagementSidebarCompany;

  /// No description provided for @adminUpsertCustomerManagementSidebarDepartment.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get adminUpsertCustomerManagementSidebarDepartment;

  /// No description provided for @adminUpsertCustomerManagementSidebarDob.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get adminUpsertCustomerManagementSidebarDob;

  /// No description provided for @adminUpsertCustomerManagementSidebarGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get adminUpsertCustomerManagementSidebarGender;

  /// No description provided for @adminUpsertCustomerManagementSidebarGuestInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Guest Customer'**
  String get adminUpsertCustomerManagementSidebarGuestInfoTitle;

  /// No description provided for @adminUpsertCustomerManagementSidebarGuestInfoBody.
  ///
  /// In en, this message translates to:
  /// **'This customer made reservations as a guest. Limited information available.'**
  String get adminUpsertCustomerManagementSidebarGuestInfoBody;

  /// No description provided for @adminUpsertCustomerManagementTabsCustomerInfo.
  ///
  /// In en, this message translates to:
  /// **'Customer Info'**
  String get adminUpsertCustomerManagementTabsCustomerInfo;

  /// No description provided for @adminUpsertCustomerManagementTabsReservationHistory.
  ///
  /// In en, this message translates to:
  /// **'Reservation History'**
  String get adminUpsertCustomerManagementTabsReservationHistory;

  /// No description provided for @adminUpsertCustomerManagementTabsTireStorage.
  ///
  /// In en, this message translates to:
  /// **'Tire Storage'**
  String get adminUpsertCustomerManagementTabsTireStorage;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Information'**
  String get adminUpsertCustomerManagementMainContentCustomerInfoTitle;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get adminUpsertCustomerManagementMainContentCustomerInfoFullName;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoFullNameKana.
  ///
  /// In en, this message translates to:
  /// **'Full Name (Kana)'**
  String get adminUpsertCustomerManagementMainContentCustomerInfoFullNameKana;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get adminUpsertCustomerManagementMainContentCustomerInfoEmail;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get adminUpsertCustomerManagementMainContentCustomerInfoPhoneNumber;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get adminUpsertCustomerManagementMainContentCustomerInfoCompanyName;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoDepartment.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get adminUpsertCustomerManagementMainContentCustomerInfoDepartment;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoDob.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get adminUpsertCustomerManagementMainContentCustomerInfoDob;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get adminUpsertCustomerManagementMainContentCustomerInfoGender;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoAddressesTitle.
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get adminUpsertCustomerManagementMainContentCustomerInfoAddressesTitle;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoCompanyAddress.
  ///
  /// In en, this message translates to:
  /// **'Company Address'**
  String get adminUpsertCustomerManagementMainContentCustomerInfoCompanyAddress;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoHomeAddress.
  ///
  /// In en, this message translates to:
  /// **'Home Address'**
  String get adminUpsertCustomerManagementMainContentCustomerInfoHomeAddress;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoGuestTitle.
  ///
  /// In en, this message translates to:
  /// **'Guest Customer'**
  String get adminUpsertCustomerManagementMainContentCustomerInfoGuestTitle;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoGuestBody.
  ///
  /// In en, this message translates to:
  /// **'This customer made reservations as a guest. Only basic reservation information is available.'**
  String get adminUpsertCustomerManagementMainContentCustomerInfoGuestBody;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoGuestNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name:'**
  String get adminUpsertCustomerManagementMainContentCustomerInfoGuestNameLabel;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoGuestNameKanaLabel.
  ///
  /// In en, this message translates to:
  /// **'Name (Kana):'**
  String
  get adminUpsertCustomerManagementMainContentCustomerInfoGuestNameKanaLabel;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoGuestEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email:'**
  String
  get adminUpsertCustomerManagementMainContentCustomerInfoGuestEmailLabel;

  /// No description provided for @adminUpsertCustomerManagementMainContentCustomerInfoGuestPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone:'**
  String
  get adminUpsertCustomerManagementMainContentCustomerInfoGuestPhoneLabel;

  /// No description provided for @adminUpsertCustomerManagementMainContentReservationHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Reservation History'**
  String get adminUpsertCustomerManagementMainContentReservationHistoryTitle;

  /// No description provided for @adminUpsertCustomerManagementMainContentReservationHistoryCountText.
  ///
  /// In en, this message translates to:
  /// **':count reservations'**
  String
  get adminUpsertCustomerManagementMainContentReservationHistoryCountText;

  /// No description provided for @adminUpsertCustomerManagementMainContentReservationHistoryDateTime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time:'**
  String get adminUpsertCustomerManagementMainContentReservationHistoryDateTime;

  /// No description provided for @adminUpsertCustomerManagementMainContentReservationHistoryPeople.
  ///
  /// In en, this message translates to:
  /// **'People:'**
  String get adminUpsertCustomerManagementMainContentReservationHistoryPeople;

  /// No description provided for @adminUpsertCustomerManagementMainContentReservationHistoryMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu:'**
  String get adminUpsertCustomerManagementMainContentReservationHistoryMenu;

  /// No description provided for @adminUpsertCustomerManagementMainContentReservationHistoryAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount:'**
  String get adminUpsertCustomerManagementMainContentReservationHistoryAmount;

  /// No description provided for @adminUpsertCustomerManagementMainContentReservationHistoryNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes:'**
  String get adminUpsertCustomerManagementMainContentReservationHistoryNotes;

  /// No description provided for @adminUpsertCustomerManagementMainContentReservationHistoryViewDetailsLink.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String
  get adminUpsertCustomerManagementMainContentReservationHistoryViewDetailsLink;

  /// No description provided for @adminUpsertCustomerManagementMainContentReservationHistoryNoRecords.
  ///
  /// In en, this message translates to:
  /// **'No reservation history found.'**
  String
  get adminUpsertCustomerManagementMainContentReservationHistoryNoRecords;

  /// No description provided for @adminUpsertCustomerManagementMainContentTireStorageTitle.
  ///
  /// In en, this message translates to:
  /// **'Tire Storage'**
  String get adminUpsertCustomerManagementMainContentTireStorageTitle;

  /// No description provided for @adminUpsertCustomerManagementMainContentTireStorageCountText.
  ///
  /// In en, this message translates to:
  /// **':count storage records'**
  String get adminUpsertCustomerManagementMainContentTireStorageCountText;

  /// No description provided for @adminUpsertCustomerManagementMainContentTireStorageStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date:'**
  String get adminUpsertCustomerManagementMainContentTireStorageStartDate;

  /// No description provided for @adminUpsertCustomerManagementMainContentTireStoragePlannedEnd.
  ///
  /// In en, this message translates to:
  /// **'Planned End:'**
  String get adminUpsertCustomerManagementMainContentTireStoragePlannedEnd;

  /// No description provided for @adminUpsertCustomerManagementMainContentTireStorageStorageFee.
  ///
  /// In en, this message translates to:
  /// **'Storage Fee:'**
  String get adminUpsertCustomerManagementMainContentTireStorageStorageFee;

  /// No description provided for @adminUpsertCustomerManagementMainContentTireStorageDaysRemaining.
  ///
  /// In en, this message translates to:
  /// **'Days Remaining:'**
  String get adminUpsertCustomerManagementMainContentTireStorageDaysRemaining;

  /// No description provided for @adminUpsertCustomerManagementMainContentTireStorageDaysRemainingText.
  ///
  /// In en, this message translates to:
  /// **':days days'**
  String
  get adminUpsertCustomerManagementMainContentTireStorageDaysRemainingText;

  /// No description provided for @adminUpsertCustomerManagementMainContentTireStorageNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes:'**
  String get adminUpsertCustomerManagementMainContentTireStorageNotes;

  /// No description provided for @adminUpsertCustomerManagementMainContentTireStorageNoRecords.
  ///
  /// In en, this message translates to:
  /// **'No tire storage records found.'**
  String get adminUpsertCustomerManagementMainContentTireStorageNoRecords;

  /// No description provided for @adminUpsertCustomerManagementModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Send Message to :name'**
  String get adminUpsertCustomerManagementModalTitle;

  /// No description provided for @adminUpsertCustomerManagementModalSubjectLabel.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get adminUpsertCustomerManagementModalSubjectLabel;

  /// No description provided for @adminUpsertCustomerManagementModalSubjectPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter subject'**
  String get adminUpsertCustomerManagementModalSubjectPlaceholder;

  /// No description provided for @adminUpsertCustomerManagementModalMessageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get adminUpsertCustomerManagementModalMessageLabel;

  /// No description provided for @adminUpsertCustomerManagementModalMessagePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your message'**
  String get adminUpsertCustomerManagementModalMessagePlaceholder;

  /// No description provided for @adminUpsertCustomerManagementModalCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminUpsertCustomerManagementModalCancelButton;

  /// No description provided for @adminUpsertCustomerManagementModalSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get adminUpsertCustomerManagementModalSendButton;

  /// No description provided for @adminUpsertCustomerManagementJsAlertsFillFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in both subject and message'**
  String get adminUpsertCustomerManagementJsAlertsFillFields;

  /// No description provided for @adminUpsertCustomerManagementJsAlertsSendSuccess.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully!'**
  String get adminUpsertCustomerManagementJsAlertsSendSuccess;

  /// No description provided for @adminUpsertCustomerManagementJsAlertsSendFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send message'**
  String get adminUpsertCustomerManagementJsAlertsSendFailed;

  /// No description provided for @adminUpsertCustomerManagementJsAlertsExportPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Export functionality will be implemented'**
  String get adminUpsertCustomerManagementJsAlertsExportPlaceholder;

  /// No description provided for @adminDashboardAnnouncementCloseTooltip.
  ///
  /// In en, this message translates to:
  /// **'Close announcement'**
  String get adminDashboardAnnouncementCloseTooltip;

  /// No description provided for @adminDashboardTodoTitle.
  ///
  /// In en, this message translates to:
  /// **'To Do'**
  String get adminDashboardTodoTitle;

  /// No description provided for @adminDashboardTodoTodayReservations.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Reservations'**
  String get adminDashboardTodoTodayReservations;

  /// No description provided for @adminDashboardTodoContacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get adminDashboardTodoContacts;

  /// No description provided for @adminDashboardTodoCasesUnit.
  ///
  /// In en, this message translates to:
  /// **'Cases'**
  String get adminDashboardTodoCasesUnit;

  /// No description provided for @adminDashboardContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get adminDashboardContactTitle;

  /// No description provided for @adminDashboardContactReceivedAt.
  ///
  /// In en, this message translates to:
  /// **'Received At'**
  String get adminDashboardContactReceivedAt;

  /// No description provided for @adminDashboardContactCustomerName.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get adminDashboardContactCustomerName;

  /// No description provided for @adminDashboardContactSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get adminDashboardContactSubject;

  /// No description provided for @adminDashboardContactNoPending.
  ///
  /// In en, this message translates to:
  /// **'No pending contacts'**
  String get adminDashboardContactNoPending;

  /// No description provided for @adminDashboardContactSeeMore.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get adminDashboardContactSeeMore;

  /// No description provided for @adminDashboardReservationTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Reservations'**
  String get adminDashboardReservationTitle;

  /// No description provided for @adminDashboardReservationTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get adminDashboardReservationTime;

  /// No description provided for @adminDashboardReservationService.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get adminDashboardReservationService;

  /// No description provided for @adminDashboardReservationCustomerName.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get adminDashboardReservationCustomerName;

  /// No description provided for @adminDashboardReservationNoReservationsToday.
  ///
  /// In en, this message translates to:
  /// **'No reservations today'**
  String get adminDashboardReservationNoReservationsToday;

  /// No description provided for @adminDashboardStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Reservations/Customer Status (:date)'**
  String get adminDashboardStatusTitle;

  /// No description provided for @adminDashboardStatusReservations.
  ///
  /// In en, this message translates to:
  /// **'Reservations'**
  String get adminDashboardStatusReservations;

  /// No description provided for @adminDashboardStatusNewCustomers.
  ///
  /// In en, this message translates to:
  /// **'New Customers'**
  String get adminDashboardStatusNewCustomers;

  /// No description provided for @adminDashboardStatusCasesUnit.
  ///
  /// In en, this message translates to:
  /// **'Cases'**
  String get adminDashboardStatusCasesUnit;

  /// No description provided for @adminDashboardJavascriptConfirmCloseAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to close this announcement?'**
  String get adminDashboardJavascriptConfirmCloseAnnouncement;

  /// No description provided for @adminDashboardJavascriptDeactivationError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while deactivating the announcement.'**
  String get adminDashboardJavascriptDeactivationError;

  /// No description provided for @homePrimaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Our Service'**
  String get homePrimaryTitle;

  /// No description provided for @inquirySidebarLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get inquirySidebarLocation;

  /// No description provided for @inquirySidebarOpeningHours.
  ///
  /// In en, this message translates to:
  /// **'Opening Hours'**
  String get inquirySidebarOpeningHours;

  /// No description provided for @inquirySidebarClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get inquirySidebarClosed;

  /// No description provided for @inquirySidebarAboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get inquirySidebarAboutUs;

  /// No description provided for @inquirySidebarTermsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get inquirySidebarTermsOfUse;

  /// No description provided for @inquiryDayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get inquiryDayMonday;

  /// No description provided for @inquiryDayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get inquiryDayTuesday;

  /// No description provided for @inquiryDayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get inquiryDayWednesday;

  /// No description provided for @inquiryDayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get inquiryDayThursday;

  /// No description provided for @inquiryDayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get inquiryDayFriday;

  /// No description provided for @inquiryDaySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get inquiryDaySaturday;

  /// No description provided for @inquiryDaySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get inquiryDaySunday;

  /// No description provided for @inquiryFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Inquiry'**
  String get inquiryFormTitle;

  /// No description provided for @inquiryFormName.
  ///
  /// In en, this message translates to:
  /// **'Name *'**
  String get inquiryFormName;

  /// No description provided for @inquiryFormEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Address *'**
  String get inquiryFormEmail;

  /// No description provided for @inquiryFormPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get inquiryFormPhone;

  /// No description provided for @inquiryFormSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject *'**
  String get inquiryFormSubject;

  /// No description provided for @inquiryFormInquiryContent.
  ///
  /// In en, this message translates to:
  /// **'Inquiry Content *'**
  String get inquiryFormInquiryContent;

  /// No description provided for @inquiryFormSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit Inquiry'**
  String get inquiryFormSubmitButton;

  /// No description provided for @inquiryPlaceholderName.
  ///
  /// In en, this message translates to:
  /// **'Tokyo Taro Barang'**
  String get inquiryPlaceholderName;

  /// No description provided for @inquiryPlaceholderEmail.
  ///
  /// In en, this message translates to:
  /// **'your@email.com'**
  String get inquiryPlaceholderEmail;

  /// No description provided for @inquiryPlaceholderPhone.
  ///
  /// In en, this message translates to:
  /// **'00-0000-0000'**
  String get inquiryPlaceholderPhone;

  /// No description provided for @inquiryPlaceholderMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter the content of your inquiry'**
  String get inquiryPlaceholderMessage;

  /// No description provided for @inquirySuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your inquiry has been sent successfully!'**
  String get inquirySuccessMessage;

  /// No description provided for @inquiryErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'There was an error sending your inquiry. Please try again later.'**
  String get inquiryErrorMessage;

  /// No description provided for @adminListMenuScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Menu Management'**
  String get adminListMenuScreenTitle;

  /// No description provided for @adminListMenuScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage service menus for customers'**
  String get adminListMenuScreenSubtitle;

  /// No description provided for @adminListMenuScreenAddMenu.
  ///
  /// In en, this message translates to:
  /// **'Add Menu'**
  String get adminListMenuScreenAddMenu;

  /// No description provided for @adminListMenuScreenFilter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get adminListMenuScreenFilter;

  /// No description provided for @adminListMenuScreenReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get adminListMenuScreenReset;

  /// No description provided for @adminListMenuScreenActivate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get adminListMenuScreenActivate;

  /// No description provided for @adminListMenuScreenDeactivate.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get adminListMenuScreenDeactivate;

  /// No description provided for @adminListMenuScreenDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminListMenuScreenDelete;

  /// No description provided for @adminListMenuScreenReorder.
  ///
  /// In en, this message translates to:
  /// **'Reorder'**
  String get adminListMenuScreenReorder;

  /// No description provided for @adminListMenuScreenCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminListMenuScreenCancel;

  /// No description provided for @adminListMenuScreenEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get adminListMenuScreenEdit;

  /// No description provided for @adminListMenuScreenSaveOrder.
  ///
  /// In en, this message translates to:
  /// **'Save Order'**
  String get adminListMenuScreenSaveOrder;

  /// No description provided for @adminListMenuScreenSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get adminListMenuScreenSelectAll;

  /// No description provided for @adminListMenuScreenTotalMenus.
  ///
  /// In en, this message translates to:
  /// **'Total Menus'**
  String get adminListMenuScreenTotalMenus;

  /// No description provided for @adminListMenuScreenActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminListMenuScreenActive;

  /// No description provided for @adminListMenuScreenInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get adminListMenuScreenInactive;

  /// No description provided for @adminListMenuScreenAveragePrice.
  ///
  /// In en, this message translates to:
  /// **'Average Price'**
  String get adminListMenuScreenAveragePrice;

  /// No description provided for @adminListMenuScreenFiltersSearch.
  ///
  /// In en, this message translates to:
  /// **'Filters & Search'**
  String get adminListMenuScreenFiltersSearch;

  /// No description provided for @adminListMenuScreenShowFilters.
  ///
  /// In en, this message translates to:
  /// **'Show Filters'**
  String get adminListMenuScreenShowFilters;

  /// No description provided for @adminListMenuScreenHideFilters.
  ///
  /// In en, this message translates to:
  /// **'Hide Filters'**
  String get adminListMenuScreenHideFilters;

  /// No description provided for @adminListMenuScreenStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminListMenuScreenStatus;

  /// No description provided for @adminListMenuScreenAllStatuses.
  ///
  /// In en, this message translates to:
  /// **'All Statuses'**
  String get adminListMenuScreenAllStatuses;

  /// No description provided for @adminListMenuScreenMinPriceRange.
  ///
  /// In en, this message translates to:
  /// **'Min Price Range'**
  String get adminListMenuScreenMinPriceRange;

  /// No description provided for @adminListMenuScreenMaxPriceRange.
  ///
  /// In en, this message translates to:
  /// **'Max Price Range'**
  String get adminListMenuScreenMaxPriceRange;

  /// No description provided for @adminListMenuScreenSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get adminListMenuScreenSearch;

  /// No description provided for @adminListMenuScreenSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search for menu name...'**
  String get adminListMenuScreenSearchPlaceholder;

  /// No description provided for @adminListMenuScreenItemsSelected.
  ///
  /// In en, this message translates to:
  /// **'{count} item(s) selected'**
  String adminListMenuScreenItemsSelected(String count);

  /// No description provided for @adminListMenuScreenMenuList.
  ///
  /// In en, this message translates to:
  /// **'Menu List'**
  String get adminListMenuScreenMenuList;

  /// No description provided for @adminListMenuScreenThMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get adminListMenuScreenThMenu;

  /// No description provided for @adminListMenuScreenThPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get adminListMenuScreenThPrice;

  /// No description provided for @adminListMenuScreenThTimeRequired.
  ///
  /// In en, this message translates to:
  /// **'Time Required'**
  String get adminListMenuScreenThTimeRequired;

  /// No description provided for @adminListMenuScreenThOrder.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get adminListMenuScreenThOrder;

  /// No description provided for @adminListMenuScreenThStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminListMenuScreenThStatus;

  /// No description provided for @adminListMenuScreenThActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get adminListMenuScreenThActions;

  /// No description provided for @adminListMenuScreenTimeUnitMinutes.
  ///
  /// In en, this message translates to:
  /// **'mins'**
  String get adminListMenuScreenTimeUnitMinutes;

  /// No description provided for @adminListMenuScreenViewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get adminListMenuScreenViewDetails;

  /// No description provided for @adminListMenuScreenNoMenusTitle.
  ///
  /// In en, this message translates to:
  /// **'No menus yet'**
  String get adminListMenuScreenNoMenusTitle;

  /// No description provided for @adminListMenuScreenNoMenusDescription.
  ///
  /// In en, this message translates to:
  /// **'No menus have been created, or none match the applied filters.'**
  String get adminListMenuScreenNoMenusDescription;

  /// No description provided for @adminListMenuScreenConfirmDeletionTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get adminListMenuScreenConfirmDeletionTitle;

  /// No description provided for @adminListMenuScreenDeleteSingleConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this menu?'**
  String get adminListMenuScreenDeleteSingleConfirm;

  /// No description provided for @adminListMenuScreenDeleteMultipleConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {count} menu(s)?'**
  String adminListMenuScreenDeleteMultipleConfirm(String count);

  /// No description provided for @adminListMenuScreenReorderTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Menu Order'**
  String get adminListMenuScreenReorderTitle;

  /// No description provided for @adminListMenuScreenReorderDescription.
  ///
  /// In en, this message translates to:
  /// **'Drag and drop items to change the order. Click and hold the grip icon to move an item.'**
  String get adminListMenuScreenReorderDescription;

  /// No description provided for @adminListMenuScreenCurrentOrder.
  ///
  /// In en, this message translates to:
  /// **'Current order: #{order}'**
  String adminListMenuScreenCurrentOrder(String order);

  /// No description provided for @adminListMenuScreenShowTitle.
  ///
  /// In en, this message translates to:
  /// **'Menu Details'**
  String get adminListMenuScreenShowTitle;

  /// No description provided for @adminListMenuScreenShowSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Detailed information for the menu item: {name}'**
  String adminListMenuScreenShowSubtitle(String name);

  /// No description provided for @adminListMenuScreenShowEditMenuButton.
  ///
  /// In en, this message translates to:
  /// **'Edit Menu'**
  String get adminListMenuScreenShowEditMenuButton;

  /// No description provided for @adminListMenuScreenShowBackToListButton.
  ///
  /// In en, this message translates to:
  /// **'Back to List'**
  String get adminListMenuScreenShowBackToListButton;

  /// No description provided for @adminListMenuScreenShowStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active Menu'**
  String get adminListMenuScreenShowStatusActive;

  /// No description provided for @adminListMenuScreenShowStatusInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive Menu'**
  String get adminListMenuScreenShowStatusInactive;

  /// No description provided for @adminListMenuScreenShowActivateMenu.
  ///
  /// In en, this message translates to:
  /// **'Activate Menu'**
  String get adminListMenuScreenShowActivateMenu;

  /// No description provided for @adminListMenuScreenShowDeactivateMenu.
  ///
  /// In en, this message translates to:
  /// **'Deactivate Menu'**
  String get adminListMenuScreenShowDeactivateMenu;

  /// No description provided for @adminListMenuScreenShowDeleteMenuButton.
  ///
  /// In en, this message translates to:
  /// **'Delete Menu'**
  String get adminListMenuScreenShowDeleteMenuButton;

  /// No description provided for @adminListMenuScreenShowInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Menu Information'**
  String get adminListMenuScreenShowInfoTitle;

  /// No description provided for @adminListMenuScreenShowInfoName.
  ///
  /// In en, this message translates to:
  /// **'Menu Name'**
  String get adminListMenuScreenShowInfoName;

  /// No description provided for @adminListMenuScreenShowInfoPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get adminListMenuScreenShowInfoPrice;

  /// No description provided for @adminListMenuScreenShowInfoTime.
  ///
  /// In en, this message translates to:
  /// **'Required Time'**
  String get adminListMenuScreenShowInfoTime;

  /// No description provided for @adminListMenuScreenShowInfoOrder.
  ///
  /// In en, this message translates to:
  /// **'Display Order'**
  String get adminListMenuScreenShowInfoOrder;

  /// No description provided for @adminListMenuScreenShowInfoColor.
  ///
  /// In en, this message translates to:
  /// **'Menu Color'**
  String get adminListMenuScreenShowInfoColor;

  /// No description provided for @adminListMenuScreenShowInfoCreatedAt.
  ///
  /// In en, this message translates to:
  /// **'Date Created'**
  String get adminListMenuScreenShowInfoCreatedAt;

  /// No description provided for @adminListMenuScreenShowInfoUpdatedAt.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get adminListMenuScreenShowInfoUpdatedAt;

  /// No description provided for @adminListMenuScreenShowDescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Menu Description'**
  String get adminListMenuScreenShowDescriptionTitle;

  /// No description provided for @adminListMenuScreenShowDeleteModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Menu Deletion'**
  String get adminListMenuScreenShowDeleteModalTitle;

  /// No description provided for @adminListMenuScreenShowDeleteModalText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the menu \"{name}\"? This action cannot be undone.'**
  String adminListMenuScreenShowDeleteModalText(String name);

  /// No description provided for @adminListMenuScreenShowDeletingText.
  ///
  /// In en, this message translates to:
  /// **'Deleting...'**
  String get adminListMenuScreenShowDeletingText;

  /// No description provided for @adminListMenuScreenJsMessagesSelectAtLeastOne.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one menu.'**
  String get adminListMenuScreenJsMessagesSelectAtLeastOne;

  /// No description provided for @adminListMenuScreenJsMessagesErrorOccurredStatus.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while changing the status.'**
  String get adminListMenuScreenJsMessagesErrorOccurredStatus;

  /// No description provided for @adminListMenuScreenJsMessagesErrorOccurredDelete.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while deleting.'**
  String get adminListMenuScreenJsMessagesErrorOccurredDelete;

  /// No description provided for @adminListMenuScreenJsMessagesErrorOccurredReorder.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while saving the order.'**
  String get adminListMenuScreenJsMessagesErrorOccurredReorder;

  /// No description provided for @adminListMenuScreenJsMessagesDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Menu successfully deleted!'**
  String get adminListMenuScreenJsMessagesDeleteSuccess;

  /// No description provided for @adminListMenuScreenJsMessagesDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete the menu.'**
  String get adminListMenuScreenJsMessagesDeleteFailed;

  /// No description provided for @adminListMenuScreenJsMessagesDeletingText.
  ///
  /// In en, this message translates to:
  /// **'Deleting...'**
  String get adminListMenuScreenJsMessagesDeletingText;

  /// No description provided for @adminListMenuScreenJsMessagesConfirmDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Menu Deletion'**
  String get adminListMenuScreenJsMessagesConfirmDeleteTitle;

  /// No description provided for @adminListMenuScreenJsMessagesConfirmDeleteText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the menu \"{name}\"? This action cannot be undone.'**
  String adminListMenuScreenJsMessagesConfirmDeleteText(String name);

  /// No description provided for @adminListMenuScreenJsMessagesSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get adminListMenuScreenJsMessagesSuccessTitle;

  /// No description provided for @adminListMenuScreenJsMessagesErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'An Error Occurred'**
  String get adminListMenuScreenJsMessagesErrorTitle;

  /// No description provided for @adminListMenuScreenJsMessagesClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get adminListMenuScreenJsMessagesClose;

  /// No description provided for @adminListMenuScreenJsMessagesOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get adminListMenuScreenJsMessagesOk;

  /// No description provided for @adminUpsertMenuScreenAddSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create a new service menu for customers'**
  String get adminUpsertMenuScreenAddSubtitle;

  /// No description provided for @adminUpsertMenuScreenEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Menu'**
  String get adminUpsertMenuScreenEditTitle;

  /// No description provided for @adminUpsertMenuScreenEditSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update menu information'**
  String get adminUpsertMenuScreenEditSubtitle;

  /// No description provided for @adminUpsertMenuScreenViewMenu.
  ///
  /// In en, this message translates to:
  /// **'View Menu'**
  String get adminUpsertMenuScreenViewMenu;

  /// No description provided for @adminUpsertMenuScreenBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get adminUpsertMenuScreenBack;

  /// No description provided for @adminUpsertMenuScreenSaveMenu.
  ///
  /// In en, this message translates to:
  /// **'Save Menu'**
  String get adminUpsertMenuScreenSaveMenu;

  /// No description provided for @adminUpsertMenuScreenUpdateMenu.
  ///
  /// In en, this message translates to:
  /// **'Update Menu'**
  String get adminUpsertMenuScreenUpdateMenu;

  /// No description provided for @adminUpsertMenuScreenEnglishInfo.
  ///
  /// In en, this message translates to:
  /// **'English Information'**
  String get adminUpsertMenuScreenEnglishInfo;

  /// No description provided for @adminUpsertMenuScreenJapaneseInfo.
  ///
  /// In en, this message translates to:
  /// **'Japanese Information'**
  String get adminUpsertMenuScreenJapaneseInfo;

  /// No description provided for @adminUpsertMenuScreenMenuNameEn.
  ///
  /// In en, this message translates to:
  /// **'Menu Name (English)'**
  String get adminUpsertMenuScreenMenuNameEn;

  /// No description provided for @adminUpsertMenuScreenDescriptionEn.
  ///
  /// In en, this message translates to:
  /// **'Description (English)'**
  String get adminUpsertMenuScreenDescriptionEn;

  /// No description provided for @adminUpsertMenuScreenMenuNameJa.
  ///
  /// In en, this message translates to:
  /// **'Menu Name (Japanese)'**
  String get adminUpsertMenuScreenMenuNameJa;

  /// No description provided for @adminUpsertMenuScreenDescriptionJa.
  ///
  /// In en, this message translates to:
  /// **'Description (Japanese)'**
  String get adminUpsertMenuScreenDescriptionJa;

  /// No description provided for @adminUpsertMenuScreenPlaceholderNameEn.
  ///
  /// In en, this message translates to:
  /// **'Enter menu name in English'**
  String get adminUpsertMenuScreenPlaceholderNameEn;

  /// No description provided for @adminUpsertMenuScreenPlaceholderDescEn.
  ///
  /// In en, this message translates to:
  /// **'Enter menu description in English...'**
  String get adminUpsertMenuScreenPlaceholderDescEn;

  /// No description provided for @adminUpsertMenuScreenPlaceholderNameJa.
  ///
  /// In en, this message translates to:
  /// **'Enter menu name in Japanese'**
  String get adminUpsertMenuScreenPlaceholderNameJa;

  /// No description provided for @adminUpsertMenuScreenPlaceholderDescJa.
  ///
  /// In en, this message translates to:
  /// **'Enter menu description in Japanese...'**
  String get adminUpsertMenuScreenPlaceholderDescJa;

  /// No description provided for @adminUpsertMenuScreenBasicSettings.
  ///
  /// In en, this message translates to:
  /// **'Basic Settings'**
  String get adminUpsertMenuScreenBasicSettings;

  /// No description provided for @adminUpsertMenuScreenFormRequiredTime.
  ///
  /// In en, this message translates to:
  /// **'Required Time (minutes)'**
  String get adminUpsertMenuScreenFormRequiredTime;

  /// No description provided for @adminUpsertMenuScreenHelpRequiredTime.
  ///
  /// In en, this message translates to:
  /// **'Estimated processing time in minutes'**
  String get adminUpsertMenuScreenHelpRequiredTime;

  /// No description provided for @adminUpsertMenuScreenFormPrice.
  ///
  /// In en, this message translates to:
  /// **'Price (\$)'**
  String get adminUpsertMenuScreenFormPrice;

  /// No description provided for @adminUpsertMenuScreenVisualSettings.
  ///
  /// In en, this message translates to:
  /// **'Visual Settings'**
  String get adminUpsertMenuScreenVisualSettings;

  /// No description provided for @adminUpsertMenuScreenHelpColor.
  ///
  /// In en, this message translates to:
  /// **'This color will be used for the menu display'**
  String get adminUpsertMenuScreenHelpColor;

  /// No description provided for @adminUpsertMenuScreenStatusSettings.
  ///
  /// In en, this message translates to:
  /// **'Status Settings'**
  String get adminUpsertMenuScreenStatusSettings;

  /// No description provided for @adminUpsertMenuScreenFormActiveStatus.
  ///
  /// In en, this message translates to:
  /// **'Active Status'**
  String get adminUpsertMenuScreenFormActiveStatus;

  /// No description provided for @adminUpsertMenuScreenHelpActiveStatus.
  ///
  /// In en, this message translates to:
  /// **'Menu will be available for customers'**
  String get adminUpsertMenuScreenHelpActiveStatus;

  /// No description provided for @adminUpsertMenuScreenMenuPreview.
  ///
  /// In en, this message translates to:
  /// **'Menu Preview'**
  String get adminUpsertMenuScreenMenuPreview;

  /// No description provided for @adminUpsertMenuScreenEnglishPreview.
  ///
  /// In en, this message translates to:
  /// **'English Preview'**
  String get adminUpsertMenuScreenEnglishPreview;

  /// No description provided for @adminUpsertMenuScreenJapanesePreview.
  ///
  /// In en, this message translates to:
  /// **'Japanese Preview'**
  String get adminUpsertMenuScreenJapanesePreview;

  /// No description provided for @adminUpsertMenuScreenTimeUnitMinutesFull.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get adminUpsertMenuScreenTimeUnitMinutesFull;

  /// No description provided for @adminUpsertMenuScreenNoDescription.
  ///
  /// In en, this message translates to:
  /// **'No description available'**
  String get adminUpsertMenuScreenNoDescription;

  /// No description provided for @adminUpsertMenuScreenCurrentInfo.
  ///
  /// In en, this message translates to:
  /// **'Current Menu Information'**
  String get adminUpsertMenuScreenCurrentInfo;

  /// No description provided for @adminUpsertMenuScreenColorsBlue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get adminUpsertMenuScreenColorsBlue;

  /// No description provided for @adminUpsertMenuScreenColorsGreen.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get adminUpsertMenuScreenColorsGreen;

  /// No description provided for @adminUpsertMenuScreenColorsYellow.
  ///
  /// In en, this message translates to:
  /// **'Yellow'**
  String get adminUpsertMenuScreenColorsYellow;

  /// No description provided for @adminUpsertMenuScreenColorsRed.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get adminUpsertMenuScreenColorsRed;

  /// No description provided for @adminUpsertMenuScreenColorsPurple.
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get adminUpsertMenuScreenColorsPurple;

  /// No description provided for @adminUpsertMenuScreenColorsPink.
  ///
  /// In en, this message translates to:
  /// **'Pink'**
  String get adminUpsertMenuScreenColorsPink;

  /// No description provided for @adminUpsertMenuScreenColorsCyan.
  ///
  /// In en, this message translates to:
  /// **'Cyan'**
  String get adminUpsertMenuScreenColorsCyan;

  /// No description provided for @adminUpsertMenuScreenColorsLime.
  ///
  /// In en, this message translates to:
  /// **'Lime'**
  String get adminUpsertMenuScreenColorsLime;

  /// No description provided for @adminUpsertMenuScreenColorsOrange.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get adminUpsertMenuScreenColorsOrange;

  /// No description provided for @adminUpsertMenuScreenColorsGray.
  ///
  /// In en, this message translates to:
  /// **'Gray'**
  String get adminUpsertMenuScreenColorsGray;

  /// No description provided for @profileShowTitle.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profileShowTitle;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEditTitle;

  /// No description provided for @profileSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileSuccessMessage;

  /// No description provided for @profilePersonalInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get profilePersonalInfoTitle;

  /// No description provided for @profileLabelFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get profileLabelFullName;

  /// No description provided for @profileLabelFullNameKana.
  ///
  /// In en, this message translates to:
  /// **'Full Name (Kana)'**
  String get profileLabelFullNameKana;

  /// No description provided for @profileLabelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get profileLabelEmail;

  /// No description provided for @profileLabelPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get profileLabelPhone;

  /// No description provided for @profileLabelCompany.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get profileLabelCompany;

  /// No description provided for @profileLabelDob.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get profileLabelDob;

  /// No description provided for @profileLabelAddress.
  ///
  /// In en, this message translates to:
  /// **'Home Address'**
  String get profileLabelAddress;

  /// No description provided for @profileChangePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get profileChangePasswordTitle;

  /// No description provided for @profileLabelCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get profileLabelCurrentPassword;

  /// No description provided for @profileLabelNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get profileLabelNewPassword;

  /// No description provided for @profileLabelConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get profileLabelConfirmPassword;

  /// No description provided for @profileButtonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileButtonEdit;

  /// No description provided for @profileButtonUpdateProfile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get profileButtonUpdateProfile;

  /// No description provided for @profileButtonChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get profileButtonChangePassword;

  /// No description provided for @profileButtonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profileButtonCancel;

  /// No description provided for @profileButtonSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get profileButtonSaveChanges;

  /// No description provided for @createReservationNotesTitle.
  ///
  /// In en, this message translates to:
  /// **'Reservation Notes'**
  String get createReservationNotesTitle;

  /// No description provided for @createReservationNotesContent1.
  ///
  /// In en, this message translates to:
  /// **'The work time is an approximate guide'**
  String get createReservationNotesContent1;

  /// No description provided for @createReservationNotesContent2.
  ///
  /// In en, this message translates to:
  /// **'Please note that it may take some time depending on the work content'**
  String get createReservationNotesContent2;

  /// No description provided for @createReservationNotesContent3.
  ///
  /// In en, this message translates to:
  /// **'Reservation deadline: Until 23:59 one day before'**
  String get createReservationNotesContent3;

  /// No description provided for @createReservationNotesContent4.
  ///
  /// In en, this message translates to:
  /// **'Cancellation not allowed after confirmation'**
  String get createReservationNotesContent4;

  /// No description provided for @confirmReservationBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Information'**
  String get confirmReservationBannerTitle;

  /// No description provided for @confirmReservationBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please choose how you would like to proceed with your reservation.'**
  String get confirmReservationBannerSubtitle;

  /// No description provided for @confirmReservationWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name}!'**
  String confirmReservationWelcomeBack(String name);

  /// No description provided for @confirmReservationLoggedInAs.
  ///
  /// In en, this message translates to:
  /// **'You are logged in as a RESERVA member.'**
  String get confirmReservationLoggedInAs;

  /// No description provided for @confirmReservationInfoUsageWarning.
  ///
  /// In en, this message translates to:
  /// **'Your member information will be used for this reservation.'**
  String get confirmReservationInfoUsageWarning;

  /// No description provided for @confirmReservationContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue with This Account'**
  String get confirmReservationContinueButton;

  /// No description provided for @reservationSummaryBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Final Confirmation'**
  String get reservationSummaryBannerTitle;

  /// No description provided for @reservationSummaryBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please review your reservation details carefully before completing the booking.'**
  String get reservationSummaryBannerSubtitle;

  /// No description provided for @reservationSummaryServiceDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Details'**
  String get reservationSummaryServiceDetailsTitle;

  /// No description provided for @reservationSummaryCustomerInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Information'**
  String get reservationSummaryCustomerInfoTitle;

  /// No description provided for @reservationSummaryLabelService.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get reservationSummaryLabelService;

  /// No description provided for @reservationSummaryLabelDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get reservationSummaryLabelDuration;

  /// No description provided for @reservationSummaryLabelDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get reservationSummaryLabelDate;

  /// No description provided for @reservationSummaryLabelTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get reservationSummaryLabelTime;

  /// No description provided for @reservationSummaryLabelName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get reservationSummaryLabelName;

  /// No description provided for @reservationSummaryLabelNameKana.
  ///
  /// In en, this message translates to:
  /// **'Name (Kana)'**
  String get reservationSummaryLabelNameKana;

  /// No description provided for @reservationSummaryLabelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get reservationSummaryLabelEmail;

  /// No description provided for @reservationSummaryLabelPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get reservationSummaryLabelPhone;

  /// No description provided for @reservationSummaryLabelStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get reservationSummaryLabelStatus;

  /// No description provided for @reservationSummaryNotesTitle.
  ///
  /// In en, this message translates to:
  /// **'Important Notes'**
  String get reservationSummaryNotesTitle;

  /// No description provided for @reservationSummaryNotesContent1.
  ///
  /// In en, this message translates to:
  /// **'Please arrive 5 minutes before your scheduled time.'**
  String get reservationSummaryNotesContent1;

  /// No description provided for @reservationSummaryNotesContent2.
  ///
  /// In en, this message translates to:
  /// **'Cancellation is not allowed after confirmation.'**
  String get reservationSummaryNotesContent2;

  /// No description provided for @reservationSummaryNotesContent3.
  ///
  /// In en, this message translates to:
  /// **'Changes to the reservation must be made at least 24 hours in advance.'**
  String get reservationSummaryNotesContent3;

  /// No description provided for @reservationSummaryNotesContent4.
  ///
  /// In en, this message translates to:
  /// **'Please bring a valid ID for verification if necessary.'**
  String get reservationSummaryNotesContent4;

  /// No description provided for @reservationSummaryTermsAndCondition.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms and Conditions '**
  String get reservationSummaryTermsAndCondition;

  /// No description provided for @reservationSummaryPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'and Privacy Policy'**
  String get reservationSummaryPrivacyPolicy;

  /// No description provided for @confirmedReservationBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed!'**
  String get confirmedReservationBannerTitle;

  /// No description provided for @confirmedReservationBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your reservation has been successfully submitted.'**
  String get confirmedReservationBannerSubtitle;

  /// No description provided for @confirmedReservationYourReservationNumber.
  ///
  /// In en, this message translates to:
  /// **'Your Reservation Number'**
  String get confirmedReservationYourReservationNumber;

  /// No description provided for @confirmedReservationWhatsNextTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s Next?'**
  String get confirmedReservationWhatsNextTitle;

  /// No description provided for @confirmedReservationWhatsNext1.
  ///
  /// In en, this message translates to:
  /// **'A confirmation email has been sent to your email address.'**
  String get confirmedReservationWhatsNext1;

  /// No description provided for @confirmedReservationWhatsNext2.
  ///
  /// In en, this message translates to:
  /// **'Please arrive 5 minutes before your scheduled time.'**
  String get confirmedReservationWhatsNext2;

  /// No description provided for @confirmedReservationWhatsNext3.
  ///
  /// In en, this message translates to:
  /// **'Bring a valid ID for verification.'**
  String get confirmedReservationWhatsNext3;

  /// No description provided for @confirmedReservationWhatsNext4.
  ///
  /// In en, this message translates to:
  /// **'Contact us if you need to make any changes.'**
  String get confirmedReservationWhatsNext4;

  /// No description provided for @confirmedReservationViewMyReservationsButton.
  ///
  /// In en, this message translates to:
  /// **'View My Reservations'**
  String get confirmedReservationViewMyReservationsButton;

  /// No description provided for @confirmedReservationBackToHomeButton.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get confirmedReservationBackToHomeButton;

  /// No description provided for @menuBookButton.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get menuBookButton;

  /// No description provided for @menuUnavailableStatus.
  ///
  /// In en, this message translates to:
  /// **'Currently Unavailable'**
  String get menuUnavailableStatus;

  /// No description provided for @timeHour.
  ///
  /// In en, this message translates to:
  /// **'hour'**
  String get timeHour;

  /// No description provided for @timeHours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get timeHours;

  /// No description provided for @timeMinute.
  ///
  /// In en, this message translates to:
  /// **'minute'**
  String get timeMinute;

  /// No description provided for @timeMinutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get timeMinutes;

  /// No description provided for @reservationStatusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get reservationStatusConfirmed;

  /// No description provided for @reservationStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get reservationStatusPending;

  /// No description provided for @reservationStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get reservationStatusCompleted;

  /// No description provided for @reservationStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get reservationStatusCancelled;

  /// No description provided for @reservationItemLabelDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get reservationItemLabelDate;

  /// No description provided for @reservationItemLabelTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get reservationItemLabelTime;

  /// No description provided for @reservationItemLabelPeople.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get reservationItemLabelPeople;

  /// No description provided for @reservationItemLabelNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get reservationItemLabelNotes;

  /// No description provided for @reservationItemPeopleUnit.
  ///
  /// In en, this message translates to:
  /// **'people'**
  String get reservationItemPeopleUnit;

  /// No description provided for @reservationItemCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel Reservation'**
  String get reservationItemCancelButton;

  /// No description provided for @dateToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dateToday;

  /// No description provided for @dateTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get dateTomorrow;

  /// No description provided for @myReservationMainTitle.
  ///
  /// In en, this message translates to:
  /// **'My Reservations'**
  String get myReservationMainTitle;

  /// No description provided for @myReservationMainSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage and view all your reservations in one place.'**
  String get myReservationMainSubTitle;

  /// No description provided for @myReservationPageTitle.
  ///
  /// In en, this message translates to:
  /// **'My Reservations'**
  String get myReservationPageTitle;

  /// No description provided for @myReservationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage and view all your reservations in one place.'**
  String get myReservationSubtitle;

  /// No description provided for @myReservationTotalReservations.
  ///
  /// In en, this message translates to:
  /// **'Total Reservations'**
  String get myReservationTotalReservations;

  /// No description provided for @myReservationPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get myReservationPending;

  /// No description provided for @myReservationConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get myReservationConfirmed;

  /// No description provided for @myReservationNewReservation.
  ///
  /// In en, this message translates to:
  /// **'New Reservation'**
  String get myReservationNewReservation;

  /// No description provided for @myReservationRequiredTime.
  ///
  /// In en, this message translates to:
  /// **':time minutes'**
  String get myReservationRequiredTime;

  /// No description provided for @myReservationDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get myReservationDate;

  /// No description provided for @myReservationTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get myReservationTime;

  /// No description provided for @myReservationPeopleLabel.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get myReservationPeopleLabel;

  /// No description provided for @myReservationPeopleCount.
  ///
  /// In en, this message translates to:
  /// **':count people'**
  String get myReservationPeopleCount;

  /// No description provided for @myReservationNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes:'**
  String get myReservationNotes;

  /// No description provided for @myReservationCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get myReservationCancelButton;

  /// No description provided for @myReservationNoReservationsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Reservations Yet'**
  String get myReservationNoReservationsTitle;

  /// No description provided for @myReservationNoReservationsBody.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t made any reservations yet. Start by creating your first reservation and enjoy our services.'**
  String get myReservationNoReservationsBody;

  /// No description provided for @myReservationCreateFirstReservation.
  ///
  /// In en, this message translates to:
  /// **'Create First Reservation'**
  String get myReservationCreateFirstReservation;

  /// No description provided for @myReservationModalCancelTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel Reservation'**
  String get myReservationModalCancelTitle;

  /// No description provided for @myReservationModalCancelBody.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this reservation? This action cannot be undone.'**
  String get myReservationModalCancelBody;

  /// No description provided for @myReservationModalKeepButton.
  ///
  /// In en, this message translates to:
  /// **'Keep Reservation'**
  String get myReservationModalKeepButton;

  /// No description provided for @myReservationModalConfirmCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Yes, Cancel'**
  String get myReservationModalConfirmCancelButton;

  /// No description provided for @myReservationModalFeatureSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Feature Coming Soon'**
  String get myReservationModalFeatureSoonTitle;

  /// No description provided for @myReservationModalFeatureSoonBody.
  ///
  /// In en, this message translates to:
  /// **'Reservation cancellation feature will be implemented soon.'**
  String get myReservationModalFeatureSoonBody;

  /// No description provided for @myReservationModalGotItButton.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get myReservationModalGotItButton;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Tire Installation Reservation'**
  String get appName;

  /// No description provided for @appBarCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get appBarCalendar;

  /// No description provided for @appBarInquiry.
  ///
  /// In en, this message translates to:
  /// **'Inquiry'**
  String get appBarInquiry;

  /// No description provided for @appBarLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get appBarLogin;

  /// No description provided for @appBarReservations.
  ///
  /// In en, this message translates to:
  /// **'Reservations'**
  String get appBarReservations;

  /// No description provided for @appBarProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get appBarProfile;

  /// No description provided for @appBarLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get appBarLogout;

  /// No description provided for @appBarHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get appBarHome;

  /// No description provided for @appBarCreateReservation.
  ///
  /// In en, this message translates to:
  /// **'Create Reservation'**
  String get appBarCreateReservation;

  /// No description provided for @appBarConfirmReservation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Reservation'**
  String get appBarConfirmReservation;

  /// No description provided for @appBarConfirmedReservation.
  ///
  /// In en, this message translates to:
  /// **'Confirmed Reservation'**
  String get appBarConfirmedReservation;

  /// No description provided for @appBarMyReservations.
  ///
  /// In en, this message translates to:
  /// **'My Reservations'**
  String get appBarMyReservations;

  /// No description provided for @appBarReservationSummary.
  ///
  /// In en, this message translates to:
  /// **'Reservation Summary'**
  String get appBarReservationSummary;

  /// No description provided for @appBarRegister.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get appBarRegister;

  /// No description provided for @userBottomNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get userBottomNavHome;

  /// No description provided for @userBottomNavReservations.
  ///
  /// In en, this message translates to:
  /// **'Reservations'**
  String get userBottomNavReservations;

  /// No description provided for @userBottomNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get userBottomNavProfile;

  /// No description provided for @drawerHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Main Menu'**
  String get drawerHeaderTitle;

  /// No description provided for @adminDrawerHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Menu'**
  String get adminDrawerHeaderTitle;

  /// No description provided for @drawerGuestUser.
  ///
  /// In en, this message translates to:
  /// **'Guest User'**
  String get drawerGuestUser;

  /// No description provided for @drawerGuestLoginPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please login to continue'**
  String get drawerGuestLoginPrompt;

  /// No description provided for @drawerItemLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get drawerItemLanguage;

  /// No description provided for @drawerActionLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get drawerActionLogin;

  /// No description provided for @drawerActionLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get drawerActionLogout;

  /// No description provided for @drawerLogoutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout Confirmation'**
  String get drawerLogoutDialogTitle;

  /// No description provided for @drawerLogoutDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get drawerLogoutDialogContent;

  /// No description provided for @drawerActionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get drawerActionCancel;

  /// No description provided for @drawerItemInquiry.
  ///
  /// In en, this message translates to:
  /// **'Inquiry'**
  String get drawerItemInquiry;

  /// No description provided for @dialogTitleSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get dialogTitleSelectLanguage;

  /// No description provided for @adminBottomNavDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get adminBottomNavDashboard;

  /// No description provided for @adminBottomNavCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get adminBottomNavCalendar;

  /// No description provided for @adminBottomNavAnnouncements.
  ///
  /// In en, this message translates to:
  /// **'Announcements'**
  String get adminBottomNavAnnouncements;

  /// No description provided for @adminDrawerItemAvailability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get adminDrawerItemAvailability;

  /// No description provided for @adminDrawerItemBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked Management'**
  String get adminDrawerItemBlocked;

  /// No description provided for @adminDrawerItemBusinessInformation.
  ///
  /// In en, this message translates to:
  /// **'Business Info'**
  String get adminDrawerItemBusinessInformation;

  /// No description provided for @adminDrawerItemContact.
  ///
  /// In en, this message translates to:
  /// **'Contact Management'**
  String get adminDrawerItemContact;

  /// No description provided for @adminDrawerItemCustomerManagement.
  ///
  /// In en, this message translates to:
  /// **'Customer Management'**
  String get adminDrawerItemCustomerManagement;

  /// No description provided for @adminDrawerItemMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu Management'**
  String get adminDrawerItemMenu;

  /// No description provided for @pressAgainToExit.
  ///
  /// In en, this message translates to:
  /// **'Press Again To Exit'**
  String get pressAgainToExit;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10nEn();
    case 'id':
      return L10nId();
    case 'ja':
      return L10nJa();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
