import 'package:flutter/material.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_text_widget.dart';
class SlotBookedScreenConfirmation extends StatefulWidget {
  final Map data;
  const SlotBookedScreenConfirmation({Key? key, required this.data}) : super(key: key);

  @override
  _SlotBookedScreenConfirmationState createState() => _SlotBookedScreenConfirmationState();
}

class _SlotBookedScreenConfirmationState extends State<SlotBookedScreenConfirmation> {
  @override
  Widget build(BuildContext context) {
    final instruction=[
      "you do not need to pay any amount to operator",
      "you need to tell this otp(${widget.data.containsKey('otp')?widget.data['otp']:"123"}) to operator before closing \t\trequest"
    ];
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: cutomAppBar(isLoggedIn: true, context: context),
        body:SingleChildScrollView(
        child: Column(
        children: [
          const Center(child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: CustomTextWidget(txt:"Slot Booking Confirmed",clr: Color(0XFF464444),fontSize: 30,),
          )),
            Padding(
              padding:  const EdgeInsets.only(top: 0,bottom: 10),
              child: Center(
                  child: SizedBox(
                      height: 300,
                      width: 200,
                      child: Image.asset("assets/images/green tick.png"))
              ),
            ),
          const Center(child: CustomTextWidget(txt: "Dear user, you have successfully booked your slot with our operator.",maxLines:2,clr: Color(0XFF666161),isCenter:true),),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: CustomTextWidget(txt: "Instructions:",maxLines:2,clr: Color(0XFF666161),isCenter:true,fontSize: 13,),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
              itemCount: instruction.length,
              itemBuilder: (itemBuilder,index){
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomTextWidget(txt: "${index+1}."+instruction[index].toString(), clr: const Color(0XFF666161),maxLines: 3,),
            );
          })
        ],
    ),
    ) ,
    );
  }
}
