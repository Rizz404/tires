import 'package:fpdart/src/either.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/features/contact/data/datasources/contact_remote_datasource.dart';
import 'package:tires/features/contact/data/mapper/contact_mapper.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';
import 'package:tires/features/contact/domain/entities/contact_statistic.dart';
import 'package:tires/features/contact/domain/repositories/contact_repository.dart';
import 'package:tires/features/contact/domain/usecases/bulk_delete_contacts_usecase.dart';
import 'package:tires/features/contact/domain/usecases/create_contact_usecase.dart';
import 'package:tires/features/contact/domain/usecases/delete_contact_usecase.dart';
import 'package:tires/features/contact/domain/usecases/get_contacts_cursor_usecase.dart';
import 'package:tires/features/contact/domain/usecases/update_contact_usecase.dart';
import 'package:tires/shared/data/mapper/cursor_mapper.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactRemoteDataSource _remoteDataSource;

  ContactRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ItemSuccessResponse<Contact>>> createContact(
    CreateContactParams params,
  ) async {
    try {
      AppLogger.businessInfo('Creating contact in repository');
      final result = await _remoteDataSource.createContact(params);
      AppLogger.businessDebug('Contact created successfully in repository');
      return Right(
        ItemSuccessResponse<Contact>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in create contact', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in create contact', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Contact>>> getContactsCursor(
    GetContactsCursorParams params,
  ) async {
    try {
      AppLogger.businessInfo('Fetching contacts cursor in repository');
      final result = await _remoteDataSource.getContactsCursor(params);
      AppLogger.businessDebug(
        'Contacts cursor fetched successfully in repository',
      );
      return Right(
        CursorPaginatedSuccess<Contact>(
          data: result.data.map((contact) => contact.toEntity()).toList(),
          cursor: result.cursor?.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in get contacts cursor', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in get contacts cursor', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<Contact>>> updateContact(
    UpdateContactParams params,
  ) async {
    try {
      AppLogger.businessInfo('Updating contact in repository');
      final result = await _remoteDataSource.updateContact(params);
      AppLogger.businessDebug('Contact updated successfully in repository');
      return Right(
        ItemSuccessResponse<Contact>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in update contact', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in update contact', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> deleteContact(
    DeleteContactParams params,
  ) async {
    try {
      AppLogger.businessInfo('Deleting contact in repository');
      final result = await _remoteDataSource.deleteContact(params);
      AppLogger.businessDebug('Contact deleted successfully in repository');
      return Right(ActionSuccess(message: result.message));
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in delete contact', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in delete contact', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemSuccessResponse<ContactStatistic>>>
  getContactStatistics() async {
    try {
      AppLogger.businessInfo('Fetching contact statistics in repository');
      final result = await _remoteDataSource.getContactStatistics();
      AppLogger.businessDebug(
        'Contact statistics fetched successfully in repository',
      );
      return Right(
        ItemSuccessResponse<ContactStatistic>(
          data: result.data.toEntity(),
          message: result.message,
        ),
      );
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in get contact statistics', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in get contact statistics', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionSuccess>> bulkDeleteContacts(
    BulkDeleteContactsUsecaseParams params,
  ) async {
    try {
      AppLogger.businessInfo('Deleting contact in repository');
      final result = await _remoteDataSource.bulkDeleteContacts(params);
      AppLogger.businessDebug('Contact deleted successfully in repository');
      return Right(ActionSuccess(message: result.message));
    } on ApiErrorResponse catch (e) {
      AppLogger.businessError('API error in delete contact', e);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      AppLogger.businessError('Unexpected error in delete contact', e);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
