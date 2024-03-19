import 'package:flutter/material.dart';
import 'package:hangman/const/const.dart';

Widget hiddenLetter(String char, bool visible) {
  return Container(
    alignment: Alignment.center,
    height: 50,
    width: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), color: Colors.black),
    child: Visibility(
        visible: !visible,
        child: Text(
          char,
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.bgColor),
        )),
  );
}
