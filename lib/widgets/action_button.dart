import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';


class ActionButton extends StatelessWidget {
  ActionButton({Key? key, required this.text, this.color = Colorpalette.mediumPurple, this.onPressed})
      : super(key: key);
  void Function()? onPressed = () {};
  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ??
          () {
            log("not implemented");
          },
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.resolveWith((states) => Size.fromWidth(200.w)),
          padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(horizontal: 25)),
          backgroundColor: MaterialStateProperty.resolveWith((states) => color),
          shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(10),
              )))),
    );
  }
}
