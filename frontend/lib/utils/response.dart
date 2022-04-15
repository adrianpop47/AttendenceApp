class Response {
  final String type;
  final String? data;

  Response(this.type, this.data);
  @override
  String toString() {
    return '$type: $data';
  }
}

const String SIGN_UP_OK = "SIGN_UP_OK";
const String SIGN_UP_FAILED = "SIGN_UP_FAILED";
const String DUPLICATE_SIGN_UP_EMAIL = "DUPLICATE_SIGN_UP_EMAIL";
const String SIGN_IN_OK = "SIGN_IN_OK";
const String SIGN_IN_FAILED = "SIGN_IN_FAILED";
const String FOUND_PERSON = "FOUND_PERSON";
const String UNKNOWN_PERSON = "UNKNOWN_PERSON";
const String NO_FACE_DETECTED = "NO_FACE_DETECTED";
