import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sih_2022_sahaye/Screens/operator/services/get_available_request.dart';
import '../../Models/user_modal.dart';
import '../../constants.dart';
import '../../widgets/custom_appbar.dart';

class OpDetails extends StatelessWidget {
  const OpDetails({Key? key, required this.userId}) : super(key: key);

  Future<UserData> getuserDatabyId() async {
    return await User().getUserById(data: {"userID": "${userId}"});
  }

  final String userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cutomAppBar(context: context, isLoggedIn: true),
      body: FutureBuilder<UserData>(
          future: getuserDatabyId(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: Text('Loading....'));
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else {
                  final user = snapshot.data!;
                  //                  TimeOfDay starttime =
                  //     TimeOfDay(hour: int.parse(widget.userData.startTime!.substring(0, 2)), minute: int.parse(widget.userData.startTime!.substring(2)));
                  // TimeOfDay endTime =
                  //     TimeOfDay(hour: int.parse(widget.userData.endTime!.substring(0, 2)), minute: int.parse(widget.userData.endTime!.substring(2)));

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
                            Text("Name :  ${user.firstName} "),
                            if (user.lastName != null) Text("last name : ${user.lastName}"),
                            user.email == null
                                ? Text("email : ${user.firstName}@gmail.com")
                                : Text("email : ${user.email}"),
                            Text("gender : ${user.gender}"),
                            Text("avilable slots : ${user.slots}"),
                            Text("DOB : ${user.dateOfBirth}"),
                            Text("phone no : ${user.phoneNo}"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  );
                }
            }
          }),
    );
  }
}
