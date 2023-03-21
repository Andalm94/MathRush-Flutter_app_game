// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyLevelBox extends StatefulWidget {
  MyLevelBox({super.key, required this.complete});
  bool complete;

  @override
  State<MyLevelBox> createState() => _MyLevelBoxState();
}

class _MyLevelBoxState extends State<MyLevelBox> {
  final lvlNotCompleteBox = Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );

  final lvlCompleteBox = Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.green[800],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Image.asset('assets/images/tic.png', fit: BoxFit.contain), //fit: BoxFit.contain
    ),
  );

  @override
  Widget build(BuildContext context) {
    if(widget.complete){
      return lvlCompleteBox;
    }
    else{
      return lvlNotCompleteBox;
    }
    

  }
}