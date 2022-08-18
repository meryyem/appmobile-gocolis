/*import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../constants/global_variables.dart';

class ImageController extends GetxController {
  PickedFile? _pickedFile;
  // my getter for picked files:
  PickedFile? get pickedFile => _pickedFile;
  
  String? _imagePath;
  String? get imagePath => _imagePath;

  final _picker = ImagePicker();

  //implementing the image picker
  Future<void> pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    update();
  }

// to upload images to the server
  Future<bool> upload() async {
    update();
    bool success = false;

    http.StreamedResponse response = await updateProfile(_pickedFile);

    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map['message'];
      success = true;
      print(message);
      _imagePath = message;
    } else {
      print('Error uploading image');
    }

    update();

    return success;
  }

  Future<http.StreamedResponse> updateProfile(PickedFile? data) async {
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse('$uri/upload'));

    if (GetPlatform.isMobile && data != null) {
      File _file = File(data.path);
      request.files.add(http.MultipartFile(
          'image', _file.readAsBytes().asStream(), _file.lengthSync(),
          filename: _file.path.split('/').last));
    }

    http.StreamedResponse response = await request.send();
    return response;
  }
}
*/