import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gocolis/constants/global_variables.dart';

class ReplyFileImageCard extends StatelessWidget {
  final String filePath;
  final String message;
  final String time;
  const ReplyFileImageCard({Key? key, required this.filePath, required this.message, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal : 15, vertical: 5),
        child: Container(
          height: MediaQuery.of(context).size.height / 2.3,
          width: MediaQuery.of(context).size.width / 1.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Card(
            margin: EdgeInsets.all(3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    "$uri/uploads/$filePath",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                message.length > 0
                  ? Container(
                    height: 40,
                    padding: const EdgeInsets.only(left: 15, top: 8),
                    child: Text(
                      message,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15, 
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                  : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
