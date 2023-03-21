import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:math_flutter/home_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  
  //AudioCache audioCache = AudioCache();
  

  @override
  void initState(){
    super.initState();
    //audioCache.loop('audio1.mp3');

    super.dispose;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          const SizedBox(
            height: 50,
          ),

          //tittle
          const Center(
            child: Text(
              'Math Rush!',
              style: TextStyle(fontFamily: 'SingleDay', fontSize: 75, fontWeight: FontWeight.w700),
              )
          ),


          //logo
          Center(
            child: Lottie.asset('assets/lotties/logo.json'),
          ),

          //button
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(200, 40)),
                textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 30)),
              ),
              child: const Text('Go!', style: TextStyle(fontFamily: 'PatrickHand')), //SingleDay PatrickHand-Regular
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const HomePage())
                  )
                );
              },
            ),
          ),

          const SizedBox(
            height: 40,
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: const Text('V 0.1.0  \nBy Andres Almeida')
            ),
          )

        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.info_outline),
        onPressed:() {
          showDialog(
            context: context,
            builder: (BuildContext builderContext){
              return AlertDialog(
                backgroundColor: Colors.amber[100],
                title: const Text('Instructions', style: TextStyle(fontFamily: 'ArchitectsDaughter', fontWeight: FontWeight.w600)),
                content: const Text('You must solve the questions quickly. The time is running out! \n\nEach level you up, the questions will be more difficult. \n\nTry to complete all levels. \n\nGood luck!',
                style: TextStyle(fontFamily: 'ArchitectsDaughter'),) ,
                actions: [

                  ElevatedButton(
                    child: const Text('Got it!'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            }
          );
        },
      ),

    );
  }
}