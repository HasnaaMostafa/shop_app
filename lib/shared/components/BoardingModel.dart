import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoxFit? fit;

   BoardingModel({
    this.fit,
    required this.image,
    required this.title,
    required this.body});
}

void showToast({
  required String message,
  required ToastStates state})=> Fluttertoast.showToast(
  msg: message,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor:chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 15,
);

enum ToastStates{success,error,warning}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state)
  {
    case ToastStates.success:
      color= Colors.green;
      break;
    case ToastStates.error:
      color= Colors.red;
      break;
    case ToastStates.warning:
      color=Colors.amber;
      break;
  }
  return color;
}
