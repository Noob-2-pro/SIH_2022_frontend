import 'package:flutter/material.dart';

import '../Models/constants.dart';

class CustomDropDownButton extends StatelessWidget {
  final List lst;
  final String msg;
  final ValueChanged changed;

  const CustomDropDownButton({Key? key, required this.lst, required this.msg, required this.changed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration:  BoxDecoration(
            color: const Color(0XFFF3F3F3),
            borderRadius: BorderRadius.circular(16)
        ),
        child: InputDecorator(
          decoration:  InputDecoration(
            contentPadding:const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
            errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
            hintText: msg,
            border:InputBorder.none,
            hintStyle:const TextStyle(
                color:Colors.black
            ),
          ),
          isEmpty:false,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(msg),
              value:null,
              isExpanded: true,
              isDense: true,
              onChanged: changed,
              items: lst.map(( value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
