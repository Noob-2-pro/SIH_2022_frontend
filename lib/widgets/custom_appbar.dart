import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


AppBar cutomAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 10.0,
      title: Image.asset(
        "assets/images/logo.png",
        width: 100.w,
      ),
      actions: [
        GestureDetector(
          onTap: () {
            log("menu pressed");
          },
          child: const Padding(
            padding:  EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
