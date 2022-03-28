import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sih_2022_sahaye/Screens/Authentication/sign_up.dart';
import 'package:sih_2022_sahaye/Screens/admin/admin_home_screen.dart';
import 'package:sih_2022_sahaye/Screens/operator/home_screen_op.dart';
import 'package:sih_2022_sahaye/widgets/custom_text_widget.dart';

import '../../Models/size_config.dart';
import '../../services/authentication.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_text_input_fields.dart';
import '../user_role_screen.dart';
import '../users/user_home_screen.dart';
class LoginScreen extends StatefulWidget {
  final int index;
  const LoginScreen({Key? key, required this.index}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final form = GlobalKey<FormState>();
  String? phno;
  final auth=Authentication();
  String? otp;
  bool isOtpSent=false;
  var isLoading=false;
  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return Scaffold(
      appBar:cutomAppBar(isLoggedIn: false, context: context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: SvgPicture.string(''''<svg width="428" height="709" viewBox="0 0 428 709" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M-29.2643 589.93L446.224 526.584L462 645L-13.4884 708.346L-29.2643 589.93Z" fill="#FD5A58"/>
<path d="M-3 40L427 0L459 588H-3V40Z" fill="#2D01AD"/>
<path d="M433 140.401L3 107L-29 598H433V140.401Z" fill="#3C07C2"/>
<path d="M-1 283.925L429 261L461 598L-1 667V283.925Z" fill="#4A12DE"/>
<rect x="241" y="510" width="132" height="29" fill="#4A12DE"/>
</svg>


''',),
                  ),
                ),
                Positioned.fill(
                    child: Form(
                      key: form,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextWidget(txt: "Hi ${widget.index==0?"Users":(widget.index==1?"Operators":"Admin")},", clr: Colors.white,fontSize: 20,),
                          ),
                          const SizedBox(height: 40 ,),
                          const Center(
                            child: CustomTextWidget(txt:"LOG IN",clr: Colors.white,fontSize: 30,weight: FontWeight.w700,),
                          ),

                          CustomTextFields(


                            validator: (value){
                              if(value.toString().isEmpty)
                              {
                                return "Mobile number can't be empty";
                              }
                              if(value.toString().length<10)
                              {
                                return "Enter valid Mobile Number";
                              }
                              return null;
                            }, changed: (value) {
                            phno=value;
                          },  type: TextInputType.phone, title: 'Enter Mobile No.',),
                          if(isOtpSent)
                            CustomTextFields(
                              validator: (value){
                                if(value.toString().isEmpty)
                                {
                                  return "OTP can't be empty";
                                }
                                else if(value.toString().length<6)
                                {
                                  return "OTP should contains at least 6 digit";
                                }
                                return null;
                              }, changed: (value) {
                              otp=value;
                              if(value.length==6)
                              {
                                signIn();
                              }
                            }, type: TextInputType.number, title: 'Enter OTP',),
                          if(auth.isOtpTimeout)
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  auth.sendOtp(phoneNumber: phno!).then((value){
                                    isOtpSent=true;
                                  }).catchError((error){
                                    debugPrint(error.toString());
                                  });
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 50,right: 50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    CustomTextWidget(txt: "Resent Otp?", clr: Colors.white,fontSize: 14,)
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ))
              ],
            ),
            const SizedBox(height: 170,),
            Column(
              children: [
                InkWell(
                  onTap: (){
                    if(form.currentState!.validate())
                    {
                      if(!isOtpSent || auth.isOtpTimeout)
                      {
                        setState(() {
                          auth.sendOtp(phoneNumber: phno!).then((value){
                            isOtpSent=true;
                          }).catchError((error){
                            debugPrint(error.toString());
                          });
                        });
                      }
                      else
                      {
                        signIn();
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
                    decoration: BoxDecoration(
                        color: const Color(0XFF2D01AD),
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: CustomTextWidget(txt: isOtpSent?"VERIFY":"GET OTP",clr: Colors.white,),
                  ),
                ),
                if(widget.index==0)
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen(index:widget.index)),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CustomTextWidget(txt: "New User? Sign Up now", clr: Color(0XFF2D01AD)),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
  Future signIn() async{
    final credential = PhoneAuthProvider.credential(
      verificationId: auth.verificationId1!,
      smsCode: otp!,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      debugPrint("signIn Success from Firebase");
      Map body={
        'getUserFromPhone':phno.toString()
      };
      await auth.loginRequest(data:body).then((value){
        if (kDebugMode) {
          print('sign in Success from backend, checking user type');
        }
      }).catchError((error){
        //FirebaseAuth.instance.signOut();
      });
      navigation();
    }).catchError((error){
      debugPrint("error");
    });
  }
  navigation(){
    const storage = FlutterSecureStorage();
    storage.write(key: 'user_type', value: widget.index.toString());
    Navigator.pop(context);
    Navigator.popUntil(context, (route) => false);
    if(widget.index==0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>const UserHomeScreen()),
      );
    }
    else if(widget.index==1)
    {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreenOP()),
      );
    }
    else
    {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>const AdminHomeScreen()),
      );
    }
  }

}


