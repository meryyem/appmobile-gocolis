import 'package:flutter/material.dart';
import 'package:gocolis/features/messages/screens/camera_screen.dart';

class CameraPage extends StatelessWidget {
  final Function onImageSend;
  const CameraPage({Key? key, required this.onImageSend, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CameraScreen(onImageSend: onImageSend);
  }
}
