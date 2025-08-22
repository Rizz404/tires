import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/network/cursor.dart' as network;

extension CursorMapper on network.Cursor {
  Cursor toEntity() {
    return Cursor(
      nextCursor: nextCursor,
      previousCursor: previousCursor,
      hasNextPage: hasNextPage,
      perPage: perPage,
    );
  }
}

extension CursorEntityMapper on Cursor {
  network.Cursor toModel() {
    return network.Cursor(
      nextCursor: nextCursor,
      previousCursor: previousCursor,
      hasNextPage: hasNextPage,
      perPage: perPage,
    );
  }
}
