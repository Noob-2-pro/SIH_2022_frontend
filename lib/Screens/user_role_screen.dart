import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sih_2022_sahaye/Models/size_config.dart';
import 'package:sih_2022_sahaye/widgets/custom_text_widget.dart';

import 'Authentication/login_screen.dart';
class UserRole extends StatelessWidget {
  const UserRole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: SvgPicture.string(''''<svg width="428" height="722" viewBox="0 0 428 722" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M-37 603.346L438.488 540L454.264 658.416L-21.2241 721.763L-37 603.346Z" fill="#FD5A58"/>
<path d="M427.346 626.947L-17.1607 658.899L-39.5341 70.3975L437.273 79.0368L427.346 626.947Z" fill="#2D01AD"/>
<path d="M453.346 255.999L8.83928 287.951L-13.5341 -300.551L463.273 -291.911L453.346 255.999Z" fill="#2D01AD"/>
<path d="M-12.7048 474.949L430.352 522.984L474.03 -64.3215L-2.77719 -72.9608L-12.7048 474.949Z" fill="#3C07C2"/>
<path d="M428.532 321.55L-15.9741 353.503L-38.3475 -234.999L438.46 -226.36L428.532 321.55Z" fill="#4A12DE"/>
<path d="M-2.07239 187.479L438.869 219.496L460.977 -369.001L-12 -360.431L-2.07239 187.479Z" fill="#6A33FB"/>
</svg>
''',),
              ),
            ),
            Positioned.fill(child: Column(
              children: [
              const SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 60),
                child: customRoundedButton(msg: "User",index: 0, context: context),
              ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 50),
                  child: customRoundedButton(msg: "Operator",index: 1,context: context),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 50),
                  child: customRoundedButton(msg: "Admin",index: 2,context: context),
                ),
            ],
            )
            )
          ],
        ),
      ),
    );
  }
  Widget customRoundedButton({required String msg,required int index,required BuildContext context}){

    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen(index:index)),
        );
      },
      child: Row(
        children: [
          Container(
            height: 50,
            width: 10,
            decoration: const BoxDecoration(
                color: Colors.white
            ),
          ),
          Container(
            height: 50,
            constraints: const BoxConstraints(
              minWidth: 120
            ),
            padding: const EdgeInsets.all(10),
            decoration:  BoxDecoration(
             borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                border: Border.all(color: Colors.white),
                gradient: const LinearGradient(
                    colors: [
                      Color(0XFF2D01AD),
                      Color(0XFF6A33FB),
                    ]
                )
            ),
            child: CustomTextWidget(txt: msg,clr: Colors.white,fontSize: 20,weight: FontWeight.bold,),
          ),
        ],
      ),
    );
  }
}
PreferredSize CustomAppBar(){
  return PreferredSize(
    preferredSize: const Size.fromHeight(60)*SizeConfig.safeBlockHeight,
    child: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Image.asset("assets/images/logo.png",width: 120,),

    ),
  );
}