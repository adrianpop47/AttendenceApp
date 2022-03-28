import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:frontend/utils/config.dart';
import 'package:frontend/utils/response.dart';

import 'package:http/http.dart' as http;

class NetworkController {
  final String _url = "http://$cHost:$cPort";

  checkIn(XFile image) async {
    final request = http.MultipartRequest("POST", Uri.parse("$_url/check-in"));
    return await markAttendance(image, request);
  }

  checkOut(XFile image) async {
    final request = http.MultipartRequest("POST", Uri.parse("$_url/check-out"));
    return await markAttendance(image, request);
  }

  markAttendance(XFile xFileImage, http.MultipartRequest request) async {
    File image = File(xFileImage.path);
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile(
        'image', image.readAsBytes().asStream(), image.lengthSync(),
        filename: image.path.split("/").last));
    request.headers.addAll(headers);
    http.Response httpResponse =
        await http.Response.fromStream(await request.send());
    final jsonResponse = await jsonDecode(httpResponse.body);
    return Response(jsonResponse["type"], jsonResponse["data"]);
  }
}
