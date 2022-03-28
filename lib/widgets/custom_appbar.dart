import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sih_2022_sahaye/Models/local_storage.dart';
import 'package:sih_2022_sahaye/Screens/app_getting_started_screen.dart';
import 'package:sih_2022_sahaye/widgets/custom_text_widget.dart';


AppBar cutomAppBar({required bool isLoggedIn,required BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 10.0,
      title: Image.asset(
        "assets/images/logo.png",
        width: 100.w,
      ),
      actions: [
        if(isLoggedIn)
        PopupMenuButton(
          enableFeedback: true,
          onSelected: (index){
            if(index==0)
              {
                final obj=UserModel();
                obj.deleteUserId().then((value){
                  Navigator.popUntil(context, (route) => false);
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>const GettingStartedScreen()));
                });
              }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: 0,
                child: CustomTextWidget(txt: "LOG OUT",clr: Colors.black,),
              )
            ];
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
