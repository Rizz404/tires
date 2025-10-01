import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_endpoints.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/core/network/dio_client.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/contact/data/models/contact_model.dart';
import 'package:tires/features/contact/data/models/contact_statistic_model.dart';
import 'package:tires/features/contact/domain/usecases/bulk_delete_contacts_usecase.dart';
import 'package:tires/features/contact/domain/usecases/create_contact_usecase.dart';
import 'package:tires/features/contact/domain/usecases/delete_contact_usecase.dart';
import 'package:tires/features/contact/domain/usecases/get_contacts_cursor_usecase.dart';
import 'package:tires/features/contact/domain/usecases/update_contact_usecase.dart';

abstract class ContactRemoteDataSource {
  Future<ApiResponse<ContactModel>> createContact(CreateContactParams params);
  Future<ApiCursorPaginationResponse<ContactModel>> getContactsCursor(
    GetContactsCursorParams params,
  );
  Future<ApiResponse<ContactModel>> updateContact(UpdateContactParams params);
  Future<ApiResponse<dynamic>> deleteContact(DeleteContactParams params);
  Future<ApiResponse<dynamic>> bulkDeleteContacts(
    BulkDeleteContactsUsecaseParams params,
  );
  Future<ApiResponse<ContactStatisticModel>> getContactStatistics();
}

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final DioClient _dioClient;

  ContactRemoteDataSourceImpl(this._dioClient);

  @override
  Future<ApiResponse<ContactModel>> createContact(
    CreateContactParams params,
  ) async {
    try {
      AppLogger.networkInfo('Creating contact');
      final response = await _dioClient.post<ContactModel>(
        ApiEndpoints.adminContacts,
        data: params.toMap(),
        fromJson: (data) => ContactModel.fromMap(data),
      );
      AppLogger.networkDebug('Contact created successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error creating contact', e);
      rethrow;
    }
  }

  @override
  Future<ApiCursorPaginationResponse<ContactModel>> getContactsCursor(
    GetContactsCursorParams params,
  ) async {
    try {
      AppLogger.networkInfo('Fetching contacts cursor');
      final response = await _dioClient.getWithCursor<ContactModel>(
        ApiEndpoints.adminContacts,
        fromJson: (item) => ContactModel.fromMap(item as Map<String, dynamic>),
        queryParameters: params.toMap(),
      );
      AppLogger.networkDebug('Contacts cursor fetched successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching contacts cursor', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ContactModel>> updateContact(
    UpdateContactParams params,
  ) async {
    try {
      AppLogger.networkInfo('Updating contact with id: ${params.id}');
      final response = await _dioClient.patch<ContactModel>(
        '${ApiEndpoints.adminContacts}/${params.id}',
        data: params.toMap(),
        fromJson: (data) => ContactModel.fromMap(data),
      );
      AppLogger.networkDebug('Contact updated successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error updating contact', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<dynamic>> deleteContact(DeleteContactParams params) async {
    try {
      AppLogger.networkInfo('Deleting contact with id: ${params.id}');
      final response = await _dioClient.delete<dynamic>(
        '${ApiEndpoints.adminContacts}/${params.id}',
        data: params.toMap(),
        fromJson: (data) => data,
      );
      AppLogger.networkDebug('Contact deleted successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error deleting contact', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<dynamic>> bulkDeleteContacts(
    BulkDeleteContactsUsecaseParams params,
  ) async {
    try {
      AppLogger.networkInfo('Deleting contact with');
      final response = await _dioClient.delete<dynamic>(
        ApiEndpoints.adminContactBulkDelete,
        data: params.toMap(),
      );
      AppLogger.networkDebug('Contact deleted successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error deleting contact', e);
      rethrow;
    }
  }

  @override
  Future<ApiResponse<ContactStatisticModel>> getContactStatistics() async {
    try {
      AppLogger.networkInfo('Fetching contact statistics');
      final response = await _dioClient.get<ContactStatisticModel>(
        ApiEndpoints.adminContactStatistics,
        fromJson: (data) => ContactStatisticModel.fromMap(data),
      );
      AppLogger.networkDebug('Contact statistics fetched successfully');
      return response;
    } catch (e) {
      AppLogger.networkError('Error fetching contact statistics', e);
      rethrow;
    }
  }
}
