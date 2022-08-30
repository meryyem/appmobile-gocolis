import 'dart:convert';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gocolis/common/widgets/chats/own_file_image_card.dart';
import 'package:gocolis/common/widgets/chats/own_message_card.dart';
import 'package:gocolis/common/widgets/chats/reply_card.dart';
import 'package:gocolis/common/widgets/chats/reply_file_image_card.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/constants/global_variables.dart';
import 'package:gocolis/features/messages/screens/camera_screen.dart';
import 'package:gocolis/features/messages/screens/camera_view.dart';
import 'package:gocolis/models/chat.dart';
import 'package:gocolis/models/message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class IndividualPage extends StatefulWidget {
  final Chat chat;
  final Chat sourceChat;
  const IndividualPage({Key? key, required this.chat, required this.sourceChat})
      : super(key: key);

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  //create an instance of this classe
  IO.Socket? socket;
  bool sendButton = false;
  List<Message> messages = [];
  TextEditingController _controller = TextEditingController();
  // control the scroll of message, when a new message will come it will be in the top automatically
  ScrollController _scrollController = ScrollController();
  // create an instance image picker
  ImagePicker imageMessage = ImagePicker();
  // where i will store the path of the image
  XFile? pathFile;
  int popTime = 0;

  _onEmojiSelected(Emoji emoji) {
    print('_onEmojiSelected: ${emoji.emoji}');
  }

  _onBackspacePressed() {
    print('_onBackspacePressed');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  //to initialize the io.socket thing
  void connect() {
    socket = IO.io(uri, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    //connect the socket server manually
    socket!.connect();
    socket!.onConnect((data) {
      print("Connected");
      socket!.on('message', (msg) {
        print(data);

        //send the message
        setMessage("destination", msg["message"], msg["imagePath"]);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket!.connected);
    //to send a message from the frontend to the backend
    //the event name : /chat
    socket!.emit("chat", widget.sourceChat.id);
  }

  void sendMessage(
      String message, int sourceId, int targetId, String imagePath) {
    //send the message
    setMessage("source", message, imagePath);
    socket!.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
      "imagePath": imagePath
    });
  }

  void setMessage(String type, String msge, String imagePath) {
    Message message = Message(
        type: type,
        message: msge,
        time: DateTime.now().toString().substring(10, 16),
        imagePath: imagePath);
    setState(() {
      messages.add(message);
    });
  }

  // this method  i will pass it to the cameraViewPage because im managing the state of all the messages in this page only!
  // so i have to pass that  method from this page to the cameraViewPage then only we can manage the state
  // im not using any state management so i have to put all the methods inside this page ONLY !!
  void onImageSend(String imagePath, String message) async {
    print("hey there working $imagePath");
    print("hey there working $message");

    for (int i = 0; i < popTime; i++) {
      Navigator.pop(context);
    }

    setState(() {
      popTime = 0;
    });
    // calling the api
    var request = http.MultipartRequest("POST", Uri.parse("$uri/api/message/addImage"));
    request.files.add(await http.MultipartFile.fromPath("img", imagePath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    http.StreamedResponse response = await request.send();
    //convert the response (type: StreamedResponse) to a http response (type will be http)
    // because we need to provide the exact name of the image from the backend to the path variable (the one of the one in the other side => other device so we can't read the local path of the image !!)
    var httpResponse = await http.Response.fromStream(response);
    var data = json.decode(httpResponse.body);
    print(data['imagePath']);
    // after submission i can see that iam getting the path or the name of the image from the backend so i have to use that image
    // at the time of showing the imlage on the other user app

    print(response.statusCode);
    //send the message
    setMessage("source", message, imagePath);
    socket!.emit("message", {
      "message": message,
      "sourceId": widget.sourceChat.id,
      "targetId": widget.chat.id,
      "imagePath": data['imagePath'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/chat_bg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_back),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                      child: SvgPicture.asset(
                        widget.chat.isGroup
                            ? "assets/icons/groups.svg"
                            : "assets/icons/person.svg",
                        color: Colors.white,
                        height: 36,
                        width: 36,
                      ),
                    )
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chat.name,
                        style: const TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "last seen today at 12:05",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
                IconButton(icon: const Icon(Icons.call), onPressed: () {}),
                PopupMenuButton<String>(onSelected: (value) {
                  print(value);
                }, itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: "View Contact",
                      child: Text("View Contact"),
                    ),
                    const PopupMenuItem(
                      value: "Media, links, and docs",
                      child: Text("Media, links, and docs"),
                    ),
                    const PopupMenuItem(
                      value: "Whatsapp web",
                      child: Text("Whatsapp web"),
                    ),
                    const PopupMenuItem(
                      value: "Search",
                      child: Text("Search"),
                    ),
                    const PopupMenuItem(
                      value: "Mute Notification",
                      child: Text("Mute Notification"),
                    ),
                    const PopupMenuItem(
                      value: "Wallpaper",
                      child: Text("Wallpaper"),
                    ),
                  ];
                })
              ]),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
              child: Column(
                children: [
                  Expanded(
                    //height: MediaQuery.of(context).size.height - 140,
                    child: ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: messages.length + 1,
                        itemBuilder: (context, index) {
                          if (index == messages.length) {
                            return Container(
                              height: 70,
                            );
                          }
                          if (messages[index].type == "source") {
                            if (messages[index].imagePath.length > 0) {
                              return OwnFileImageCard(
                                filePath: messages[index].imagePath,
                                message: messages[index].message,
                                time: messages[index].time,
                              );
                            } else {
                              if (messages[index].imagePath.length > 0) {
                                return ReplyFileImageCard(
                                  filePath: messages[index].imagePath,
                                  message: messages[index].message,
                                  time: messages[index].time,
                                );
                              } else {
                                return ReplyCard(
                                  replyMessage: messages[index].message,
                                  time: messages[index].time,
                                );
                              }
                            }
                          }
                          return Container();
                        }),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                  margin: const EdgeInsets.only(
                                      left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a message",
                                      prefixIcon: IconButton(
                                        icon: const Icon(
                                            Icons.emoji_emotions_outlined),
                                        onPressed: () {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                          setState(() {
                                            show != show;
                                          });
                                        },
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.attach_file),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (builder) =>
                                                    bottomSheet(),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.camera_alt),
                                            onPressed: () {
                                              //navigate to the camera screen already created
                                              setState(() {
                                                popTime = 2;
                                              });
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          CameraScreen(
                                                            onImageSend:onImageSend,
                                                          )));
                                            },
                                          ),
                                        ],
                                      ),
                                      contentPadding: const EdgeInsets.all(5),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, right: 2, left: 2),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: kPrimaryColor,
                                  child: IconButton(
                                    icon: Icon(
                                        sendButton ? Icons.send : Icons.mic,
                                        color: kPrimaryLightColor),
                                    onPressed: () {
                                      if (sendButton) {
                                        _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeOut,
                                        );
                                        sendMessage(
                                            _controller.text,
                                            widget.sourceChat.id,
                                            widget.chat.id,
                                            "");
                                        _controller.clear();
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          show ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreations(
                    Icons.insert_drive_file,
                    Colors.indigo,
                    "Document",
                    () {},
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreations(
                    Icons.camera_alt,
                    Colors.pink,
                    "Camera",
                    () {
                      setState(() {
                        popTime = 3;
                      });
                      //navigate to the camera screen already created
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => CameraScreen(
                                    onImageSend: onImageSend,
                                  )));
                    },
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreations(
                    Icons.insert_photo,
                    Colors.purple,
                    "Gallery",
                    () async {
                      setState(() {
                        popTime = 2;
                      });
                      pathFile = await imageMessage.pickImage(
                          source: ImageSource.gallery);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => CameraViewPage(
                                    imagePath: pathFile!.path,
                                    // here iam passing the onSendImage method from this screen to chatViewPage
                                    onImageSend: onImageSend,
                                  )));
                    },
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreations(
                    Icons.headset,
                    Colors.orange,
                    "Audio",
                    () {},
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreations(
                    Icons.location_pin,
                    Colors.pink,
                    "Location",
                    () {},
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreations(
                    Icons.person,
                    Colors.blue,
                    "Contact",
                    () {},
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreations(
      IconData icon, Color color, String text, Function onTap) {
    return InkWell(
      onTap: onTap(),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(text, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
        textEditingController: _controller,
        onEmojiSelected: (Category category, Emoji emoji) {
          _onEmojiSelected(emoji);
          setState(() {
            _controller.text = _controller.text + emoji.emoji;
          });
        },
        onBackspacePressed: _onBackspacePressed,
        config: const Config(
            columns: 7,
            emojiSizeMax: 32,
            verticalSpacing: 0,
            horizontalSpacing: 0,
            gridPadding: EdgeInsets.zero,
            initCategory: Category.RECENT,
            bgColor: Color(0xFFF2F2F2),
            indicatorColor: Colors.blue,
            iconColor: Colors.grey,
            iconColorSelected: Colors.blue,
            progressIndicatorColor: Colors.blue,
            backspaceColor: Colors.blue,
            skinToneDialogBgColor: Colors.white,
            skinToneIndicatorColor: Colors.grey,
            enableSkinTones: true,
            showRecentsTab: true,
            recentsLimit: 28,
            replaceEmojiOnLimitExceed: false,
            noRecents: Text(
              'No Recents',
              style: TextStyle(fontSize: 20, color: Colors.black26),
              textAlign: TextAlign.center,
            ),
            tabIndicatorAnimDuration: kTabScrollDuration,
            categoryIcons: CategoryIcons(),
            buttonMode: ButtonMode.MATERIAL));
  }
}
