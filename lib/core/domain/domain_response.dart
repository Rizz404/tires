abstract class SuccessResponse<T> {
  final T? data;
  final String? message;

  SuccessResponse({this.data, this.message});

  @override
  bool operator ==(covariant SuccessResponse<T> other) {
    if (identical(this, other)) return true;

    return other.data == data && other.message == message;
  }

  @override
  int get hashCode => data.hashCode ^ message.hashCode;
}

class ItemSuccessResponse<T> extends SuccessResponse<T> {
  ItemSuccessResponse({required super.data, super.message});
}

class OffsetPaginatedSuccess<T> extends SuccessResponse<List<T>> {
  final Pagination pagination;

  OffsetPaginatedSuccess({
    required super.data,
    required this.pagination,
    super.message,
  });
}

class CursorPaginatedSuccess<T> extends SuccessResponse<List<T>> {
  // Todo: Nanti benerin harusnya gak nullable
  final Cursor? cursor;

  CursorPaginatedSuccess({required super.data, this.cursor, super.message});
}

class ActionSuccess extends SuccessResponse {
  ActionSuccess({super.message});
}

class Pagination {
  final int total;
  final int perPage;
  final int currentPage;
  final int totalPages;
  final bool hasPrevPage;
  final bool hasNextPage;

  Pagination({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
    required this.hasPrevPage,
    required this.hasNextPage,
  });
}

class Cursor {
  final String? nextCursor;
  final String? previousCursor;
  final bool hasNextPage;
  final int perPage;

  Cursor({
    required this.nextCursor,
    this.previousCursor,
    required this.hasNextPage,
    required this.perPage,
  });
}
