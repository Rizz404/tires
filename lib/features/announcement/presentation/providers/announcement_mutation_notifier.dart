// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tires/features/announcement/domain/usecases/delete-announcement_account_usecase.dart';
// import 'package:tires/features/announcement/domain/usecases/update-announcement_password_usecase.dart';
// import 'package:tires/features/announcement/domain/usecases/update-announcement_usecase.dart';
// import 'package:tires/features/announcement/presentation/providers/announcement_mutation_state.dart';
// import 'package:tires/features/announcement/presentation/providers/current_announcement_mutation_state.dart';

// class AnnouncementMutationNotifier
//     extends StateNotifier<AnnouncementMutationState> {
//   final UpdateAnnouncementUsecase _updateAnnouncementUsecase;
//   final UpdateAnnouncementPasswordUsecase _updateAnnouncementPasswordUsecase;
//   final DeleteAnnouncementAccountUsecase _deleteAnnouncementAccountUsecase;

//   AnnouncementMutationNotifier(
//     this._updateAnnouncementUsecase,
//     this._updateAnnouncementPasswordUsecase,
//     this._deleteAnnouncementAccountUsecase,
//   ) : super(const AnnouncementMutationState());

//   Future<void> updateAnnouncement({
//     required String fullName,
//     required String fullNameKana,
//     required String email,
//     required String phoneNumber,
//     String? companyName,
//     String? department,
//     String? companyAddress,
//     String? homeAddress,
//     DateTime? dateOfBirth,
//     String? gender,
//   }) async {
//     state = state.copyWith(status: AnnouncementMutationStatus.loading);

//     final params = UpdateAnnouncementParams(
//       fullName: fullName,
//       fullNameKana: fullNameKana,
//       email: email,
//       phoneNumber: phoneNumber,
//       companyName: companyName,
//       department: department,
//       companyAddress: companyAddress,
//       homeAddress: homeAddress,
//       dateOfBirth: dateOfBirth,
//       gender: gender,
//     );

//     final response = await _updateAnnouncementUsecase(params);

//     response.fold(
//       (failure) {
//         state = state.copyWith(
//           status: AnnouncementMutationStatus.error,
//           failure: failure,
//         );
//       },
//       (success) {
//         state = state
//             .copyWith(
//               status: AnnouncementMutationStatus.success,
//               updatedAnnouncement: success.data,
//               successMessage:
//                   success.message ?? 'Announcement updated successfully',
//             )
//             .copyWithClearError();
//       },
//     );
//   }

//   Future<void> updatePassword({
//     required String currentPassword,
//     required String newPassword,
//     required String confirmPassword,
//   }) async {
//     state = state.copyWith(status: AnnouncementMutationStatus.loading);

//     final params = UpdateAnnouncementPasswordParams(
//       currentPassword: currentPassword,
//       newPassword: newPassword,
//       confirmPassword: confirmPassword,
//     );

//     final response = await _updateAnnouncementPasswordUsecase(params);

//     response.fold(
//       (failure) {
//         state = state.copyWith(
//           status: AnnouncementMutationStatus.error,
//           failure: failure,
//         );
//       },
//       (success) {
//         state = state
//             .copyWith(
//               status: AnnouncementMutationStatus.success,
//               successMessage:
//                   success.message ?? 'Password updated successfully',
//             )
//             .copyWithClearError();
//       },
//     );
//   }

//   Future<void> deleteAccount() async {
//     state = state.copyWith(status: AnnouncementMutationStatus.loading);

//     const params = DeleteAnnouncementAccountParams();
//     final response = await _deleteAnnouncementAccountUsecase(params);

//     response.fold(
//       (failure) {
//         state = state.copyWith(
//           status: AnnouncementMutationStatus.error,
//           failure: failure,
//         );
//       },
//       (success) {
//         state = state
//             .copyWith(
//               status: AnnouncementMutationStatus.success,
//               successMessage: success.message ?? 'Account deleted successfully',
//             )
//             .copyWithClearError();
//       },
//     );
//   }

//   void clearState() {
//     state = const AnnouncementMutationState();
//   }

//   void clearError() {
//     if (state.failure != null) {
//       state = state.copyWithClearError();
//     }
//   }

//   void clearSuccess() {
//     if (state.successMessage != null) {
//       state = state.copyWithClearSuccess();
//     }
//   }
// }
