import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  
  final String currentPercentage;

  const ProgressBar({super.key, required this.currentPercentage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(Icons.arrow_circle_up),
    
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 60,
            center: Text('$currentPercentage %'),
            animation: true,
            animationDuration: 100,
            animateFromLastPercent: true,
            lineHeight: 20,
            percent: double.parse(currentPercentage) / 100,
            progressColor: Colors.amber,
            backgroundColor: Colors.amber.shade200,
          )

        ]
      ),
    );
  }
}

