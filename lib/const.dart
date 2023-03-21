import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


var whiteTextStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 32);

List<String> numberPad = [
  '7', '8', '9', 'C',
  '4', '5', '6', 'DEL',
  '1', '2', '3', ' ',
  '0', '.', '', '='
];

List<String> operations = ['+', '-', 'x', '/'];

var lottieSuccess = Lottie.network(
  'https://assets8.lottiefiles.com/packages/lf20_zwkm4xbs.json', 
  repeat: true, 
  animate: true,
  frameRate: FrameRate(120),
  fit: BoxFit.fill,
);

var lottieError = Lottie.network(
  'https://assets2.lottiefiles.com/temp/lf20_QYm9j9.json', 
  repeat: true, 
  animate: true,
  frameRate: FrameRate(120),
  fit: BoxFit.fill,
);

