import 'package:tires/features/calendar/domain/entities/calendar_data.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/entities/reservation_amount.dart';
import 'package:tires/features/reservation/domain/entities/reservation_customer_info.dart';
import 'package:tires/features/reservation/domain/entities/reservation_status.dart';
import 'package:tires/features/reservation/domain/entities/reservation_user.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:intl/intl.dart';

/// Extension to convert CalendarReservation to Reservation
extension CalendarReservationMapper on CalendarReservation {
  /// Converts CalendarReservation to Reservation entity
  Reservation toReservation({DateTime? dateContext}) {
    // Parse the amount string to get the raw value
    final amountValue =
        int.tryParse(amount.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

    // Create ReservationAmount
    final reservationAmount = ReservationAmount(
      raw: amountValue.toString(),
      formatted: amount,
    );

    // Use the existing customerInfo from CalendarReservation
    final reservationCustomerInfo = ReservationCustomerInfo(
      fullName: customerInfo.fullName,
      fullNameKana: customerInfo.fullNameKana,
      email: customerInfo.email,
      phoneNumber: customerInfo.phoneNumber,
      isGuest: customerInfo.isGuest,
    );

    // Use the existing user from CalendarReservation
    final reservationUser = ReservationUser(
      id: user.id,
      fullName: user.fullName,
      email: user.email,
      phoneNumber: user.phoneNumber,
    );

    // Create Menu entity
    final menuEntity = Menu(
      id: menu.id,
      name: menu.name,
      description: menu.description,
      requiredTime: menu.requiredTime.toInt(),
      price: Price(
        amount: amountValue.toString(),
        formatted: amount,
        currency: 'JPY', // Default currency
      ),
      photoPath: menu.photoPath,
      displayOrder: menu.displayOrder.toInt(),
      isActive: menu.isActive,
      color: ColorInfo(
        hex: menu.color.hex,
        rgbaLight: menu.color.rgbaLight,
        textColor: menu.color.textColor,
      ),
      translations: menu.translations != null
          ? MenuTranslation(
              en: MenuContent(name: menu.name, description: menu.description),
              ja: null,
            )
          : null,
    );

    // Parse reservation date and time
    DateTime reservationDateTime;
    try {
      // Use provided date context or today
      final contextDate = dateContext ?? DateTime.now();
      final timeParts = time.split(':');
      reservationDateTime = DateTime(
        contextDate.year,
        contextDate.month,
        contextDate.day,
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );
    } catch (e) {
      reservationDateTime = DateTime.now();
    }

    // Convert status string to ReservationStatus
    String statusLabel = status;
    ReservationStatusValue statusValue;
    switch (status.toLowerCase()) {
      case 'pending':
        statusValue = ReservationStatusValue.pending;
        break;
      case 'confirmed':
        statusValue = ReservationStatusValue.confirmed;
        break;
      case 'completed':
        statusValue = ReservationStatusValue.completed;
        break;
      case 'cancelled':
        statusValue = ReservationStatusValue.cancelled;
        break;
      default:
        statusValue = ReservationStatusValue.pending;
        statusLabel = 'Pending';
    }

    final reservationStatus = ReservationStatus(
      value: statusValue,
      label: statusLabel,
    );

    return Reservation(
      id: id,
      reservationNumber: reservationNumber,
      user: reservationUser,
      customerInfo: reservationCustomerInfo,
      menu: menuEntity,
      reservationDatetime: reservationDateTime,
      numberOfPeople: peopleCount.toInt(),
      amount: reservationAmount,
      status: reservationStatus,
      notes: null, // Not available in CalendarReservation
      createdAt: DateTime.now(), // Using current time as fallback
      updatedAt: DateTime.now(),
    );
  }
}
