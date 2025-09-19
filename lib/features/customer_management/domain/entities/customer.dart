import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String id;
  final int? userId;
  final String email;
  final String fullName;
  final String fullNameKana;
  final String? phoneNumber;
  final String? companyName;
  final String? department;
  final String? companyAddress;
  final String? homeAddress;
  final String? dateOfBirth;
  final String? gender;
  final int isRegistered;
  final int reservationCount;
  final String? latestReservation;
  final String totalAmount;
  final Translations translations;
  final Meta meta;

  const Customer({
    required this.id,
    this.userId,
    required this.email,
    required this.fullName,
    required this.fullNameKana,
    this.phoneNumber,
    this.companyName,
    this.department,
    this.companyAddress,
    this.homeAddress,
    this.dateOfBirth,
    this.gender,
    required this.isRegistered,
    required this.reservationCount,
    this.latestReservation,
    required this.totalAmount,
    required this.translations,
    required this.meta,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    email,
    fullName,
    fullNameKana,
    phoneNumber,
    companyName,
    department,
    companyAddress,
    homeAddress,
    dateOfBirth,
    gender,
    isRegistered,
    reservationCount,
    latestReservation,
    totalAmount,
    translations,
    meta,
  ];
}

class Translations extends Equatable {
  final LanguageTranslation en;
  final LanguageTranslation ja;

  const Translations({required this.en, required this.ja});

  @override
  List<Object?> get props => [en, ja];
}

class LanguageTranslation extends Equatable {
  final String fullName;
  final String? companyName;

  const LanguageTranslation({required this.fullName, this.companyName});

  @override
  List<Object?> get props => [fullName, companyName];
}

class Meta extends Equatable {
  final String locale;
  final bool fallbackUsed;

  const Meta({required this.locale, required this.fallbackUsed});

  @override
  List<Object?> get props => [locale, fallbackUsed];
}
