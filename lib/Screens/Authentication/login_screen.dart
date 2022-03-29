import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sih_2022_sahaye/Screens/Authentication/sign_up.dart';
import 'package:sih_2022_sahaye/Screens/admin/admin_home_screen.dart';
import 'package:sih_2022_sahaye/Screens/operator/home_screen_op.dart';
import 'package:sih_2022_sahaye/widgets/custom_text_widget.dart';

import '../../Models/size_config.dart';
import '../../Models/user_model.dart';
import '../../providers/authentication_provider.dart';
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
  double widgetOpacity = 0.0;
  final auth = Authentication();
  String? otp;
  bool isOtpSent = false;
  var isLoading = false;
  @override
  void initState() {
    Provider.of<AuthProvider>(context,listen: false).isOtpTimeOut=false;
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
    auth.context=context;
    bool isOtpTimeout=Provider.of<AuthProvider>(context).getIsOtpTimeOut;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      /*appBar:cutomAppBar(isLoggedIn: false, context: context),*/
      body: SafeArea(
        top: true,
        child: AnimatedOpacity(
          opacity: widgetOpacity,
          duration: const Duration(seconds: 1),
          child: Stack(
            children: [
              Opacity(
                opacity:  isLoading ? 0.5 : 1,
                child: AbsorbPointer(
                  absorbing: isLoading,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Form(
                        key: form,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 50, bottom: 50),
                                child: CustomTextWidget(
                                  txt: "Welcome Back",
                                  clr: Color(0XFF464444),
                                  fontSize: 30,
                                  weight: FontWeight.w700,
                                ),
                              ),
                            ),
                            CustomTextFields(
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return "Mobile number can't be empty";
                                }
                                if (value.toString().length < 10) {
                                  return "Enter valid Mobile Number";
                                }
                                return null;
                              },
                              changed: (value) {
                                phno = value;
                              },
                              type: TextInputType.phone,
                              title: 'Enter Mobile No.',
                            ),
                            if (isOtpSent)
                              CustomTextFields(
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "OTP can't be empty";
                                  } else if (value.toString().length < 6) {
                                    return "OTP should contains at least 6 digit";
                                  }
                                  return null;
                                },
                                changed: (value) {
                                  otp = value;
                                 /* if (value.length == 6) {
                                    signIn();
                                  }*/
                                },
                                type: TextInputType.number,
                                title: 'Enter OTP',
                              ),
                            if (isOtpTimeout)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isLoading=true;});
                                  sendOTP();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 50, right: 50),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      CustomTextWidget(
                                        txt: "Resent Otp?",
                                        clr: Color(0XFF2D2626),
                                        fontSize: 14,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                            child: InkWell(
                              onTap: () async {
                                if (form.currentState!.validate()) {
                                  if (!isOtpSent) {
                                    setState(() {
                                            isLoading=true;});
                                      sendOTP();

                                  }
                                  else {
                                    signIn();
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                                decoration:
                                    BoxDecoration(color: const Color(0XFFCBA7FF), borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                        child: CustomTextWidget(
                                      txt: isOtpSent ? "VERIFY" : "GET OTP",
                                      clr: Colors.white,
                                      fontSize: 20,
                                      weight: FontWeight.bold,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (widget.index == 0)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUpScreen(index: widget.index)),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CustomTextWidget(txt: "New User? Sign Up now", clr: Color(0XFF555252)),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Opacity(
                opacity: isLoading ? 1.0 : 0,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
  sendOTP() async {
    await auth.sendOtp(phoneNumber: phno!).then((value) {
      setState(() {
        isOtpSent = true;
      });
      Provider.of<AuthProvider>(context,listen: false).setIsOtpTimeOut(false);
    }).catchError((error) {
      setState(() {
        isOtpSent = false;
      });
      Fluttertoast.showToast(msg: error.message.toString());
      debugPrint(error.toString());
    });
    setState(() {
      isLoading=false;
    });
  }
  Future signIn() async {
    setState(() {
      isLoading=true;
    });
    try
    {
      final credential = PhoneAuthProvider.credential(
        verificationId: auth.verificationId1.toString(),
        smsCode: otp.toString(),
      );
      FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
        Map body = {"phoneNumber": phno.toString()};
        await auth.loginRequest(data: body).then((value) {
          navigation(index: value['type'].toString()=="User"?0:(value['type'].type.toString()=="Operator"?1:2));
        }).catchError((error){
          throw(error);
        });
    },
    onError: (error){
      Fluttertoast.showToast(msg:"Invalid OTP,");
        print(error);
    });
  }
  catch(e)
    {
      if(FirebaseAuth.instance.currentUser!=null) {
      FirebaseAuth.instance.signOut();
    }
      Fluttertoast.showToast(msg: e.toString());
    }
    setState(() {
      isLoading=false;
    });
  }

  navigation({index}) {
    const storage = FlutterSecureStorage();
    storage.write(key: 'user_type', value: index.toString());
    storage.write(key: 'phno', value: phno.toString());
    print(phno.toString());
    Navigator.pop(context);
    Navigator.popUntil(context, (route) => false);
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserHomeScreen()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreenOP()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
      );
    }
  }
}
