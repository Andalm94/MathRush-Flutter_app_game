import 'dart:async';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  bool lottieIsVisible = false;

  showLottie() {
    setState(() {
      lottieIsVisible = true;
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        lottieIsVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          // Game UI goes here
          Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            height: double.infinity,
            child: ElevatedButton(
              onPressed: showLottie,
              child: const Text(
                'Show Lottie',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          lottieIsVisible
          // The overlay
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.2),
                )
              : Container(),
          lottieIsVisible



          // The Lottie
              ? Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    padding: const EdgeInsets.all(24.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: const Text(
                      'Lottie goes her',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : Container()

              
        ],
      ),
    );
  }
}