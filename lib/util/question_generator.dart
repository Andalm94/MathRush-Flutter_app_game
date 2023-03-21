import 'dart:math';

int numberA = 0;
int numberB = 0;
var randomNumber = Random();


List<String> operations = ['+', '-', 'x', '/'];
String operation = '+';

double answer = 0;

bool answerWithDecimals = false;
bool invalidQuestion = false;


List<Object> generateQuestion(int level){


  do{
    invalidQuestion = false;
    answerWithDecimals = false;

    switch(level){

      case 0:
        numberA = randomNumber.nextInt(5);
        numberB = randomNumber.nextInt(5);
        operation = operations[randomNumber.nextInt(2)];
        answer = solveOperation(numberA, numberB, operation);
        if(answer<0 || numberB == 0){
          invalidQuestion = true;
        }
        break;

      case 1:
        numberA = randomNumber.nextInt(10);
        numberB = randomNumber.nextInt(10);
        operation = operations[randomNumber.nextInt(2)];
        answer = solveOperation(numberA, numberB, operation);
        if(answer<0 || numberB == 0){
          invalidQuestion = true;
        }
        break;
      
      case 2:
        numberA = randomNumber.nextInt(10);
        numberB = randomNumber.nextInt(10);
        operation = operations[randomNumber.nextInt(3)];
        answer = solveOperation(numberA, numberB, operation);
        answerWithDecimals = answer%1!=0;
        if(answer<0 || numberB==0 || answerWithDecimals==true){
          invalidQuestion = true;
        }
        break;
      
      case 3:
        numberA = randomNumber.nextInt(20);
        numberB = randomNumber.nextInt(10);
        operation = operations[randomNumber.nextInt(3)];
        answer = solveOperation(numberA, numberB, operation);
        answerWithDecimals = answer%1!=0;
        if(answer<0 || numberB==0 || answerWithDecimals==true){
          invalidQuestion = true;
        }
        break;
      
      case 4:
        numberA = randomNumber.nextInt(20);
        numberB = randomNumber.nextInt(10);
        operation = operations[randomNumber.nextInt(4)];
        answer = solveOperation(numberA, numberB, operation);
        answerWithDecimals = answer%1!=0;
        if(answer<0 || numberB==0 || answerWithDecimals==true){
          invalidQuestion = true;
        }
        break;
      
      case 5:
        numberA = randomNumber.nextInt(30);
        numberB = randomNumber.nextInt(10);
        operation = operations[randomNumber.nextInt(4)];
        answer = solveOperation(numberA, numberB, operation);
        answerWithDecimals = answer%1!=0;
        if(answer<0 || numberB==0 || answerWithDecimals==true){
          invalidQuestion = true;
        }
        break;


    }

  }while(invalidQuestion == true);

  return [numberA, operation, numberB];
}


double solveOperation(int numberA, int numberB, String operation) {

  double correctResult = 0;

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
  return correctResult;

}
