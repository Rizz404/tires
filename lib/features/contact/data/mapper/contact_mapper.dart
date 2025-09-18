import 'package:tires/features/contact/data/models/contact_model.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';

extension ContactModelMapper on ContactModel {
  Contact toEntity() {
    return Contact(
      id: id,
      user: user,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      subject: subject,
      message: message,
      status: status,
      adminReply: adminReply,
      repliedAt: repliedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ContactEntityMapper on Contact {
  ContactModel toModel() {
    return ContactModel.fromEntity(this);
  }
}
