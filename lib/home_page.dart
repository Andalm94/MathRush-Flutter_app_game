// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:math_flutter/const.dart';
import 'package:math_flutter/final_page.dart';
import 'package:math_flutter/test_page.dart';
import 'package:math_flutter/util/my_button.dart';
import 'package:math_flutter/util/my_level_box.dart';
import 'package:math_flutter/util/my_progress_bar.dart';
import 'package:math_flutter/util/my_timer.dart';
import 'package:math_flutter/util/question_generator.dart';
//aimport 'package:math_flutter/util/question_generator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  //ANIMATION
  late AnimationController lottieController;
  bool lottieFinished = false;
  int score = 0;
  
  String userAnswer = '';

  var randomNumber = Random();
  int numberA = 1;
  int numberB = 1;
  String operation = '';
  String question = '';

  int currentExp = 0;
  int currentLvl = 0;
  bool lvl1Complete = false;
  bool lvl2Complete = false;
  bool lvl3Complete = false;
  bool lvl4Complete = false;
  bool lvl5Complete = false;
  bool gameComplete = false;

  var timerCount = 10;

  bool successLottieIsVisible = false; 

   bool lvlUp = false;

  late Timer _timer;

  void countDown(){
    
    Timer.periodic(const Duration(seconds: 1), (timer) {
      
      if(timerCount>0 ){
        if(mounted){
          setState(() {
            timerCount--;    
          });
        } 

      }
      if(timerCount==0){
        setCurrentExp(false);
        createQuestion();
        setState(() {
          timerCount = 10;    
        });
      }
      
    });
  }


  void buttonTapped(String button){
    
    setState((){
      // C and DEL behavior
      // limit to 3 the maximum lenght of user input
      if(button == '='){
        checkResult();
        userAnswer = '';
      }else if(button == 'C'){
        //userAnswer = '';
        userAnswer = resolverPregunta(numberA, numberB, operation).toString();
      } else if (button == 'DEL' && userAnswer.isNotEmpty){
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const Test())
          )
        );

        userAnswer = userAnswer.substring(0, userAnswer.length-1);
      } else if(userAnswer.length < 3 && button != 'DEL' && button != 'C'){
        userAnswer += button;
      }


    });
  }

  void checkResult() {

    double correctResult = 0;
    double answer = double.parse(userAnswer);

    //The program calculates the correct answer
    switch(operation){
      case '+':
        correctResult = double.parse((numberA + numberB).toString());
        break;
      case '-':
        correctResult = double.parse((numberA - numberB).toString());
        break;
      case 'x':
        correctResult = double.parse((numberA * numberB).toString());
        break;
      case '/':
        correctResult = double.parse((numberA / numberB).toString());
        break;
        
    }

    //Determinate if the user have answered correctly
    bool result = correctResult==answer;


    //Update exp
    setCurrentExp(result);
    setScore();
    
    //Show lottie
    if(lvlUp == true && gameComplete == true){

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => FinalPage(score: score))
        )
      );

      lvlUp = false;



    }else{

      showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (BuildContext builderContext) {
          _timer = Timer(const Duration(milliseconds: 750), () {
            Navigator.of(context).pop();
          });

          return Center(
            child:  Container(
              color: Colors.transparent,
              width: 175,
              child: result ? 
              Lottie.asset(
                'assets/lotties/ticLottie.json',
                fit: BoxFit.contain
              )
              :
              Lottie.asset(
                'assets/lotties/failLottie.json',
                fit: BoxFit.contain
              ),
            )
        );
        }
      ).then((val){
        if (_timer.isActive) {
          _timer.cancel();
        }
      });
    }
    
    print('CurrentLvl: $currentLvl');
    print('gameComplete: $gameComplete'); 

    //Create a new question
    if(gameComplete == true){

    }else{
      createQuestion();
    }


    



  }


  void createQuestion(){
    
    
    var array = generateQuestion(currentLvl);
    setState(() {
      numberA = int.parse(array[0].toString());
      operation = array[1].toString();
      numberB = int.parse(array[2].toString());
      timerCount = 10;
      question = '$numberA $operation $numberB =';
      

    });

  }

  double resolverPregunta(numberA, numberB, operation){
      
    double correctResult = 0;

    switch(operation){
      case '+':
        correctResult = double.parse((numberA + numberB).toString());
        break;
      case '-':
        correctResult = double.parse((numberA - numberB).toString());
        break;
      case 'x':
        correctResult = double.parse((numberA * numberB).toString());
        break;
      case '/':
        correctResult = double.parse((numberA / numberB).toString());
        break;
    }
    return correctResult;
  }


  void setScore(){
    setState(() {
      score += timerCount;
    });
  }

  void setCurrentExp(bool success){
    
    if(success == false){
      currentExp -= 5;
      if(currentExp < 0){
        currentExp = 0;
      }
    }
    else{
      if(currentExp >= 0 && currentExp < 100){
        setState(() {
          switch(currentLvl){
            case 0:
              currentExp += 100;
              break;
            case 1:
              currentExp += 100;
              break;
            case 2:
              currentExp += 100;
              break;
            case 3:
              currentExp += 100;
              break;
            case 4:
              currentExp += 100;
              break;
          }
        });
      }
    }

    if(currentExp >= 100){
      setLvlUp();
      lvlUp = true;
      currentExp = 0;
    }


  }



  
  //WIDGET BUILD
  @override
  void initState() {
    super.initState();
    createQuestion();
    countDown();
    score = 0;

    lottieController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10)
    );

    lottieController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        setState(() {
          lottieFinished = true;
          status = AnimationStatus.dismissed;
          Navigator.pop(context);
        });
      }      
    });

  }

  void setLvlUp(){
    setState(() {

      switch(currentLvl){
        case 0:
          lvl1Complete = true;
          lvl2Complete = false;
          lvl3Complete = false;
          lvl4Complete = false;
          lvl5Complete = false;
          break;
        case 1:
          lvl1Complete = true;
          lvl2Complete = true;
          lvl3Complete = false;
          lvl4Complete = false;
          lvl5Complete = false;
          break;
        case 2:
          lvl1Complete = true;
          lvl2Complete = true;
          lvl3Complete = true;
          lvl4Complete = false;
          lvl5Complete = false;
          break;
        case 3:
          lvl1Complete = true;
          lvl2Complete = true;
          lvl3Complete = true;
          lvl4Complete = true;
          lvl5Complete = false;
          break;
        case 4:
          gameComplete = true;
          break;
      }
      currentLvl++; 

      
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Column(
        children: [

          //List of lvls
          Container(
            height: 70,
            color: Colors.blue,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(5),
              crossAxisCount: 5,
              
              crossAxisSpacing: 5,
              children: [
                MyLevelBox(complete: lvl1Complete),
                MyLevelBox(complete: lvl2Complete),
                MyLevelBox(complete: lvl3Complete),
                MyLevelBox(complete: lvl4Complete),
                MyLevelBox(complete: lvl5Complete),
                
              ],
            ),
          ),

          
          //lvl progress
          Container(
            height: 50,
            color: Colors.blue,
            child:  ProgressBar(currentPercentage: currentExp.toString())
          ),
                    
          //timer
          Container(
            height: 50,
            color: Colors.blue,
            child:  MyTimer(currentTime: timerCount, totalTime: 10)
          ),

          Text('Score: $score', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          

          //question
          Expanded(
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //question
                Text(
                  question,
                  style: whiteTextStyle
                ),

                //answerbox
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Center(child: Text(userAnswer, style: whiteTextStyle)),
                )


              ],
            )
         

          ),

          //number pad
          Expanded(
            flex: 2,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: numberPad.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (context, index) {
                return MyButton(
                  child: numberPad[index].toString(),
                  onTap: () => buttonTapped(numberPad[index].toString()),
                );
              },
            )
          )


        ],
      ),
    );
  }
  

}