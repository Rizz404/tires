import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/contact/domain/usecases/bulk_delete_contacts_usecase.dart';
import 'package:tires/features/contact/domain/usecases/create_contact_usecase.dart';
import 'package:tires/features/contact/domain/usecases/delete_contact_usecase.dart';
import 'package:tires/features/contact/domain/usecases/get_contacts_cursor_usecase.dart';
import 'package:tires/features/contact/domain/usecases/update_contact_usecase.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';
import 'package:tires/features/contact/domain/entities/contact_statistic.dart';

abstract class ContactRepository {
  Future<Either<Failure, ItemSuccessResponse<Contact>>> createContact(
    CreateContactParams params,
  );
  Future<Either<Failure, CursorPaginatedSuccess<Contact>>> getContactsCursor(
    GetContactsCursorParams params,
  );
  Future<Either<Failure, ItemSuccessResponse<Contact>>> updateContact(
    UpdateContactParams params,
  );
  Future<Either<Failure, ActionSuccess>> deleteContact(
    DeleteContactParams params,
  );
  Future<Either<Failure, ActionSuccess>> bulkDeleteContacts(
    BulkDeleteContactsUsecaseParams params,
  );
  Future<Either<Failure, ItemSuccessResponse<ContactStatistic>>>
  getContactStatistics();
}
