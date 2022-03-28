import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sih_2022_sahaye/Screens/users/user_home_screen.dart';
import '../../Models/size_config.dart';
import '../../services/authentication.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_text_input_fields.dart';
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
     /* appBar:cutomAppBar(isLoggedIn: false, context: context),*/
      body: SafeArea(
        child: AnimatedOpacity(
          opacity: widgetOpacity,
          duration: const Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: form,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: CustomTextWidget(txt:"Welcome ${widget.index==0?User:(widget.index==1?"Operator":"Admin")}",clr: const Color(0XFF464444),fontSize: 30,weight: FontWeight.w700,),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: CustomTextFields(


                            validator: (value){
                              if(value.toString().isEmpty)
                              {
                                return "Enter your name";
                              }
                              return null;
                            }, changed: (value) {
                            fnm=value;
                          }, type: TextInputType.name, title: 'Enter First Name',),
                        ),
                        Flexible(
                          child: CustomTextFields(


                            validator: (value){return null;},
                            changed: (value) {
                              lnm=value;
                            }, type: TextInputType.name, title: 'Enter Last Name',),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: CustomTextFields(

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
                          }, type: TextInputType.phone, title: 'Enter Mobile No.',),
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: CustomTextFields(


                            validator: (value){
                              return null;
                            }, changed: (value) {
                            eml=value;
                          }, type: TextInputType.emailAddress, title: 'Enter Email Address',),
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
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: InkWell(
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
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            color: const Color(0XFFCBA7FF),
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(child: CustomTextWidget(txt: isOtpSent?"VERIFY":"GET OTP",clr: Colors.white,)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomTextWidget(txt: "New User? Sign Up now", clr: Color(0XFF555252)),
                  ),

                ],
              )

            ],
          ),
        ),
      ),
    );
  }
  Future signUp({required String otp}) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: auth.verificationId1!,
      smsCode: otp,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value){
      debugPrint("signIn Success");
      Map body={

        "firstName":fnm.toString(),
        "lastName":lnm.toString(),
        "phoneNumber":phno.toString(),
        "type":"User",
        "latitude":"26.35214",
        "longitude":"29.52411"
      };
      if (kDebugMode) {
        print(body.toString());
      }
      auth.signUpRequest(data:body,
      ).then((value){
        const storage = FlutterSecureStorage();
        storage.write(key: 'user_type', value: widget.index.toString());
        Navigator.pop(context);
        Navigator.popUntil(context, (route) => false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>const UserHomeScreen()),
        );
      }).catchError((error){
        if (kDebugMode) {
          print(error.toString());
        }
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
                    txt: "Code has been sent to $phno",
                    clr: const Color(0XFF2B2B2B),
                    fontSize: 12,
                  ),
                ),
                OtpTextField(
                    numberOfFields: 6,
                    borderColor: const Color(0XFF00814D),
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    autoFocus: true,
                    //runs when every textfield is filled
                    onSubmit: (String
                    verificationCode) async {
                      signUp(otp: verificationCode);
                    }),
                    // TODO: uncomment this
                // if(auth.isOtpTimeout)
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
