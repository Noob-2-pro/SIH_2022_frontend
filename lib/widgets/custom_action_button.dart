import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Screens/users/enroll_update_screen.dart';
import 'custom_text_widget.dart';


 Widget btnContainer({required Color clr,required String svg,required String title,required int index,required BuildContext context}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          if(index==0 || index==1)
            {
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>EnrollUpdateScreen(index: index)));
            }

        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical:20),
          decoration: BoxDecoration(
            color: clr,
            borderRadius: BorderRadius.circular(16),
          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.string(svg),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Flexible(child: CustomTextWidget(txt:title, clr: const Color(0XFF464444),fontSize:14,maxLines: 2,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }