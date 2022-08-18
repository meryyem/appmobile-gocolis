import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';

class MessageHome extends StatefulWidget {
  const MessageHome({Key? key}) : super(key: key);

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
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(child: Text("New group"), value: "New group"),
                const PopupMenuItem(child: Text("New broadcast"), value: "New broadcast"),
                const PopupMenuItem(child: Text("Whatsapp web"), value: "Whatsapp web"),
                const PopupMenuItem(child: Text("Starred messages"), value: "Starred messages"),
                const PopupMenuItem(child: Text("Settings"), value: "Settings"),
              ];
          })
        ],
        bottom: TabBar(
          controller: _controller,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "Chats",
            ),
            Tab(
              text: "Status",
            ),
            Tab(
              text: "Calls",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          Text("Camera"),
          Text("Chats"),
          Text("Status"),
          Text("Calls"),
        ],
      ),
    );
  }
}
