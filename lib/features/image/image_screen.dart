/*import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gocolis/constants/global_variables.dart';
import 'package:gocolis/getXControllers/Image_controller.dart';


class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  String url = Uri.parse('$uri').toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image upload'),
      ),
      body: GetBuilder<ImageController>(builder: (imageController) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(children: [
              Center(
                child: GestureDetector(
                  child: const Text('Select An Image'),
                  //onPressed: _openImagePicker,
                  //onTap:()=> Get.find<ImageController>().pickImage(),
                  onTap: () => imageController.pickImage(),
                ),
              ),
              const SizedBox(height: 35),
              /*Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: imageController.pickedFile != null
                      ? Image.file(
                    File(imageController.pickedFile!
                        .path), width: 100, height: 100, fit: BoxFit.cover,
                  )
                      : const Text('Please select an image'),
                ),*/

              GetBuilder<ImageController>(builder: (_) {
                return Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: Get.find<ImageController>().pickedFile != null
                      ? Image.file(
                          File(Get.find<ImageController>().pickedFile!.path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : const Text('Please select an image'),
                );
              }),
              const SizedBox(height: 35),
              GetBuilder<ImageController>(builder: (_) {
                return Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 180,
                  color: Colors.grey[300],
                  child: Get.find<ImageController>().imagePath != null
                      ? Image.network(
                          url + Get.find<ImageController>().imagePath!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : const Text('No image from server'),
                );
              }),
            ]),
          ),

            Center(
                child: GestureDetector(
                  child: const Text('Server upload'),
                  //onPressed: _openImagePicker,
                  //onTap:()=> Get.find<ImageController>().updateUserInfo(),
                ),
              ),
          const SizedBox(height: 35),*/

          /*return Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 200,
            color: Colors.grey[300],
            child: imageController.pickedFile != null
                ? Image.file(
                    File(imageController.pickedFile!.path),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : const Text('Please select an image'),
          ),
          const SizedBox(height: 35),
          Center(
            child: GestureDetector(
              child: const Text('Server upload'),
              onTap: () => Get.find<ImageController>().upload(),
            ),
          ),
        );
      }),
    );
  }
}
      
              
                  child: GestureDetector(
                    child: const Text('Select An Image'),
                    onTap: () => imageController.pickImage,
                  ),
                  
                  */