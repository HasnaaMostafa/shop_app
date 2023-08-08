
import 'package:flutter/material.dart';

class appButton extends StatelessWidget {
  final String text;
  final Color background;
  final Color textColor;
  final VoidCallback? function;
  double size;

  appButton({Key? key,
    required this.text,
    required this.background,
    required this.size,
    required this.textColor,
    this.function,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10.0)
        
      ),
      child: MaterialButton(onPressed
          : function ,
        child:
         Text(
             text,style: TextStyle(color: textColor),
          ),
        ),


    );
  }
}




