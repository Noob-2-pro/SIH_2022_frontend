import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_text_input_fields.dart';
import '../../widgets/custom_text_widget.dart';
class FeedBackForm extends StatefulWidget {
  const FeedBackForm({Key? key}) : super(key: key);

  @override
  _FeedBackFormState createState() => _FeedBackFormState();
}

class _FeedBackFormState extends State<FeedBackForm> {
  int ratings=0;
  bool isRated=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:cutomAppBar(isLoggedIn: true, context: context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CustomTextWidget(txt: !isRated?"Feedback Form":"Thanks For Your Feedback", clr: Color(0XFF464444),fontSize: 30,),
            )),
            if(!isRated)
            CustomTextFields(
              validator: (value){
              }, changed: (value) {

            }, type: TextInputType.name, title: 'Operator’s Name',),
            if(!isRated)
            SizedBox(
              height: 300,
              child: CustomTextFields(title: 'How was your experience?', validator: (value) {
                return null;
                }, changed: (value) {  }, type: TextInputType.multiline,),
            ),
            if(!isRated)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomTextWidget(txt: "Ratings?", clr: Color(0XFF666161)),
            ),
            if(!isRated)
            Center(
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (itemBuilder,index){
                        return GestureDetector(
                            onTap: (){
                              setState(() {
                                if(index>=ratings) {
                                  ratings=index;
                                } else if(index<ratings) {
                                  ratings=index;
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left:5,right:5),
                              child: SvgPicture.string(
                           '''' <svg width="42" height="40" viewBox="0 0 42 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                              <path d="M40.6425 14.0851L28.0517 12.2602L22.4233 0.880338C22.2696 0.568764 22.0167 0.316538 21.7043 0.163224C20.9208 -0.222535 19.9686 0.0989307 19.5769 0.880338L13.9485 12.2602L1.35768 14.0851C1.01056 14.1346 0.693184 14.2978 0.450196 14.5451C0.156436 14.8462 -0.00543952 15.2513 0.000139574 15.6714C0.00571867 16.0915 0.178295 16.4922 0.479949 16.7854L9.58955 25.643L7.43736 38.1505C7.38689 38.4415 7.41918 38.7407 7.53055 39.0143C7.64193 39.2879 7.82794 39.5249 8.06749 39.6984C8.30704 39.8719 8.59055 39.975 8.88587 39.996C9.18119 40.017 9.4765 39.9551 9.73832 39.8172L21.0001 33.9121L32.2619 39.8172C32.5693 39.9804 32.9264 40.0348 33.2686 39.9754C34.1314 39.8271 34.7116 39.0111 34.5628 38.1505L32.4107 25.643L41.5203 16.7854C41.7682 16.5431 41.9318 16.2266 41.9814 15.8804C42.1153 15.0149 41.5103 14.2137 40.6425 14.0851V14.0851Z" fill="#FEE668"/>
                              </svg>''',
                                color: ratings>=index?const Color(0XFFFEE668):const Color(0XFFBFBFBF),
                              ),
                            ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            if(isRated)
              Padding(
                padding: const EdgeInsets.only(top: 50,bottom: 50),
                child: Center(
                  child: SvgPicture.string(''''<svg xmlns="http://www.w3.org/2000/svg" version="1.0" width="428" height="200" viewBox="0 0 428.000000 200.000000" preserveAspectRatio="xMidYMid meet">

<g transform="translate(0.000000,200.000000) scale(0.100000,-0.100000)" fill="#000000" stroke="none">
<path d="M2883 1977 c-6 -7 -67 -124 -138 -262 -171 -335 -311 -608 -405 -790 -42 -82 -128 -249 -190 -370 -62 -121 -116 -223 -119 -227 -3 -4 -29 20 -56 54 -28 34 -66 80 -85 103 -19 23 -100 122 -180 220 -80 98 -150 183 -155 189 -6 6 -32 39 -59 74 -27 34 -50 62 -52 62 -11 0 -143 -114 -139 -120 2 -4 32 -10 66 -14 197 -20 349 -182 503 -536 71 -163 118 -200 184 -146 42 36 83 122 137 286 26 80 64 177 83 215 40 77 135 179 264 283 120 96 140 143 178 417 12 83 30 178 42 213 26 82 104 198 175 261 l55 49 -50 26 c-38 19 -52 22 -59 13z"/>
</g>
</svg>''',
                    color: const Color(0XFF34AB53),
                  ),
                ),
              ),
            if(isRated)
            const Padding(
              padding: EdgeInsets.only(top: 50,bottom: 50),
              child: Center(child: CustomTextWidget(txt: "Your Feedback is successfully submitted!",clr: Color(0XFF666161),),),
            ),
            GestureDetector(
              onTap: (){
                if(!isRated) {
                  setState(() {
                  isRated=true;
                });

                }
                else
                {
                  Navigator.pop(context);
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
                    children:  [
                      Flexible(child: CustomTextWidget(txt: !isRated?"Submit":"Done",clr: Colors.white,fontSize: 22,))
                    ],
                  ),
                ),
              ),
            ),
            if(!isRated)
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
            )

          ],
        ),
      ),
    );
  }
}
