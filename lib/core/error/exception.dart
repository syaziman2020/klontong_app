class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);

  @override
  String toString() => 'BadRequestException: $message';
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);

  @override
  String toString() => 'NotFoundException: $message';
}

class InternalServerErrorException implements Exception {
  final String message;
  InternalServerErrorException(this.message);

  @override
  String toString() => 'InternalServerErrorException: $message';
}

class GenericHttpException implements Exception {
  final String message;
  GenericHttpException(this.message);

  @override
  String toString() => 'HttpException: $message';
}
