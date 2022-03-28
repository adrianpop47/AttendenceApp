class Response {
  final String type;
  final String? data;

  Response(this.type, this.data);
  @override
  String toString() {
    return '$type: $data';
  }
}

const String FOUND_PERSON = "FOUND_PERSON";
const String UNKNOWN_PERSON = "UNKNOWN_PERSON";
const String NO_FACE_DETECTED = "NO_FACE_DETECTED";
