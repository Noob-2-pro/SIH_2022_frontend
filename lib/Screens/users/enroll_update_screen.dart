import 'package:flutter/material.dart';
import 'package:sih_2022_sahaye/Screens/user_role_screen.dart';
import 'package:sih_2022_sahaye/widgets/custom_text_widget.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import '../../Models/constants.dart';
import '../../Models/size_config.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_drop_down_text_fields.dart';
import '../../widgets/custom_text_input_fields.dart';
import '../Authentication/login_screen.dart';
class EnrollUpdateScreen extends StatefulWidget {
  final int index;
  const EnrollUpdateScreen({Key? key, required this.index}) : super(key: key);

  @override
  _EnrollUpdateScreenState createState() => _EnrollUpdateScreenState();
}

class _EnrollUpdateScreenState extends State<EnrollUpdateScreen> {
  String stats="States";
  String gender="Gender";
  final dob=TextEditingController();
   DateTime? _saveDate;
  final form = GlobalKey<FormState>();
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:cutomAppBar(isLoggedIn: true, context: context),
      /*bottomNavigationBar: const BottomNavBar(),*/
      body: SingleChildScrollView(
        child: Form(
          key: form,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomTextWidget(txt: widget.index==0?"Enroll For Aadhaar":"Update My Aadhar", clr: Color(0XFF464444),fontSize: 30,),
              )
              ),
              Row(
                children: [
                  Flexible(
                    child: CustomTextFields(

                      validator: (value){
                      }, changed: (value) {

                    }, type: TextInputType.name, title: 'First Name',),
                  ),
                  Flexible(
                    child: CustomTextFields(

                      validator: (value){
                      }, changed: (value) {

                    }, type: TextInputType.name, title: 'Last Name',),
                  ),
                ],
              ),
              CustomTextFields(

                validator: (value){
                }, changed: (value) {

              }, type: TextInputType.emailAddress, title: '${widget.index==1?"New ":""}Email ID',),
              CustomTextFields(

                validator: (value){
                }, changed: (value) {

              }, type: TextInputType.phone, title: '${widget.index==1?"New ":""}Mobile No.',),
              CustomDropDownButton(lst:Genders, msg: gender, changed: (value) {
                setState(() {
                  gender=value;
                });
              },
              ),
              CustomDropDownButton(lst:allStats, msg: stats, changed: (value) {
                setState(() {
                  stats=value;
                });
              },
              ),
              CustomTextFields(
                validator: (value){
                }, changed: (value) {

              }, type: TextInputType.phone, title: 'Pin Code',),
              CustomTextFields(
                validator: (value){
                }, changed: (value) {

              }, type: TextInputType.streetAddress, title: '${widget.index==1?"New ":""}Address',),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    _selectDate(context);
                  },
                  child: Material(
                    elevation: 5,
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
                              contentPadding: EdgeInsets.all(10),
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
                                if(year<13)
                                {
                                  return "* Age must be greater or equal to 13";
                                }
                              }


                              return null;
                            }
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if(widget.index==1)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomTextWidget(txt: "(in case you don’t wish to change something you can write the current information)",maxLines: 3, clr: Color(0XFF666161),fontSize: 12,),
              ),
              GestureDetector(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 50),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0XFFCBA7FF),
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Flexible(child: CustomTextWidget(txt: "Submit",clr: Colors.white,fontSize: 22,))
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 50),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color(0XFFCBA7FF),
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Flexible(child: CustomTextWidget(txt: "Return to home",clr: Colors.white,fontSize: 22,))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
