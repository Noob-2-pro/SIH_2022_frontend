import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sih_2022_sahaye/constants.dart';
import '../../widgets/export_custom_widgets.dart';

class HomeScreenOP extends StatelessWidget {
  const HomeScreenOP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cutomAppBar(isLoggedIn: true, context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
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
                      const Icon(Icons.person),
                      Text(
                        "Welcome back !\n Mukesh Gupta",
                        style: Theme.of(context).textTheme.headline2,
                      )
                    ],
                  ),
                  Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
