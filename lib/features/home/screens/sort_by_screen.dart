import 'package:flutter/material.dart';
import 'package:gocolis/constants/global_variables.dart';

class SortedBy extends StatefulWidget {
  final String sortedBy;
  const SortedBy({Key? key, required this.sortedBy}) : super(key: key);

  @override
  State<SortedBy> createState() => _SortedByState();
}

class _SortedByState extends State<SortedBy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title:const Text(
            "widget.category",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: const Text(
              'keep shopping for widget.category TOOOOOOOO REPLACE',
              style: TextStyle(),              
            ),
            
          ),
        ]
      ),
    );
  }
}
