import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sih_2022_sahaye/Screens/Authentication/login_screen.dart';
import 'package:sih_2022_sahaye/Screens/user_role_screen.dart';
import 'package:sih_2022_sahaye/widgets/custom_text_widget.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sih_2022_sahaye/Models/size_config.dart';
import 'package:sih_2022_sahaye/Screens/user_role_screen.dart';
import 'package:sih_2022_sahaye/widgets/custom_text_widget.dart';
class GettingStartedScreen extends StatefulWidget {
  const GettingStartedScreen({Key? key}) : super(key: key);

  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
             Padding(
               padding: const EdgeInsets.only(top: 50,bottom: 0),
               child: Image.asset("assets/images/logo1.png",height: 200,width: 300,),
             ),
              const SizedBox(height: 200,),
              Expanded(
                child: Stack(
                children: [
                  SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: SvgPicture.string(''''<svg width="428" height="563" viewBox="0 0 428 563" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M-1 40L429 0L461 588H-1V40Z" fill="#E6D5FF"/>
<path d="M428 189L-2 149L-34 737H428V189Z" fill="#CBA7FF"/>
<path d="M-1 354L429 314L461 902H-1V354Z" fill="#A972FF"/>
</svg>
'''
                      ),
                    ),
                  ),
                   Positioned.fill(child:
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const SizedBox(height: 20,),
                /*      const CustomTextWidget(
                            txt: "Welcome To\nSAHAYA",
                            clr: Colors.white,
                            fontSize: 10,
                            maxLines: 2,
                            isCenter: true,
                          ),*/
                          InkWell(
                            onTap: (){
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const UserRole()),
                              );*/
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen(index: 0)),
                              );

                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                decoration: BoxDecoration(
                                  color: const Color(0XFF5423A1),
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: const [BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 10
                                  )
                                  ]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    CustomTextWidget(txt: "GET STARTED",clr: Colors.white,fontSize: 20,),
                                    Icon(Icons.arrow_forward,color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                  ))
                ],
            ),
              ),
          ],
        ),
      ),
    );
  }
}
class BezierClipper  extends CustomClipper<Path>{
  final Function path;
  BezierClipper({required this.path});
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  @override
  Path getClip(Size size) {
   return path(size);
  }

}
