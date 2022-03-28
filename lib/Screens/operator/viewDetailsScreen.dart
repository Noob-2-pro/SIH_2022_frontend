import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sih_2022_sahaye/Screens/operator/services/get_available_request.dart';
import 'package:sih_2022_sahaye/Screens/operator/services/slot_info_modal.dart';
import 'package:sih_2022_sahaye/widgets/export_custom_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Models/user_modal.dart';
import '../../constants.dart';

class ViewDetails extends StatefulWidget {
  final SlotInfo userData;

  ViewDetails({Key? key, required this.userData}) : super(key: key);

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  void _launchURLtel(String _url) async {
    // Platform.isIOS ? 'tel://$_url' : 'tel:$_url'
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  launchURL({required String lat, required long}) async {
    final String googleMapslocationUrl = "https://www.google.com/maps/search/?api=1&query=${lat},${long}";

    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }

  Future<UserData> getuserDatabyId() async {
    return await User().getUserById(data: {"userID": "${widget.userData.id}"});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cutomAppBar(context: context, isLoggedIn: true),
      body: FutureBuilder<UserData>(
          future: getuserDatabyId(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading....');
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else {
                  final user = snapshot.data!;
                     TimeOfDay starttime =
        TimeOfDay(hour: int.parse(widget.userData.startTime!.substring(0, 2)), minute: int.parse(widget.userData.startTime!.substring(2)));
    TimeOfDay endTime =
        TimeOfDay(hour: int.parse(widget.userData.endTime!.substring(0, 2)), minute: int.parse(widget.userData.endTime!.substring(2)));

                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(20.h),
                        padding: EdgeInsets.all(20.h),
                        decoration: const BoxDecoration(
                          color: Colorpalette.peach,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Resident Details",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Icon(Icons.person),
                            Text("Name :  ${user.firstName} ${user.endTime} "),
                            Text("Service : ${user.firstName}"),
                            Text("place : Rohini"),
                            Text(starttime.toString()+ endTime.toString()),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ActionButton(
                              text: "Navigate to Resident",
                              color: Colorpalette.peach,
                              onPressed: () {
                                //TODO: add lat long here
                                launchURL(lat: user.latitude, long: user.longitude);
                              },
                              svgString:
                                  ''' <svg width="67" height="67" viewBox="0 0 67 67" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M63 28.78C63 46.48 33.5 63 33.5 63C33.5 63 4 46.48 4 28.78C4 22.2079 7.10803 15.905 12.6403 11.2579C18.1727 6.61074 25.6761 4 33.5 4C41.3239 4 48.8273 6.61074 54.3597 11.2579C59.892 15.905 63 22.2079 63 28.78V28.78Z" stroke="black" stroke-width="7" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M33.5004 34.68C37.3795 34.68 40.5242 32.0385 40.5242 28.78C40.5242 25.5215 37.3795 22.88 33.5004 22.88C29.6212 22.88 26.4766 25.5215 26.4766 28.78C26.4766 32.0385 29.6212 34.68 33.5004 34.68Z" fill="black" stroke="black" stroke-width="7" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
'''),
                          ActionButton(
                            text: "Call Resident",
                            color: Colorpalette.lightPurple,
                            onPressed: () {
                              _launchURLtel('tel:+91${user.phoneNo}');
                            },
                            svgString:
                                ''' <svg width="59" height="59" viewBox="0 0 59 59" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M49.1665 27.0392H54.0832C54.0832 14.4279 44.5621 4.91663 31.9336 4.91663V9.83329C41.9193 9.83329 49.1665 17.0682 49.1665 27.0392Z" fill="black"/>
<path d="M31.9581 19.6667C37.1279 19.6667 39.3331 21.8718 39.3331 27.0417H44.2497C44.2497 19.1136 39.8862 14.75 31.9581 14.75V19.6667ZM40.3705 33.0474C39.8981 32.618 39.2774 32.3891 38.6393 32.4088C38.0013 32.4285 37.3959 32.6954 36.9509 33.1531L31.0681 39.2031C29.6521 38.9326 26.8054 38.0452 23.8751 35.1222C20.9447 32.1894 20.0573 29.3353 19.7942 27.9291L25.8393 22.0439C26.2975 21.5992 26.5648 20.9937 26.5845 20.3555C26.6043 19.7173 26.3749 19.0965 25.945 18.6244L16.8614 8.63614C16.4313 8.16256 15.8335 7.8753 15.1951 7.83536C14.5566 7.79543 13.9276 8.00597 13.4419 8.42227L8.1073 12.9972C7.68228 13.4238 7.4286 13.9915 7.39438 14.5927C7.35751 15.2073 6.65443 29.7655 17.9431 41.0591C27.7912 50.9047 40.1271 51.625 43.5245 51.625C44.0211 51.625 44.3259 51.6103 44.4071 51.6054C45.0082 51.5717 45.5756 51.3169 46.0001 50.89L50.5726 45.5529C50.9892 45.0675 51.2001 44.4388 51.1606 43.8003C51.1212 43.1618 50.8344 42.5638 50.3611 42.1334L40.3705 33.0474Z" fill="black"/>
</svg>
''',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: ElevatedButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Enter the OTP sent to resident's number",
                                        textAlign: TextAlign.center,
                                      ),
                                      TextField(),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 40.h,
                                          width: 200.w,
                                          decoration: BoxDecoration(
                                            color: Colorpalette.lightPurple,
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          child: Center(
                                            child: Text("Submit"),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.redAccent,
                              ),
                              shape: MaterialStateProperty.resolveWith(
                                (states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                              )),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Close Request",
                                  style: TextStyle(color: Colors.black),
                                ),
                                SvgPicture.string(
                                    ''' <svg width="29" height="29" viewBox="0 0 29 29" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M18.304 2H2V27H24.8256V18.6667" stroke="black" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M8.52246 13.9048L13.9571 19.8572L27.0003 4.38098" stroke="black" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''',
                                    height: 30.h),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
            }
          }),
    );
  }
}
