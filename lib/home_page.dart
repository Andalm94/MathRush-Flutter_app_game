// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:math_flutter/const.dart';
import 'package:math_flutter/final_page.dart';
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


  //============================= GAME VARIABLES ===================================

  //Animation
  late AnimationController lottieController;
  bool lottieFinished = false;

  //Exp and Timer
  late Timer _timer;
  int timerCount = 10;
  int currentExp = 0;

  //Leveling
  late int currentLvl;
  late int score;
  bool lvlUp = false;
  
  //Question
  late int numberA;
  late int numberB;
  late String operation;
  late String question;
  late String userAnswer;
  var randomNumber = Random();

  //================================================================================







  //============================== FUNCTIONS =======================================

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
        setCurrentExp(true, 0, 0);
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
        equalPressed();
        userAnswer = '';
      }else if(button == 'C'){
        userAnswer = '';
        userAnswer = solveOperation(numberA, numberB, operation).toString(); // DELETE THIS LINE AFTER DEBUG
      } else if (button == 'DEL' && userAnswer.isNotEmpty){
        userAnswer = userAnswer.substring(0, userAnswer.length-1);
      } else if(userAnswer.length < 3 && button != 'DEL' && button != 'C'){
        userAnswer += button;
      }


    });
  }


  void equalPressed(){
    bool answerIsCorrect = checkResult();
    
    setCurrentExp(answerIsCorrect, 1, 5);
    setScore(answerIsCorrect);

    //If the game is completed, we push to the final score page
    if(currentLvl >= 5){
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => FinalPage(score: score))
        )
      );

    }




    //If the player reached 100exp, show a lvlUp lottie and ser currentLvl++
    //Otherwise, we show a success/fail lottie.
    print('CurrentExp : $currentExp');
    print('answerIsCorrect : $answerIsCorrect');
    if(currentExp >= 100){
      currentLvl ++;
      currentExp = 0;

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
              child: Lottie.asset(
                'assets/lotties/lvlUpLottie.json',
                fit: BoxFit.contain
              )
            )
        );
        }
      ).then((val){
        if (_timer.isActive) {
          _timer.cancel();
        }
      });


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
              child: answerIsCorrect ? 
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


  }

  bool checkResult() {
    double correctResult = solveOperation(numberA, numberB, operation);
    double answer = double.parse(userAnswer);  
    return correctResult==answer;
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


  void setScore(bool answerIsCorrect){
    setState(() {
      if(answerIsCorrect == true){
        score += timerCount;  
      }else{
        score += timerCount;
      }
      
    });
  }

  void setCurrentExp(bool success, int expInSuccess, int expInFail){
    
    if(success == false){
      currentExp -= expInFail;
      if(currentExp < 0){
        currentExp = 0;
      }
    }
    else{
      if(currentExp >= 0 && currentExp < 100){
        setState(() {
          switch(currentLvl){
            case 0:
              currentExp += expInSuccess * 25;
              break;
            case 1:
              currentExp += expInSuccess * 20;
              break;
            case 2:
              currentExp += expInSuccess * 20;
              break;
            case 3:
              currentExp += expInSuccess * 15;
              break;
            case 4:
              currentExp += expInSuccess * 15;
              break;
            case 5:
              currentExp += expInSuccess * 10;
              break;
          }
        });
      }
    }




  }




  //================================================================================
  







  //=============================== WIDGET BUILD ===================================
  @override
  void initState() {
    super.initState();
    
    //Initialize variables

    currentLvl = 0;
    score = 0;
    userAnswer = '';

    createQuestion();
    countDown();

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
                MyLevelBox(complete: currentLvl>=1),
                MyLevelBox(complete: currentLvl>=2),
                MyLevelBox(complete: currentLvl>=3),
                MyLevelBox(complete: currentLvl>=4),
                MyLevelBox(complete: currentLvl>=5),
                
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