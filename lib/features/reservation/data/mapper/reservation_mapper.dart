import 'package:tires/features/menu/data/mapper/menu_mapper.dart';
import 'package:tires/features/menu/data/models/menu_model.dart';
import 'package:tires/features/reservation/data/models/reservation_model.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/entities/reservation_amount.dart';
import 'package:tires/features/reservation/domain/entities/reservation_customer_info.dart';
import 'package:tires/features/reservation/domain/entities/reservation_status.dart';
import 'package:tires/features/reservation/domain/entities/reservation_user.dart';
import 'package:tires/features/reservation/data/models/reservation_amount_model.dart';
import 'package:tires/features/reservation/data/models/reservation_customer_info_model.dart';
import 'package:tires/features/reservation/data/models/reservation_status_model.dart';
import 'package:tires/features/reservation/data/models/reservation_user_model.dart';

extension ReservationModelMapper on ReservationModel {
  Reservation toEntity() {
    return Reservation(
      id: id,
      reservationNumber: reservationNumber,
      user: (user as ReservationUserModel?)?.toEntity(),
      customerInfo: (customerInfo as ReservationCustomerInfoModel).toEntity(),
      menu: (menu as MenuModel).toEntity(),
      reservationDatetime: reservationDatetime,
      numberOfPeople: numberOfPeople,
      amount: (amount as ReservationAmountModel).toEntity(),
      status: (status as ReservationStatusModel).toEntity(),
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ReservationEntityMapper on Reservation {
  ReservationModel toModel() {
    return ReservationModel.fromEntity(this);
  }
}

// ReservationAmount mappers
extension ReservationAmountModelMapper on ReservationAmountModel {
  ReservationAmount toEntity() {
    return ReservationAmount(raw: raw, formatted: formatted);
  }
}

extension ReservationAmountEntityMapper on ReservationAmount {
  ReservationAmountModel toModel() {
    return ReservationAmountModel(raw: raw, formatted: formatted);
  }
}

// ReservationStatus mappers
extension ReservationStatusModelMapper on ReservationStatusModel {
  ReservationStatus toEntity() {
    return ReservationStatus(value: value, label: label);
  }
}

extension ReservationStatusEntityMapper on ReservationStatus {
  ReservationStatusModel toModel() {
    return ReservationStatusModel(value: value, label: label);
  }
}

// ReservationCustomerInfo mappers
extension ReservationCustomerInfoModelMapper on ReservationCustomerInfoModel {
  ReservationCustomerInfo toEntity() {
    return ReservationCustomerInfo(
      fullName: fullName,
      fullNameKana: fullNameKana,
      email: email,
      phoneNumber: phoneNumber,
      isGuest: isGuest,
    );
  }
}

extension ReservationCustomerInfoEntityMapper on ReservationCustomerInfo {
  ReservationCustomerInfoModel toModel() {
    return ReservationCustomerInfoModel(
      fullName: fullName,
      fullNameKana: fullNameKana,
      email: email,
      phoneNumber: phoneNumber,
      isGuest: isGuest,
    );
  }
}

// ReservationUser mappers
extension ReservationUserModelMapper on ReservationUserModel {
  ReservationUser toEntity() {
    return ReservationUser(
      id: id,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}

extension ReservationUserEntityMapper on ReservationUser {
  ReservationUserModel toModel() {
    return ReservationUserModel(
      id: id,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}
