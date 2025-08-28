import 'package:tires/features/menu/data/mapper/menu_mapper.dart';
import 'package:tires/features/menu/data/models/menu_model.dart';
import 'package:tires/features/reservation/data/models/reservation_model.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/user/data/mapper/user_mapper.dart';
import 'package:tires/features/user/data/models/user_model.dart';

extension ReservationModelMapper on ReservationModel {
  Reservation toEntity() {
    return Reservation(
      id: id,
      reservationNumber: reservationNumber,
      user: (user as UserModel?)?.toEntity(),
      fullName: fullName,
      fullNameKana: fullNameKana,
      email: email,
      phoneNumber: phoneNumber,
      isGuest: isGuest,
      menu: (menu as MenuModel).toEntity(),
      reservationDatetime: reservationDatetime,
      numberOfPeople: numberOfPeople,
      amount: amount,
      formattedAmount: formattedAmount,
      status: status,
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
