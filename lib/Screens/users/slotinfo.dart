import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sih_2022_sahaye/Screens/users/slotSchedular.dart';
import 'package:sih_2022_sahaye/Screens/users/slot_booked_screen.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../services/user_services.dart';
import '../../widgets/slots/slotchip.dart';

class SlotInfo extends StatefulWidget {
  final Map data;
  final int index;
  const SlotInfo({Key? key, required this.data, required this.index}) : super(key: key);

  @override
  State<SlotInfo> createState() => _SlotInfoState();
}

class _SlotInfoState extends State<SlotInfo> {
  int isSelected = -1;
  List availableSlots = [];
  List notAvailableDays = [];
  int selectedWeekDay = 1;
  bool isDateSelected = false;
  String? bookedTime;
  String? s1;
  String? s2;
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  DateTime today = DateTime.now();
  DateTime bookingDateTime = DateTime.now();
  bool isBooked = false;
  List availableDays = [1, 2, 3, 4, 5,6];
  List bookedSlots = ["2022-03-23 16:00:00.000", "2022-03-26 10:50:00.000", "2022-03-29 09:30:00.000"];
  List notAvailableSlots = ["2022-03-22 09:30:00.000", "2022-03-28 10:10:00.000"];
  List notAvaliableDate = ['2022-03-25 00:00:00.000'];
  List finalSlots = [
    [
      '09:00',
      '10:00',
      60,
      30,
      [1,2,3,4,5]
    ],
    [
      '10:30',
      '11:30',
      60,
      0,
      [1,2,3,4,5]
    ],
    [
      '12:00',
      '13:00',
      60,
      30,
      [1,2,3,4,5]
    ],  [
      '13:30',
      '14:30',
      60,
      30,
      [1,2,3,4,5]
    ],
    [
      '15:00',
      '16:00',
      60,
      30,
      [1,2,3,4,5]
    ],
  ];


  covertIntoDateTime(dynamic element) {
    TimeOfDay startTime1 = TimeOfDay(
        hour: int.parse(element[0].toString().split(':')[0]), minute: int.parse(element[0].toString().split(':')[1]));
    TimeOfDay endTime1 = TimeOfDay(
        hour: int.parse(element[1].toString().split(':')[0]), minute: int.parse(element[1].toString().split(':')[1]));
    final now = DateTime.now();
    startTime = DateTime(now.year, now.month, now.day, startTime1.hour, startTime1.minute);
    endTime = DateTime(now.year, now.month, now.day, endTime1.hour, endTime1.minute);
    setState(() {});
  }

  slotmaker(List slotForTheDay) {
    for (var element in slotForTheDay) {
      int gap = element[3];
      int duration = element[2];
      covertIntoDateTime(element);
      DateTime to = startTime;

      while (endTime.compareTo(startTime) == 1) {
        to = startTime.add(Duration(minutes: duration));
        availableSlots.add('${DateFormat('hh:mm a').format(startTime)} - ${DateFormat('hh:mm a').format(to)}');
        startTime = to.add(Duration(minutes: gap));
        if (endTime.compareTo(startTime) == 0) {
          break;
        }
      }
    }
  }

