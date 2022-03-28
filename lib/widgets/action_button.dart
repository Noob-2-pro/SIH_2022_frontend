import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class ActionButton extends StatelessWidget {
  ActionButton({
    Key? key,
    required this.text,
    this.color = Colorpalette.mediumPurple,
    this.onPressed,
    this.svgString,
  }) : super(key: key);
  void Function()? onPressed = () {};
  final String text;
  final Color color;
  final String? svgString;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ??
          () {
            log("not implemented");
          },
      child: Container(
        width: 90.w,
        height: 200.h,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              svgString != null ? SvgPicture.string(svgString!) : Container(),
              SizedBox(
                height: 10.h,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(horizontal: 25)),
          backgroundColor: MaterialStateProperty.resolveWith((states) => color),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
          )),
    );
  }
}
