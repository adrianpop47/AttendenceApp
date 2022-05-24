import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:frontend/utils/config.dart';
import 'package:frontend/utils/response.dart';

import 'package:http/http.dart' as http;

class NetworkController {
  final String _url = cUrl;

  login(String email, String password) async {
    final httpResponse = await http.post(
      Uri.parse("$_url/sign-in"),
      body: {
        'email': email,
        'password': password,
      },
    );
    final jsonResponse = await jsonDecode(httpResponse.body);
    return Response(jsonResponse["type"], jsonResponse["data"]);
  }

  register(String name, String email, String passwordHash, XFile image) async {
    final request = http.MultipartRequest("POST", Uri.parse("$_url/sign-up"));
    final headers = {"Content-type": "multipart/form-data"};
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = passwordHash;
    File imageFile = File(image.path);
    request.files.add(http.MultipartFile(
        'image', image.readAsBytes().asStream(), imageFile.lengthSync(),
        filename: imageFile.path.split("/").last));
    request.headers.addAll(headers);
    http.Response httpResponse =
        await http.Response.fromStream(await request.send());
    final jsonResponse = await jsonDecode(httpResponse.body);
    return Response(jsonResponse["type"], jsonResponse["data"]);
  }

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

  getAttendance(int userId) async {
    final request = http.MultipartRequest("GET", Uri.parse("$_url/attendance"));
    request.fields['id'] = userId.toString();
    http.Response httpResponse =
        await http.Response.fromStream(await request.send());
    final jsonResponse = await jsonDecode(httpResponse.body);
    return jsonResponse["data"];
  }

  getUsers() async {
    final request = http.MultipartRequest("GET", Uri.parse("$_url/users"));
    http.Response httpResponse =
        await http.Response.fromStream(await request.send());
    final jsonResponse = await jsonDecode(httpResponse.body);
    return jsonResponse["data"];
  }

  deleteEmployee(int id) async {
    await http.post(
      Uri.parse("$_url/delete-employee"),
      body: {'id': id.toString()},
    );
  }
}
