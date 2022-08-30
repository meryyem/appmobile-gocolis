import 'package:flutter/material.dart';

import '../../../common/widgets/status/head_own_status.dart';
import '../../../common/widgets/status/others_status.dart';
import '../../../constants/colors.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Container(
          height: 48,
          child: FloatingActionButton(
              backgroundColor: kPrimaryColor,
              onPressed: () {},
              child: const Icon(
                Icons.edit,
                color: kSecondaryColor,
              )),
        ),
        const SizedBox(
          height: 13,
        ),
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: kPrimaryColor,
          elevation: 5,
          child: const Icon(Icons.camera_alt),
        )
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //SizedBox(height: 10,),
            HeadOwnStatus(),
            label("Recent Updates"),
            Container(
              height: 33,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300],
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                child: Text("Recent Updates",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            const OthersStatus(
                name: "Sakly",
                imageName: "assets/images/profile.png",
                time: "01:27",
                isSeen: false,
                statusNum: 1,
                ),
            const OthersStatus(
                name: "Maryem",
                imageName: "assets/images/profile.png",
                time: "00:27",
                isSeen: false,
                statusNum: 2,
                ),
            const OthersStatus(
                name: "Sakly Maryem",
                imageName: "assets/images/profile.png",
                time: "01:00",
                isSeen: false,
                statusNum: 3,
            ),
            const SizedBox(height: 10),
            label("Viewed Updates"),
            const OthersStatus(
                name: "Sakly",
                imageName: "assets/images/profile.png",
                time: "01:27",
                isSeen: true,
                statusNum: 1,
              ),
            const OthersStatus(
                name: "Maryem",
                imageName: "assets/images/profile.png",
                time: "00:27",
                isSeen: true,
                statusNum: 2,
                ),
            const OthersStatus(
                name: "Sakly Maryem",
                imageName: "assets/images/profile.png",
                time: "01:00",
                isSeen: true,
                statusNum: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget label(String labelName) {
    return Container(
      height: 33,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        child: Text(
          labelName,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
