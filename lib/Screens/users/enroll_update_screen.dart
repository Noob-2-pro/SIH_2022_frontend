import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:sih_2022_sahaye/Screens/user_role_screen.dart';
import 'package:sih_2022_sahaye/Screens/users/slot_book.dart';
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
  final form = GlobalKey<FormState>();
  String stats="States";
  String gender="Gender";
  LocationData? currentLocation;
  Future<LocationData?> _getLocation() async {
     var location = Location();
    LocationData _locationData;

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }


    _locationData = await location.getLocation();

    return _locationData;
  }

  Future<String> _getAddress(double? lat, double? lang) async {
    if (lat == null || lang == null) return "";
    GeoCode geoCode = GeoCode();
    Address address =
    await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
    pinCode=address.postal;
    stats=address.city!;
    return "${address.streetAddress}, ${address.city}, ${address.countryName}, ${address.postal}";
  }
  Future getLocation({address})async{
    if(address!=null)
      {
        var cordinate=await GeoCode().forwardGeocoding(address: address);
        currentLocation!.longitude!=cordinate.longitude;
        currentLocation!.latitude!=cordinate.latitude;
      }
  }

  final dob=TextEditingController();
   DateTime? _saveDate=DateTime.now();
   String? eml;
   String? fnm,lnm,phno,address,pinCode;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _getLocation().then((value){
      LocationData? location = value;
      _getAddress(location?.latitude, location?.longitude)
          .then((value) {
            if(mounted) {
              setState(() {
          currentLocation = location;
          address = value;
        });
            }
      });
    });
  }

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
        _saveDate=picked;
        dob.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:cutomAppBar(isLoggedIn: true, context: context),
      /*bottomNavigationBar: const BottomNavBar(),*/
      body: SingleChildScrollView(
        child: Form(
          key: form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomTextWidget(txt: widget.index==0?"Enroll For Aadhaar":"Update My Aadhaar", clr: const Color(0XFF464444),fontSize: 30,),
              )
              ),
              Row(
                children: [
                  Flexible(
                    child: CustomTextFields(
                      validator: (value){
                        if(value.toString().isEmpty)
                          {
                            return "Name is required";
                          }
                        return null;
                      }, changed: (value) {
                        fnm=value;

                    }, type: TextInputType.name, title: 'First Name',),
                  ),
                  Flexible(
                    child: CustomTextFields(

                      validator: (value){
                        return null;
                      }, changed: (value) {
                        lnm=value;
                    }, type: TextInputType.name, title: 'Last Name',),
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
                  if(value.toString().isEmpty && pinCode==null)
                    {
                      return "PinCode is required";
                    }
                  else if(value.toString().length<6  && pinCode==null)
                    {
                      return "Invalid PinCode";
                    }
                  return null;
                }, changed: (value) {
                  pinCode=value;
              }, type: TextInputType.phone, title: pinCode==null?'Pin Code':pinCode.toString(),),
              CustomTextFields(
                validator: (value){
                  if(value.toString().isEmpty && address==null)
                    {
                      return "Address is required";
                    }
                  return null;
                }, changed: (value) {
                  address=value;
              }, type: TextInputType.streetAddress, title: address ?? (widget.index==1?"New ":"Address"),),
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
              if(widget.index==1)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomTextWidget(txt: "(in case you don’t wish to change something you can write the current information)",maxLines: 3, clr: Color(0XFF666161),fontSize: 12,),
              ),
              GestureDetector(
                onTap: (){
                  if(form.currentState!.validate())
                    {

                      /*getLocation(address: address.toString()+' '+ stats.toString()+' '+pinCode.toString()).then((value){*/
                        Map data={
                          'userLatitude':currentLocation!.latitude.toString(),
                          'userLongitude':currentLocation!.longitude.toString(),
                          'userFirstName':fnm,
                          'userID':userId,
                          "requestType":widget.index==0?"Enrollment For Aadhar":"Update For Aadhar",
                        };
                        print(data.toString());
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>SlotBookUserScreen(userData: data,index: widget.index,)));
                     // });

                    }
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
