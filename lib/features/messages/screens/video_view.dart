import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:video_player/video_player.dart';

class VideoViewPage extends StatefulWidget {
  //getting a variable from the constructor => get the path from the cameraScreen to the cameraView
  final String videoPath;
  const VideoViewPage({Key? key, required this.videoPath}) : super(key: key);

  @override
  State<VideoViewPage> createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  VideoPlayerController? _videoController;

  //init the _videoController in the initState
  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(
      // to get the value of the variable videoPath we need to use widget
        File((widget.videoPath)))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }


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
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            //height: MediaQuery.of(context).size.height - 150,
            //provide the path which iam getting from the camera screen

            // in the child we are checking if the variable _videoController is initialized or not ??
            child: _videoController!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: VideoPlayer(_videoController!),
                )
              : Container(),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: kPrimaryColor,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: TextFormField(
                maxLines: 6,
                minLines: 1,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Add Caption ..",
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  prefixIcon: Icon(
                    Icons.add_photo_alternate,
                    color: Colors.white,
                    size: 27,
                  ),
                  suffixIcon: CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.check, color: Colors.white, size: 27),
                  ),
                )
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                setState(() {
                  _videoController!.value.isPlaying ? _videoController!.pause() : _videoController!.play();
                });
              },
              child: CircleAvatar(
                radius: 2,
                backgroundColor: Colors.black12,
                child: Icon(_videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 50)),
            ),
          ),
        ]
      ),

    ),
    );
  }
}
