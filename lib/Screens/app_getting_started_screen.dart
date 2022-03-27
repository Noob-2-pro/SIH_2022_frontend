import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
    return   Scaffold(

      appBar:null,
      body: Column(
        children: [
           Padding(
             padding: const EdgeInsets.only(top: 30,bottom: 0),
             child: Image.asset("assets/images/logo1.png"),
           ),
            const SizedBox(height: 200,),
            Stack(
            children: [
            /*  ClipPath(
                clipper: BezierClipper(path: (size){
                  Path path = Path();
                  final double _xScaling = size.width / 428;
                  final double _yScaling = size.height / 588;
                  path.lineTo(-1 * _xScaling,40 * _yScaling);
                  path.cubicTo(-1 * _xScaling,40 * _yScaling,429 * _xScaling,0 * _yScaling,429 * _xScaling,0 * _yScaling,);
                  path.cubicTo(429 * _xScaling,0 * _yScaling,461 * _xScaling,588 * _yScaling,461 * _xScaling,588 * _yScaling,);
                  path.cubicTo(461 * _xScaling,588 * _yScaling,-1 * _xScaling,588 * _yScaling,-1 * _xScaling,588 * _yScaling,);
                  path.cubicTo(-1 * _xScaling,588 * _yScaling,-1 * _xScaling,40 * _yScaling,-1 * _xScaling,40 * _yScaling,);
                  path.cubicTo(-1 * _xScaling,40 * _yScaling,-1 * _xScaling,40 * _yScaling,-1 * _xScaling,40 * _yScaling,);
                  return path;
                }
                ),
                child:Container(
                  color : const Color(0XFFFD5A58),
                  height: 50*SizeConfig.safeBlockHeight,
                ),
              ),
              ClipPath(
                clipper: BezierClipper(path: (size){
                  Path path = Path();
                  final double _xScaling = size.width / 428;
                  final double _yScaling = size.height / 563;
                  path.lineTo(-1 * _xScaling,40 * _yScaling);
                  path.cubicTo(-1 * _xScaling,40 * _yScaling,429 * _xScaling,0 * _yScaling,429 * _xScaling,0 * _yScaling,);
                  path.cubicTo(429 * _xScaling,0 * _yScaling,461 * _xScaling,588 * _yScaling,461 * _xScaling,588 * _yScaling,);
                  path.cubicTo(461 * _xScaling,588 * _yScaling,-1 * _xScaling,588 * _yScaling,-1 * _xScaling,588 * _yScaling,);
                  path.cubicTo(-1 * _xScaling,588 * _yScaling,-1 * _xScaling,40 * _yScaling,-1 * _xScaling,40 * _yScaling,);
                  path.cubicTo(-1 * _xScaling,40 * _yScaling,-1 * _xScaling,40 * _yScaling,-1 * _xScaling,40 * _yScaling,);
                  return path;
                }
                ),
                child:Container(
                  color : const Color(0XFF2D01AD),
                  height: 300*SizeConfig.safeBlockHeight,
                ),
              ),
              ClipPath(
                clipper: BezierClipper(path: (size){
                  Path path = Path();
                  final double _xScaling = size.width / 428;
                  final double _yScaling = size.height / 414;
                  path.lineTo(428 * _xScaling,40 * _yScaling);
                  path.cubicTo(428 * _xScaling,40 * _yScaling,-2 * _xScaling,0 * _yScaling,-2 * _xScaling,0 * _yScaling,);
                  path.cubicTo(-2 * _xScaling,0 * _yScaling,-34 * _xScaling,588 * _yScaling,-34 * _xScaling,588 * _yScaling,);
                  path.cubicTo(-34 * _xScaling,588 * _yScaling,428 * _xScaling,588 * _yScaling,428 * _xScaling,588 * _yScaling,);
                  path.cubicTo(428 * _xScaling,588 * _yScaling,428 * _xScaling,40 * _yScaling,428 * _xScaling,40 * _yScaling,);
                  path.cubicTo(428 * _xScaling,40 * _yScaling,428 * _xScaling,40 * _yScaling,428 * _xScaling,40 * _yScaling,);
                  return path;
                }
                ),
                child:Container(
                  color : const Color(0XFF3C07C2),
                  height: 300*SizeConfig.safeBlockHeight,
                ),
              ),*/
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: SvgPicture.string(''''<svg width="428" height="593" viewBox="0 0 428 593" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M-1 40L429 0L461 588H-1V40Z" fill="#FD5A58"/>
                  <path d="M-1 70L429 30L461 618H-1V70Z" fill="#2D01AD"/>
                  <path d="M428 219L-2 179L-34 767H428V219Z" fill="#3C07C2"/>
                  <path d="M-1 384L429 344L461 932H-1V384Z" fill="#4A12DE"/>
                  </svg>'''
                  ),
                ),
              ),
               Positioned.fill(child:
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                children:  [
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
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserRole()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
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
                                CustomTextWidget(txt: "GET STARTED",clr: Colors.black,),
                                Icon(Icons.arrow_forward),
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