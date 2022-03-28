import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    // SizeConfig().init(context);
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 0),
            child: Image.asset("assets/images/logo1.png"),
          ),
          SizedBox(
            height: 50.h,
          ),
          Stack(
            children: [
              SizedBox(
                height: 310.h,
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: SvgPicture.string(
                    ''''<svg width="428" height="563" viewBox="0 0 428 563" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M-1 40L429 0L461 588H-1V40Z" fill="#E6D5FF"/>
<path d="M428 189L-2 149L-34 737H428V189Z" fill="#CBA7FF"/>
<path d="M-1 354L429 314L461 902H-1V354Z" fill="#A972FF"/>
</svg>
''',
                    height: 100.h,
                  ),
                ),
              ),
              Positioned.fill(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  const Flexible(
                    child: CustomTextWidget(
                      txt: "Welcome To\nSAHAYA",
                      clr: Colors.white,
                      fontSize: 30,
                      maxLines: 2,
                      isCenter: true,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UserRole()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            color: const Color(0XFF5423A1),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: const [BoxShadow(color: Colors.white, blurRadius: 10)]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            CustomTextWidget(
                              txt: "GET STARTED",
                              clr: Colors.white,
                              fontSize: 12,
                            ),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}

// class BezierClipper extends CustomClipper<Path> {
//   final Function path;
//   BezierClipper({required this.path});
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;

//   @override
//   Path getClip(Size size) {
//     return path(size);
//   }
// }
