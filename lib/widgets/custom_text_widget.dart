import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/size_config.dart';
class CustomTextWidget extends StatelessWidget {
  final String txt;
  final int maxLines;
  final double fontSize;
  final FontWeight weight;
  final Color clr;
  final bool isUnderLine;
  final bool isCenter;
  const CustomTextWidget({Key? key, required this.txt, this.maxLines=1,this.fontSize=14, this.weight=FontWeight.w700, required this.clr, this.isUnderLine=false, this.isCenter=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Text(
      txt,
      maxLines:maxLines,
      textAlign: isCenter?TextAlign.center:null,
      style: TextStyle(
        color:clr,
        fontSize: fontSize*SizeConfig.safeBlockHeight,
        fontWeight: weight,
        fontFamily: GoogleFonts.outfit().fontFamily,
        decoration: isUnderLine?TextDecoration.underline:null,
        decorationThickness: 2
      ),

    );
  }
}
