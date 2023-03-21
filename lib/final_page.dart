import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';
import 'package:math_flutter/menu_page.dart';
import 'home_page.dart';

class FinalPage extends StatefulWidget {
  final int score;
  
  const FinalPage({super.key, required this.score});

  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        
        children: [

          //tittle
          const Center(
            child: Text(
              'Thanks for playing!',
              style: TextStyle(fontFamily: 'SingleDay', fontSize: 40, fontWeight: FontWeight.w700),
              )
          ),

          //Lottie
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Lottie.asset('assets/lotties/winLottie.json', fit: BoxFit.contain)
          ),


          //CongratsText
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.25,
            child: const Text(
              'Congratulations on beating all the levels! \nYour final score is:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'ArchitectsDaughter',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ), 
            )
          ),

          //FinalScore
          Container(
            decoration: BoxDecoration(
              color: Colors.amber[400],
              borderRadius: BorderRadius.circular(15)
            ),
            width: MediaQuery.of(context).size.width / 1.25,
            child:  Text(
              widget.score.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'PatrickHand',
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ), 
            )
          ),


          //button
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(200, 40)),
                textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 30)),
              ),
              child: const Text('Main menu', style: TextStyle(fontFamily: 'PatrickHand')), //SingleDay PatrickHand-Regular
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const MenuPage())
                  )
                );
              },
            ),
          ),


        ],
      )
    );
  }
}