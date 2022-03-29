import 'package:flutter/material.dart';
import 'package:sih_2022_sahaye/Screens/users/slotinfo.dart';

import '../../widgets/custom_appbar.dart';
class SlotBookUserScreen extends StatefulWidget {
  final Map userData;
  final int index;
  const SlotBookUserScreen({Key? key, required this.userData, required this.index}) : super(key: key);

  @override
  _SlotBookUserScreenState createState() => _SlotBookUserScreenState();
}

class _SlotBookUserScreenState extends State<SlotBookUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:cutomAppBar(isLoggedIn: true, context: context),
      body: SingleChildScrollView(
        child: Column(
          children:  [
            SlotInfo(data: widget.userData,
              index: widget.index,
            )
          ],
        ),
      ),
    );
  }
}
