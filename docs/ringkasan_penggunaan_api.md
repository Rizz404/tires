# Ringkasan Penggunaan API (Sederhana)

Format: Setiap endpoint ditampilkan bersama path dan daftar file yang memakainya. Jika belum dipakai ditandai `(BELUM DIGUNAKAN)`.

## Auth
- `/auth/register`
  - authentication/data/datasources/auth_remote_datasource.dart
- `/auth/login`
  - authentication/data/datasources/auth_remote_datasource.dart
- `/auth/logout`
  - authentication/data/datasources/auth_remote_datasource.dart
- `/customer/forgot-password`
  - authentication/data/datasources/auth_remote_datasource.dart
- `/customer/change-password`
  - authentication/data/datasources/auth_remote_datasource.dart

## Admin
- `/admin/dashboard`
  - dashboard/data/datasources/dashboard_remote_datasource.dart
- `/admin/menus`
  - menu/data/datasources/menu_remote_datasource.dart
- `/admin/users`
  - user/data/datasources/users_remote_datasource.dart
- `/admin/customers`
  - customer_management/data/datasources/customer_remote_datasource.dart
- `/admin/customers/statistics`
  - customer_management/data/datasources/customer_remote_datasource.dart
- `/admin/reservations`
  - reservation/data/datasources/reservation_remote_datasource.dart
- `/admin/reservations/calendar` (BELUM DIGUNAKAN)
- `/admin/announcements`
  - announcement/data/datasources/announcement_remote_datasource.dart
- `/admin/announcements/statistics`
  - announcement/data/datasources/announcement_remote_datasource.dart
- `/admin/menus/statistics`
  - menu/data/datasources/menu_remote_datasource.dart
- `/admin/contacts/statistics`
  - contact/data/datasources/contact_remote_datasource.dart
- `/admin/blocked-periods`
  - blocked_period/data/datasources/blocked_period_remote_datasource.dart
- `/admin/blocked-periods/statistics`
  - blocked_period/data/datasources/blocked_period_remote_datasource.dart
- `/admin/business-settings`
  - business_information/data/datasources/business_information_remote_datasource.dart
- `/admin/contacts`
  - contact/data/datasources/contact_remote_datasource.dart
- `/admin/faqs` (BELUM DIGUNAKAN)
- `/admin/payments` (BELUM DIGUNAKAN)
- `/admin/questionnaires` (BELUM DIGUNAKAN)
- `/admin/tire-storages` (BELUM DIGUNAKAN)
- `/admin/availability` (BELUM DIGUNAKAN)

## Customer
- `/customer/profile`
  - user/data/datasources/current_user_remote_datasource.dart
- `/customer/menus` (BELUM DIGUNAKAN)
- `/customer/users` (BELUM DIGUNAKAN)
- `/customer/dashboard`
  - customer_management/data/datasources/customer_remote_datasource.dart
- `/customer/reservations`
  - reservation/data/datasources/reservation_remote_datasource.dart
- `/customer/booking/create-reservation`
  - reservation/data/datasources/reservation_remote_datasource.dart
- `/customer/booking/calendar-data`
  - reservation/data/datasources/reservation_remote_datasource.dart
  - availability/data/datasources/availability_remote_datasource.dart
- `/customer/booking/available-hours`
  - reservation/data/datasources/reservation_remote_datasource.dart
- `/customer/announcements` (BELUM DIGUNAKAN)
- `/customer/blocked-periods` (BELUM DIGUNAKAN)
- `/customer/business-settings` (BELUM DIGUNAKAN)
- `/customer/contacts` (BELUM DIGUNAKAN)
- `/customer/inquiry`
  - inquiry/data/datasources/inquiry_remote_datasource.dart
- `/customer/faqs` (BELUM DIGUNAKAN)
- `/customer/payments` (BELUM DIGUNAKAN)
- `/customer/questionnaires` (BELUM DIGUNAKAN)
- `/customer/tire-storages` (BELUM DIGUNAKAN)
- `/customer/availability` (BELUM DIGUNAKAN)

## Public
- `/public/menus`
  - menu/data/datasources/menu_remote_datasource.dart
- `/public/business-settings`
  - business_information/data/datasources/business_information_remote_datasource.dart

## Fungsi Dinamis (by-id)
Semua berikut belum dipakai langsung (interpolasi manual dipakai di kode):
- `/menus/{id}` (`menuById`)
- `/users/{id}` (`userById`)
- `/reservations/{id}` (`reservationById`)
- `/announcements/{id}` (`announcementById`)
- `/blocked-periods/{id}` (`blockedPeriodById`)
- `/business-settings/{id}` (`businessSettingById`)
- `/contacts/{id}` (`contactById`)
- `/faqs/{id}` (`faqById`)
- `/payments/{id}` (`paymentById`)
- `/questionnaires/{id}` (`questionnaireById`)
- `/tire-storages/{id}` (`tireStorageById`)

## Placeholder Endpoint Baru (Isi Sendiri)
Tambahkan di bawah ini endpoint yang perlu diimplementasikan backend.

```
# Contoh format:
# CUSTOMER GET /customer/tire-storages -> Menampilkan daftar penyimpanan ban.
```

---
_Generated otomatis (format sederhana)._
