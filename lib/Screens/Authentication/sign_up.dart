import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Models/size_config.dart';
import '../../services/authentication.dart';
import '../../widgets/custom_text_widget.dart';
import '../user_role_screen.dart';
import 'login_screen.dart';
class SignUpScreen extends StatefulWidget {
  final int index;
  const SignUpScreen({Key? key, required this.index}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final form = GlobalKey<FormState>();
  double widgetOpacity = 0.0;
  String? phno;
  final auth=Authentication();
  String? otp;
  String? fnm;
  String? lnm;
  String? eml;
  String? dob;
  bool isOtpSent=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        widgetOpacity = 1;
      });
    });
  }
  @override

  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset:false,
        appBar:CustomAppBar(),
      body: AnimatedOpacity(
        opacity: widgetOpacity,
        duration: const Duration(seconds: 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    height: 400,
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
                            const Center(
                              child: CustomTextWidget(txt:"SIGN UP",clr: Colors.white,fontSize: 30,weight: FontWeight.w700,),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: CustomTextFields(
                                    padding2:  const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                                    padding1: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top:20),
                                    validator: (value){
                                    if(value.toString().isEmpty)
                                    {
                                      return "Enter your name";
                                    }
                                    return null;
                                  }, changed: (value) {
                                    fnm=value;
                                  }, label: 'First Name', type: TextInputType.name, title: 'Enter First Name',),
                                ),
                                Flexible(
                                  child: CustomTextFields(
                                    padding2:  const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                                    padding1: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top:20),
                                    validator: (value){return null;},
                                    changed: (value) {
                                    lnm=value;
                                  }, label: 'Last Name', type: TextInputType.name, title: 'Enter Last Name',),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: CustomTextFields(
                                    padding2:  const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                                    padding1: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top:20),
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
                                  }, label: 'Mobile No.', type: TextInputType.phone, title: 'Enter Mobile No.',),
                                ),

                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: CustomTextFields(
                                    padding2:  const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                                    padding1: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top:20),
                                    validator: (value){
                                      return null;
                                    }, changed: (value) {
                                    phno=value;
                                  }, label: 'Email Address (optional)', type: TextInputType.emailAddress, title: 'Enter Email Address',),
                                ),
                              ],
                            ),
                           /* GestureDetector(
                              onTap: (){},
                              child: AbsorbPointer(
                                child: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    maxLines: 1,
                                    //initialValue: dob,
                                    keyboardType: TextInputType.datetime,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) =>
                                        FocusScope.of(context).nextFocus(),
                                    autofocus: false,
                                    style: TextStyle(
                                        fontSize: 14 * SizeConfig.safeBlockWidth,
                                        color: Color(0xff000000)),

//                      style: CustomThemes.ts5,
                                    decoration: const InputDecoration(
                                      hintText: "Enter Date of birth",
                                      border:InputBorder.none,
                                      suffixIcon:Icon(Icons.keyboard_arrow_down_outlined,
                                        color: Colors.white,
                                      )
                                    ),
                                    validator: (String? _dt){
                                      return null;
                                      }

                                ),
                              ),
                            ),*/

                           /* if(isOtpSent)
                              CustomTextFields(validator: (value){
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
                              }, label: 'OTP', type: TextInputType.number, title: 'Enter OTP',),*/
                           /* if(auth.isOtpTimeout)
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
                              ),*/
                          ],
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 100,),
            Column(
              children: [
                InkWell(
                  onTap: (){
                    if (form.currentState!.validate()) {
                        setState(() {
                          auth.sendOtp(phoneNumber: phno!).then((value) {
                            isOtpSent = true;
                            otpDialogBox();
                          });
                        });

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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomTextWidget(txt: "New User? Sign Up now", clr: Color(0XFF2D01AD)),
                ),

              ],
            )

          ],
        ),
      ),
    );
  }
  signUp({required String otp}){
    final credential = PhoneAuthProvider.credential(
      verificationId: auth.verificationId1!,
      smsCode: otp,
    );
    FirebaseAuth.instance.signInWithCredential(credential).then((value){
      debugPrint("signIn Success");
      auth.signUpRequest(data:{
        "firstName":fnm,
        "lastName":lnm,
        "phoneNumber":phno,
        "type":widget.index==0?"User":(widget.index==1?"Operator":"Admin"),
        "latitude":"26.35214",
        "longitude":"29.52411"
      }).then((value){
        Navigator.pop(context);


      }).catchError((error){
        print(error.toString());
        Fluttertoast.showToast(msg: "Something went wrong");
        FirebaseAuth.instance.currentUser!.delete();
      });
    }).catchError((error){
      FirebaseAuth.instance.currentUser!.delete();
      print(error.toString());
      Fluttertoast.showToast(msg: "Something went wrong");
      debugPrint("error");
    });
  }
  otpDialogBox(){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      builder: (builder) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom),
          child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomTextWidget(
                        txt: "Verify the Phone Number",
                        clr: Color(0XFF2B2B2B),
                        fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextWidget(
                    txt: "Code has been sent to ${phno}",
                    clr: const Color(0XFF2B2B2B),
                    fontSize: 12,
                  ),
                ),
                OtpTextField(
                    numberOfFields: 6,
                    borderColor: Color(0XFF00814D),
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    autoFocus: true,
                    //runs when every textfield is filled
                    onSubmit: (String
                    verificationCode) async {
                      signUp(otp: verificationCode);
                    }),
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
                      padding: const EdgeInsets.only(left: 50,right: 50,top: 20,bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          CustomTextWidget(txt: "Resent Otp?", clr: Colors.black,fontSize: 14,)
                        ],
                      ),
                    ),
                  ),
              ]),
        );
      },
    );
  }
}
