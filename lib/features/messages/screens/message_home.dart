import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/features/messages/screens/camera_page.dart';
import 'package:gocolis/features/messages/screens/chat_page.dart';
import 'package:gocolis/features/messages/screens/status_page.dart';
import 'package:gocolis/models/chat.dart';

class MessageHome extends StatefulWidget {
  final List<Chat> chats;
  final Chat sourceChat;
  final Function onImageSend;
  const MessageHome({Key? key, required this.chats, required this.sourceChat, required this.onImageSend})
      : super(key: key);

  @override
  State<MessageHome> createState() => _MessageHomeState();
}

class _MessageHomeState extends State<MessageHome>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "Chat",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          const IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: null,
              color: Colors.white),
          /*IconButton(
              icon: Icon(Icons.more_vert), onPressed: null, color: Colors.white)*/
          PopupMenuButton<String>(onSelected: (value) {
            print(value);
          }, itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: "New group",
                child: Text("New group"),
              ),
              const PopupMenuItem(
                value: "New broadcast",
                child: Text("New broadcast"),
              ),
              const PopupMenuItem(
                value: "Whatsapp web",
                child: Text("Whatsapp web"),
              ),
              const PopupMenuItem(
                value: "Starred messages",
                child: Text("Starred messages"),
              ),
              const PopupMenuItem(
                value: "Settings",
                child: Text("Settings"),
              ),
            ];
          })
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: kPrimaryColor,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          CameraPage(onImageSend: widget.onImageSend,),
          ChatPage(
            chats: widget.chats,
            sourceChat: widget.sourceChat,
          ),
          StatusPage(),
          Text("Calls"),
        ],
      ),
    );
  }
}
