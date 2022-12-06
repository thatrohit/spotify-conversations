class ResponseWrapper<T> {
  ResponseError? error;
  T responseObject;
  ResponseWrapper(this.responseObject, {this.error});
}

class ResponseError {
  int? errorCode;
  String? message;

  ResponseError(this.errorCode, this.message);
}
