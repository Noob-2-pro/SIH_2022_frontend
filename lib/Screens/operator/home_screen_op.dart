import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sih_2022_sahaye/Models/service_requests.dart';
import 'package:sih_2022_sahaye/Models/user_modal.dart';
import 'package:sih_2022_sahaye/Screens/operator/services/get_slot_info.dart';
import 'package:sih_2022_sahaye/Screens/operator/services/slot_info_modal.dart';
import 'package:sih_2022_sahaye/constants.dart';
import 'package:sih_2022_sahaye/services/getuserdata.dart';
import '../../widgets/export_custom_widgets.dart';
import 'ViewDetailsScreen.dart';

class HomeScreenOP extends StatefulWidget {
  HomeScreenOP({Key? key}) : super(key: key);

  @override
  State<HomeScreenOP> createState() => _HomeScreenOPState();
}

class _HomeScreenOPState extends State<HomeScreenOP> {
  Future<UserData> getuserdata() async {
    return await User().getUserData(data: {"phoneNumber": "7982170123", "type": "User"});
  }

  Future<List<SlotInfo>> getSlotData() async {
    return await SlotData().getSlotData(data: {"operatorID": "62413f7a16bc5847990659c6"});
  }

  int slotCount = 0;

  @override
  void initState() {
    getSlotData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cutomAppBar(isLoggedIn: true, context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.only(bottom: 20.h),
                decoration: const BoxDecoration(
                    color: Colorpalette.peach,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    )),
                child: FutureBuilder<UserData>(
                    future: getuserdata(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Text('Loading....');
                        default:
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          else {
                            UserData userData = snapshot.data!;
                            return Column(
                              children: [
                                Text(
                                  "Operator ID : ${userData.id?.substring(0, 5)}",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.person),
                                    Text(
                                      "Welcome back !\n${userData.firstName} ${userData.lastName}",
                                      style: Theme.of(context).textTheme.headline2,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: Colorpalette.lightPurple),
                                  child: Text(
                                    'Slots Completed - 1 / 5',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.w),
                                  ),
                                )
                              ],
                            );
                          }
                      }
                    }),
              ),
            ),
            FutureBuilder<List<SlotInfo>>(
                future: getSlotData(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text('Loading....');
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else {
                        List<SlotInfo> slotdata = snapshot.data!;

                        List<SlotInfo> pendingSlot =
                            slotdata.where((element) => element.status.toString() == 'Pending').toList();
                        List<SlotInfo> completedSlot =
                            slotdata.where((element) => element.status.toString() == 'Completed').toList();

                        slotCount = completedSlot.length;

                        return Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Pending Requests",
                                  style: Theme.of(context).textTheme.headline3!.copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              SizedBox(
                                height: 230.h,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: pendingSlot.length,
                                    itemBuilder: (context, index) {
                                      return serviceCard(
                                        pendingSlot[index],
                                        Colorpalette.lightPurple,
                                        () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            return ViewDetails(
                                              userData: pendingSlot[index],
                                            );
                                          },
                                          ));
                                        },
                                      );
                                    }),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Completed requests",
                                  style: Theme.of(context).textTheme.headline3!.copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              SizedBox(
                                height: 230.h,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: completedSlot.length,
                                    itemBuilder: (context, index) {
                                      return serviceCard(
                                        completedSlot[index],
                                        Colorpalette.lightpink,
                                        () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            return ViewDetails(
                                              userData: completedSlot[index],
                                            );
                                          }));
                                        },
                                      );
                                    }),
                              ),
                            ],
                          ),
                        );
                      }
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget serviceCard(SlotInfo sr, Color color, void Function()? onPressed) {
    TimeOfDay starttime =
        TimeOfDay(hour: int.parse(sr.startTime!.substring(0, 2)), minute: int.parse(sr.startTime!.substring(2)));
    TimeOfDay endTime =
        TimeOfDay(hour: int.parse(sr.endTime!.substring(0, 2)), minute: int.parse(sr.endTime!.substring(2)));

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
        color: color,
        child: Padding(
          padding: EdgeInsets.only(top: 15, left: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cardTile(sr.userFirstName.toString(), Icons.person),
                  cardTile(sr.requestType.toString(), Icons.request_page),
                  cardTile(sr.userLatitude.toString(), Icons.location_pin),
                  cardTile("${starttime.format(context)} - ${endTime.format(context)}", Icons.access_time),
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(horizontal: 25)),
                    backgroundColor: MaterialStateProperty.resolveWith((states) => Colorpalette.purple),
                    shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        )))),
                onPressed: onPressed,
                child: Text("View Details"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row cardTile(String text, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon),
        SizedBox(
          width: 10.w,
        ),
        Flexible(child: Text(text, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.w))),
      ],
    );
  }
}
