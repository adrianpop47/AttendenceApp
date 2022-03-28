import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/camera_screen.dart';
import 'package:http/http.dart' as http;
import 'package:wakelock/wakelock.dart';

import 'controllers/network_controller.dart';

void main() async {
  NetworkController networkController = NetworkController();
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  final frontCamera = (await availableCameras()).firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (_) => runApp(MyApp(
          frontCamera: frontCamera, networkController: networkController)));
}

class MyApp extends StatelessWidget {
  final CameraDescription frontCamera;
  final NetworkController networkController;
  const MyApp(
      {Key? key, required this.frontCamera, required this.networkController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Attendance',
      theme: ThemeData(
        backgroundColor: Colors.black,
        primarySwatch: Colors.blue,
      ),
      home: CameraScreen(
          frontCamera: frontCamera, networkController: networkController),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? selectedImage;
  String? message = "";

  uploadImage() async {
    final request = http.MultipartRequest(
        "POST", Uri.parse("http://192.168.0.102:4000/recognize"));
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile('image',
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    setState(() {
      message = resJson["message"];
    });
    log(message!);
  }

  getImage() async {
    // final pickedImage =
    //     await ImagePicker().pickImage(source: ImageSource.camera);
    // setState(() {
    //   selectedImage = File(pickedImage!.path);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
                onPressed: uploadImage,
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
