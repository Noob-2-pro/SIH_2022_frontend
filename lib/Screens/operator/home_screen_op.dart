import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sih_2022_sahaye/Models/service_requests.dart';
import 'package:sih_2022_sahaye/constants.dart';
import '../../widgets/export_custom_widgets.dart';
import 'ViewDetailsScreen.dart';

class HomeScreenOP extends StatelessWidget {
  HomeScreenOP({Key? key}) : super(key: key);

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
                child: Column(
                  children: [
                    Text(
                      "Operator ID : 0928371",
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
                          "Welcome back !\nMukesh Gupta",
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
                        'Slots Completed - 0 / 5',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.w),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Available Requests",
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
                        itemCount: serviceRequests.length,
                        itemBuilder: (context, index) {
                          return serviceCard(
                            serviceRequests[index],
                            Colorpalette.lightPurple,
                            () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return ViewDetails();
                              }));
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
                        itemCount: serviceRequests.length,
                        itemBuilder: (context, index) {
                          return serviceCard(
                            serviceRequests[index],
                            Colorpalette.lightpink,
                            () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return ViewDetails();
                              }));
                            },
                          );
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget serviceCard(ServiceRequests sr, Color color, void Function()? onPressed) {
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
                  cardTile(sr.name, Icons.person),
                  cardTile(sr.serviceType, Icons.request_page),
                  cardTile(sr.place, Icons.location_pin),
                  cardTile(sr.time, Icons.access_time),
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
