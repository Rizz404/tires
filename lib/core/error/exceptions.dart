class ServerException {
  final String message;
  final int? code;
  final List<Error>? error;

  const ServerException({required this.message, this.code = 500, this.error});
}

class Error {
  final String field;
  final String tag;
  final String value;
  final String message;

  const Error({
    required this.field,
    required this.tag,
    required this.value,
    required this.message,
  });
}
