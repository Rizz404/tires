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
