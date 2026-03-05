class Success {
  int? code;
  Object? response;
  Success({this.code, this.response});
}

class Failure {
  int? code;
  Object? errorResponse;
  Failure({this.code, this.errorResponse});
}

class Response {
  int? code;
  Object? response;
  String? message;
  Response({this.code, this.response, this.message});
}
