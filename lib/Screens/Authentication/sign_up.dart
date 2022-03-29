import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sih_2022_sahaye/Screens/users/user_home_screen.dart';
import '../../Models/constants.dart';
import '../../Models/size_config.dart';
import '../../Models/user_model.dart';
import '../../providers/authentication_provider.dart';
import '../../services/authentication.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drop_down_text_fields.dart';
import '../../widgets/custom_text_input_fields.dart';
import '../../widgets/custom_text_widget.dart';
import '../admin/admin_home_screen.dart';
import '../operator/home_screen_op.dart';
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
  bool isOtpSent=false;
  bool isLoading=false;
  String stats="States";
  String gender="Gender";
  final dob=TextEditingController();
  DateTime? _saveDate;

  Future _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1901, 1),
      lastDate: DateTime(2100),
      builder: (context,child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0XFF041E42),
            colorScheme: const ColorScheme.light(primary: Color(0XFF041E42)),
            buttonTheme: const ButtonThemeData(
                textTheme: ButtonTextTheme.primary
            ),
          ), child: child ?? const Text(""),
        );
      },
    );

    if (picked != null) {
      setState(() {
        print(picked.toString());
        _saveDate=picked;
        dob.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvider>(context,listen: false).isOtpTimeOut=false;
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        widgetOpacity = 1;
      });
    });
  }
  @override

  Widget build(BuildContext context) {
    bool isOtpTimeout=Provider.of<AuthProvider>(context).getIsOtpTimeOut;
    auth.context=context;
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset:false,
      body: SafeArea(
        child: AnimatedOpacity(
          opacity: widgetOpacity,
          duration: const Duration(seconds: 1),
          child: SingleChildScrollView(
            child: Stack(
              children: [
              Opacity(
                opacity:  isLoading ? 0.5 : 1,
                child: AbsorbPointer(
                absorbing: isLoading,
               child:Column(
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
                                    if(value.toString().isNotEmpty &&  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))
                                      {
                                        return "Enter valid email or leave it blank";
                                      }
                                    return null;
                                  }, changed: (value) {
                                  eml=value;
                                }, type: TextInputType.emailAddress, title: 'Enter Email Address',),
                              ),
                            ],
                          ),
                          CustomDropDownButton(lst:Genders, msg: gender, changed: (value) {
                            setState(() {
                              gender=value;
                            });
                          },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: GestureDetector(
                              onTap: (){
                                _selectDate(context);
                              },
                              child: Container(
                                decoration:  BoxDecoration(
                                    color: const Color(0XFFF3F3F3),
                                    borderRadius: BorderRadius.circular(16)
                                ),
                                child: AbsorbPointer(
                                  child: TextFormField(
                                      textAlignVertical: TextAlignVertical.center,
                                      maxLines: 1,
                                      controller: dob,
                                      //initialValue: dob,
                                      keyboardType: TextInputType.datetime,
                                      textInputAction: TextInputAction.next,
                                      autofocus: false,
                                      style: TextStyle(
                                          fontSize: 14 * SizeConfig.safeBlockWidth,
                                          color: Colors.black),
//                      style: CustomThemes.ts5,
                                      decoration: const InputDecoration(
                                        contentPadding:EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                                        hintText: "Date of Birth",
                                        border:InputBorder.none,
                                        suffixIcon: Icon(
                                          Icons.arrow_drop_down_sharp,
                                          color: Colors.black,
                                        ),
                                      ),
                                      validator: ( _dt){
                                        if(_dt!.isEmpty)
                                        {
                                          return "Cant be empty dob";
                                        }
                                        else

                                        {
                                          final d1=_saveDate;
                                          final d2=DateTime.now();
                                          var difference=d2.difference(d1!).inDays;
                                          var year=difference/365;
                                          if(year<=5)
                                          {
                                            return "* Age must be greater or equal to 5";
                                          }
                                        }


                                        return null;
                                      }
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: InkWell(
                            onTap: () async {
                              if (form.currentState!.validate()) {

                                  setState(() {
                                    isLoading=true;
                                  });

                                  sendOTP(isOtpTimeout);

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
                Opacity(
                  opacity: isLoading ? 1.0 : 0,
                  child: const Center(child: CircularProgressIndicator()),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  sendOTP(isOtpTimeout) async {
    await auth.sendOtp(phoneNumber: phno!).then((value) {
      setState(() {
        isOtpSent = true;
      });
      Provider.of<AuthProvider>(context,listen: false).setIsOtpTimeOut(false);
      otpDialogBox(isOtpTimeout: isOtpTimeout);
    }).catchError((error){
      setState(() {
        isOtpSent = false;
      });
    });
    setState(() {
      isLoading=false;
    });
  }
  Future signUp({required String otp}) async {
    print(auth.verificationId1);
    try
    {
      final credential = PhoneAuthProvider.credential(
        verificationId: auth.verificationId1.toString(),
        smsCode: otp.toString(),
      );
      FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
        Map body={
          "firstName":fnm.toString(),
          "lastName":lnm.toString(),
          "phoneNumber":phno.toString(),
          "type":"User",
          "gender":gender.toString(),
          "dateOfBirth":DateFormat("dd/MM/yyy").format(_saveDate!).toString(),
          "email":eml.toString(),
        };
        await auth.signUpRequest(data: body).then((value) {
          /*final welcome = welcomeFromJson(value);*/
          navigation(index: value['type'].toString()=="User"?0:(value['type'].type.toString()=="Operator"?1:2));
        }).catchError((error){
          throw(error);
        });
      },
          onError: (error){
            Fluttertoast.showToast(msg:"Invalid OTP,");
            if (kDebugMode) {
              print(error);
            }
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
   /* final credential = PhoneAuthProvider.credential(
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
        "gender":gender.toString(),
        "dateOfBirth":DateFormat("DD/mm/yyyy").format(_saveDate!).toString(),
        "email":eml.toString(),
      };
      if (kDebugMode) {
        print(body.toString());
      }
      auth.signUpRequest(data:body,
      ).then((value){
        final welcome = welcomeFromJson(value);
        navigation(index: welcome.type.toString()=="User"?0:(welcome.type.toString()=="Operator"?1:2));
      }).catchError((error){
        Fluttertoast.showToast(msg: "Something went wrong,try again");
        FirebaseAuth.instance.currentUser!.delete();
      });
    }).catchError((error){
      FirebaseAuth.instance.currentUser!.delete();
      Fluttertoast.showToast(msg: "Something went wrong,check OTP");
      debugPrint("error");
    });*/
  }
  otpDialogBox({required bool isOtpTimeout}){
    setState(() {
      isLoading=false;
    });
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
                if(isOtpTimeout)
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isLoading=true;
                      });
                      sendOTP(isOtpTimeout);
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
                  )
                else
                  const SizedBox(height:20)
              ]),
        );
      },
    );
  }
  navigation({index}) {
    const storage = FlutterSecureStorage();
    storage.write(key: 'user_type', value: index.toString());
    storage.write(key: 'phno', value: phno);
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
