import 'package:flutter/material.dart';
import 'package:math_flutter/const.dart';

class MyButton extends StatefulWidget {
  final String child;
  final VoidCallback onTap; 
  
  const MyButton({super.key, required this.child, required this.onTap});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  var buttonColor = Colors.blue;

  @override
  Widget build(BuildContext context) {

    if(widget.child == 'C'){
      buttonColor = Colors.green;
    }
    else if(widget.child == 'DEL'){
      buttonColor = Colors.red;
    }



    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: buttonColor,

          ),
      
          child: Center(
            child: Text(
              widget.child,
              style: whiteTextStyle
            )
          ),
        ),
      ),
    );
  }
}