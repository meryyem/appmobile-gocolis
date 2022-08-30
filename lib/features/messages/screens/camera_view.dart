import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';

class CameraViewPage extends StatelessWidget {
  final String imagePath;
  final Function onImageSend;
  const CameraViewPage({Key? key, required this.imagePath, required this.onImageSend}) : super(key: key);
  static TextEditingController _captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.crop_rotate,
              size: 27,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.emoji_emotions_outlined,
              size: 27,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.title,
              size: 27,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
              size: 27,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            //height: MediaQuery.of(context).size.height - 150,
            //provide the path which iam getting from the camera screen
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: kPrimaryColor,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: TextFormField(
                controller: _captionController,
                  maxLines: 6,
                  minLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add Caption ..",
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    prefixIcon: const Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: 27,
                    ),
                    suffixIcon: InkWell(
                      onTap: onImageSend(imagePath, _captionController.text),
                      child: const CircleAvatar(
                        radius: 27,
                        backgroundColor: kPrimaryLightColor,
                        child: Icon(Icons.check, color: Colors.white, size: 27),
                      ),
                    ),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