  slotsToShow(int selectedWeekDay) {
    availableSlots = [];
    List slotsforTheDay = finalSlots.where((element) {
      List days = element[4];
      if (days.contains(selectedWeekDay)) {

        return true;
      } else {
        return false;
      }
    }).toList();
    slotmaker(slotsforTheDay);
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is DateTime) {

      isSelected = -1;
      DateTime value = args.value as DateTime;
      print(value);
      bookingDateTime = value;
      availableSlots = [];
      slotsToShow(value.weekday);
    }
    setState(() {});
  }

  checkIfBooked(String slotTime) {
    String label = slotTime.toString().split('-')[0];
    int hour = int.parse(label.split(':')[0]);
    int min = int.parse(label.split(' ')[0].split(':')[1]);
    String amPm = label.split(' ')[1];
    if (amPm == 'PM') {
      hour += 12;
    }
    DateTime checkTime = DateTime(bookingDateTime.year, bookingDateTime.month, bookingDateTime.day, hour, min);
    if (bookedSlots.contains(checkTime.toString()) || notAvailableSlots.contains(checkTime.toString())) {
      isBooked = true;
    } else {
      isBooked = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    List daystoBlackout = [1, 2, 3, 4, 5, 6, 7];
    notAvailableDays = daystoBlackout.where((item) => !availableDays.contains(item)).toList();
    //TODO : fetch list of available days from provider model and store in availableDays variable
    // TODO : fetch list of final slots from provider model and store in finalSlots variable
    // TODO : fetch  list of booked slots
    // TODO : notAvailableSlots from provider
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Text(
                "Slot Bookings",
                style: Theme.of(context).textTheme.headline1,
                // style: bodyTextStyle.copyWith(fontSize: 18.sp, fontFamily: robottoFontTextStyle),
              ),
            ],
          ),
          SizedBox(height: 25.h),
           const Padding(
             padding: EdgeInsets.all(8.0),
             child: Text(
              "Choose your appointment date",
              // style: bodyTextStyle.copyWith(color: Colors.grey, fontSize: 15.sp, fontFamily: robottoFontTextStyle),
          ),
           ),
          SfDateRangePicker(
            enablePastDates: false,
            minDate: today.subtract(const Duration(days: 60)),
            maxDate: today.add(const Duration(days: 240)),
            monthViewSettings: const DateRangePickerMonthViewSettings(
              firstDayOfWeek: 1,
            ),
            onSelectionChanged: _onSelectionChanged,
            selectableDayPredicate: (DateTime dateTime) {
              if (notAvailableDays.contains(dateTime.weekday) || notAvaliableDate.contains(dateTime.toString())) {
                return false;
              }
              return true;
            },
          ),
          slots(),
          SizedBox(
            height: 20.h,
          ),
          confirmSlotBooking(),
          SizedBox(
            height: 20.h,
          ),
          /*GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SlotSchedular();
              }));
            },
            child: const Text("Next page"),
          )*/
        ],
      ),
    );
  }

  Padding confirmSlotBooking() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        style:  ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0XFFCBA7FF)),
        ),
          onPressed: () {
            if (isSelected != -1) {
              int hour = int.parse(bookedTime!.split(':')[0]);
              int min = int.parse(bookedTime!.split(' ')[0].split(':')[1]);
              String amPm = bookedTime!.split(' ')[1];
              if (amPm == 'PM') {
                hour += 12;
              }
              bookingDateTime = DateTime(bookingDateTime.year, bookingDateTime.month, bookingDateTime.day,bookingDateTime.hour,bookingDateTime.minute);
             Map data=widget.data;
             data.addAll({
               'startTime':s1,
               "endTime":s2,
               "date":DateFormat("dd/MM/yyyy").format(bookingDateTime),
             });
             print(data.toString());
              UserServices().bookSlot(data: data).then((value){
                print(value.toString());
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>SlotBookedScreenConfirmation(data: {
                  'otp':value['OTP']
                },)));
              });

              // TODO: send api req for booking slot and append this timing bookedSlots for user
              if (kDebugMode) {
                print(bookingDateTime);
              }
            }
          },
          child: const Center(
            child: Text("Confirm Booking"),
          )),
    );
  }

  Widget slots() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Text(
                "Available Slots",
                style:TextStyle(
                  fontSize: 20.h
                ) ,
                // style: bodyTextStyle.copyWith(color: Colors.grey, fontSize: 15.sp, fontFamily: robottoFontTextStyle),
              ),
            ],
          ),
          availableSlots.isEmpty
              ? const Center(
                  child: Card(
                      child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("No slots available for selected day"),
                )))
              : Wrap(
                  spacing: 8.w,
                  children: List.generate(
                    availableSlots.length,
                    (index) {
                      checkIfBooked(availableSlots[index]);
                      return SlotChip(
                        text: availableSlots[index],
                        index: index,
                        isSelected: isSelected,
                        isBooked: isBooked,
                        onTap: (value) {
                          setState(() {
                            isSelected = index;
                          });
                          bookedTime = availableSlots[index].toString().split('-')[0].toString();
                          if(index==0)
                            {
                              s1="0900";
                              s2="1000";
                            }
                          else if(index==1)
                          {
                            s1="1030";
                            s2="1130";
                          }
                          else if(index==2)
                          {
                            s1="1200";
                            s2="1300";
                          }
                          else if(index==3)
                          {
                            s1="1330";
                            s2="1430";
                          }
                          else if(index==1)
                          {
                            s1="1500";
                            s2="1600";
                          }
                          /*var bookedTime1 = availableSlots[index].toString().split('-')[0].toString();
                          int hour = int.parse(bookedTime!.split(':')[0]);
                          int min = int.parse(bookedTime!.split(' ')[0].split(':')[1]);
                          String amPm = bookedTime!.split(' ')[1];
                          if (amPm == 'PM') {
                            hour += 12;
                          }
                          bookingDateTime = DateTime(bookingDateTime.year, bookingDateTime.month, bookingDateTime.day,bookingDateTime.hour,bookingDateTime.minute);*/
                        },
                      );
                    },
                  )),
        ],
      ),
    );
  }
}
