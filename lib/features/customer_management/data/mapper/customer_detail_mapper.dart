import 'package:tires/features/customer_management/data/models/customer_detail_model.dart';
import 'package:tires/features/customer_management/domain/entities/customer_detail.dart';

extension CustomerDetailModelMapper on CustomerDetailModel {
  CustomerDetail toEntity() {
    return CustomerDetail(
      customer: (customer as CustomerModel).toEntity(),
      reservationHistory: reservationHistory
          .map((history) => (history as ReservationHistoryModel).toEntity())
          .toList(),
      tireStorage: tireStorage,
      stats: (stats as StatsModel).toEntity(),
    );
  }
}

extension CustomerModelMapper on CustomerModel {
  Customer toEntity() {
    return Customer(
      customerId: customerId,
      fullName: fullName,
      fullNameKana: fullNameKana,
      email: email,
      phoneNumber: phoneNumber,
      isRegistered: isRegistered,
      userId: userId,
      companyName: companyName,
      department: department,
      companyAddress: companyAddress,
      homeAddress: homeAddress,
      dateOfBirth: dateOfBirth,
      gender: gender,
      reservationCount: reservationCount,
      latestReservation: latestReservation,
      totalAmount: totalAmount,
    );
  }
}

extension ReservationHistoryModelMapper on ReservationHistoryModel {
  ReservationHistory toEntity() {
    return ReservationHistory(
      id: id,
      reservationNumber: reservationNumber,
      userId: userId,
      fullName: fullName,
      fullNameKana: fullNameKana,
      email: email,
      phoneNumber: phoneNumber,
      menuId: menuId,
      reservationDatetime: reservationDatetime,
      numberOfPeople: numberOfPeople,
      amount: amount,
      status: status,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
      menu: menu, // Menu is already an entity
    );
  }
}

extension StatsModelMapper on StatsModel {
  Stats toEntity() {
    return Stats(
      reservationCount: reservationCount,
      totalAmount: totalAmount,
      tireStorageCount: tireStorageCount,
    );
  }
}
