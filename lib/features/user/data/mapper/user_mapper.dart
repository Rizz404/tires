// import 'package:tires/features/user/data/models/user_model.dart';
// import 'package:tires/features/user/domain/entities/user.dart';

// extension UserMapper on UserModel {
//   User toEntity() {
//     UserRole mapRole(String role) {
//       switch (role.toLowerCase()) {
//         case 'admin':
//           return UserRole.admin;
//         case 'customer':
//         default:
//           return UserRole.customer;
//       }
//     }

//     UserGender mapGender(String gender) {
//       switch (gender.toLowerCase()) {
//         case 'male':
//           return UserGender.male;
//         case 'female':
//           return UserGender.female;
//         default:
//           return UserGender.other;
//       }
//     }

//     return User(
//       id: id,
//       email: email,
//       emailVerifiedAt: emailVerifiedAt != null,
//       password:
//           '', // Password tidak pernah datang dari API response, jadi dikosongkan.
//       fullName: fullName,
//       fullNameKana: fullNameKana,
//       phoneNumber: phoneNumber,
//       companyName: companyName,
//       department: department,
//       companyAddress: companyAddress,
//       homeAddress: homeAddress,
//       dateOfBirth: dateOfBirth != null ? DateTime.parse(dateOfBirth!) : null,
//       role: mapRole(role),
//       gender: mapGender(gender),
//       createdAt: DateTime.parse(createdAt),
//       updatedAt: DateTime.parse(updatedAt),
//       // Asumsikan mapper untuk nested object sudah ada
//       passwordResetToken: passwordResetToken!.toEntity(),
//       session: session!.toEntity(),
//     );
//   }
// }

// extension UserEntityMapper on User {
//   UserModel toModel() {
//     return UserModel(
//       id: id,
//       email: email,
//       fullName: fullName,
//       fullNameKana: fullNameKana,
//       phoneNumber: phoneNumber,
//       companyName: companyName,
//       department: department,
//       companyAddress: companyAddress,
//       homeAddress: homeAddress,
//       dateOfBirth: dateOfBirth?.toIso8601String(),
//       role: role.name,
//       gender: gender.name,
//       // Properti yang di-manage server seperti createdAt, updatedAt, emailVerifiedAt
//       // dan password tidak perlu dikirim kembali dalam format model umum.
//       // Ini bisa di-handle di payload request spesifik (misal: UpdateProfilePayload)
//       createdAt: createdAt.toIso8601String(),
//       updatedAt: updatedAt.toIso8601String(),
//       passwordResetToken: passwordResetToken.toModel(),
//       session: session.toModel(),
//     );
//   }
// }
