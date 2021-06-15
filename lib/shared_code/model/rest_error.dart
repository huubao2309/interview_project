class RestError {
  RestError({required this.message});

  factory RestError.fromData(String msg) {
    return RestError(
      message: msg,
    );
  }

  String message;
}
