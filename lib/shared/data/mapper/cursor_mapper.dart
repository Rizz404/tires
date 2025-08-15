import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/features/user/data/models/user_model.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/core/network/cursor.dart' as network;

extension CursorMapper on network.Cursor {
  Cursor toEntity() {
    return Cursor(
      nextCursor: nextCursor,
      hasNextPage: hasNextPage,
      perPage: perPage,
    );
  }
}

extension CursorEntityMapper on Cursor {
  network.Cursor toModel() {
    return network.Cursor(
      nextCursor: nextCursor,
      hasNextPage: hasNextPage,
      perPage: perPage,
    );
  }
}
