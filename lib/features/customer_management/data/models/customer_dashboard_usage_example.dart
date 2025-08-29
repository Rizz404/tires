// Example usage of CustomerDashboard model and mapper
// This file demonstrates how to use the CustomerDashboardModel and mapper

/*
// Example API response structure
final Map<String, dynamic> apiResponse = {
  "summary": {
    "total_reservations": 15
  },
  "recent_reservations": [
    {
      "id": 1,
      "reservation_number": "RES-2024-001",
      "user": {
        "id": 1,
        "full_name": "John Doe",
        "email": "john@example.com",
        "phone_number": "+1234567890"
      },
      "customer_info": {
        "full_name": "John Doe",
        "full_name_kana": "ジョン ドウ",
        "email": "john@example.com",
        "phone_number": "+1234567890",
        "is_guest": false
      },
      "menu": {
        "id": 1,
        "name": "Tire Replacement",
        "description": "Full tire replacement service",
        "required_time": 60,
        "price": {
          "amount": "150.00",
          "formatted": "$150.00",
          "currency": "USD"
        },
        "photo_path": "/images/tire-service.jpg",
        "display_order": 1,
        "is_active": true,
        "color": {
          "hex": "#FF6B6B",
          "rgba_light": "rgba(255,107,107,0.15)",
          "text_color": "#FFFFFF"
        }
      },
      "reservation_datetime": "2024-08-30T10:00:00Z",
      "number_of_people": 1,
      "amount": {
        "raw": "150.00",
        "formatted": "$150.00"
      },
      "status": {
        "value": "confirmed",
        "label": "Confirmed"
      },
      "notes": "Customer prefers morning appointment",
      "created_at": "2024-08-29T09:00:00Z",
      "updated_at": "2024-08-29T09:00:00Z"
    }
  ]
};

// Usage example:
import 'package:tires/features/customer_management/data/models/customer_dashboard_model.dart';
import 'package:tires/features/customer_management/data/mapper/customer_dashboard_mapper.dart';

void exampleUsage() {
  // 1. Parse API response to model
  final customerDashboardModel = CustomerDashboardModel.fromMap(apiResponse);

  // 2. Convert model to entity for business logic
  final customerDashboard = customerDashboardModel.toEntity();

  // 3. Access data
  print('Total reservations: ${customerDashboard.summary.totalReservations}');
  print('Recent reservations count: ${customerDashboard.recentReservations.length}');

  // 4. Convert entity back to model if needed (e.g., for saving to local storage)
  final modelFromEntity = customerDashboard.toModel();

  // 5. Convert to JSON for API calls
  final jsonString = modelFromEntity.toJson();
  print('JSON representation: $jsonString');
}
*/
