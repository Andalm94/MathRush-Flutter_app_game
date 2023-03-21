import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MyTimer extends StatelessWidget {
  
  final int currentTime;
  final int totalTime;

  const MyTimer({super.key, required this.currentTime, required this.totalTime});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(Icons.timer_sharp),
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 60,
            center: Text(currentTime.toString()),
            animation: true,
            animationDuration:1000,
            animateFromLastPercent: true,
            lineHeight: 20,
            percent: (currentTime/totalTime),
            progressColor: Colors.purple,
            backgroundColor: Colors.purple.shade200,
          ),
        ],
      ),
    );
  }
}

