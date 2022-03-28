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
  final auth = Authentication();
  String? otp;
  bool isOtpSent = false;
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return Scaffold(
      appBar: null,
      /*appBar:cutomAppBar(isLoggedIn: false, context: context),*/
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
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
                          if (value.length == 6) {
                            signIn();
                          }
                        },
                        type: TextInputType.number,
                        title: 'Enter OTP',
                      ),
                    // if (auth.isOtpTimeout)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            auth.sendOtp(phoneNumber: phno!).then((value) {
                              isOtpSent = true;
                            }).catchError((error) {
                              debugPrint(error.toString());
                            });
                          });
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
                      onTap: () {
                        if (form.currentState!.validate()) {
                          
                          if (!isOtpSent
                          //TODO: uncomment this
                          //  || auth.isOtpTimeout
                           ) {
                            setState(() {
                              auth.sendOtp(phoneNumber: phno!).then((value) {
                                isOtpSent = true;
                              }).catchError((error) {
                                debugPrint(error.toString());
                              });
                            });
                          } else {
                            signIn();
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
    );
  }

  Future signIn() async {
    final credential = PhoneAuthProvider.credential(
      verificationId: auth.verificationId1.toString(),
      smsCode: otp.toString(),
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      debugPrint("signIn Success from Firebase");
      Map body = {'getUserFromPhone': phno.toString()};
      await auth.loginRequest(data: body).then((value) {
        if (kDebugMode) {
          print('sign in Success from backend, checking user type');
        }
      }).catchError((error) {
        //FirebaseAuth.instance.signOut();
      });
      navigation();
    }).catchError((error) {
      debugPrint("error");
    });
  }

  navigation() {
    const storage = FlutterSecureStorage();
    storage.write(key: 'user_type', value: widget.index.toString());
    Navigator.pop(context);
    Navigator.popUntil(context, (route) => false);
    if (widget.index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserHomeScreen()),
      );
    } else if (widget.index == 1) {
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
