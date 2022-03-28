import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sih_2022_sahaye/Screens/user_role_screen.dart';
import 'package:sih_2022_sahaye/widgets/export_custom_widgets.dart';

import '../../constants.dart';

class ViewDetails extends StatelessWidget {
  const ViewDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cutomAppBar(context: context,isLoggedIn: true),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 20.h),
            decoration: const BoxDecoration(
                color: Colorpalette.peach,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                )),
            child: Text(
              "Resident Details",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          details(),
          ActionButton(text: "Navigate to Resident"),
          ActionButton(text: "Call Resident"),
          ActionButton(
            text: "Close Resident",
            color: Colorpalette.orange,
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
                        ActionButton(text: "Submit")
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Column details() {
    return Column(
      children: [Text("details")],
    );
  }
}
