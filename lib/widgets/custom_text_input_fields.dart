import 'package:flutter/material.dart';

import 'custom_text_widget.dart';

/*
class CustomTextFields extends StatelessWidget {
  final String title;
  final String label;
  final FormFieldValidator validator;
  final ValueChanged changed;
  final TextInputType type;
  final EdgeInsets padding1;
  final EdgeInsets padding2;


  const CustomTextFields({Key? key, required this.title, required this.label, required this.validator, required this.changed, required this.type, required this.padding1, required this.padding2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:padding1,
          child: CustomTextWidget(txt: label, clr: Colors.white,fontSize: 14,),
        ),
        Padding(
          padding:padding2,
          child: Row(
            children: [
              Container(
                height: 50,
                width: 10,
                decoration: const BoxDecoration(
                    color: Colors.white
                ),
              ),
              Flexible(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      border: Border.all(color: Colors.white),
                      gradient: const LinearGradient(
                          colors: [
                            Color(0XFF2D01AD),
                            Color(0XFF6A33FB)
                          ]
                      )
                  ),
                  child: TextFormField(
                    style: const TextStyle(
                        color: Colors.white
                    ),
                    keyboardType: type,
                    validator: validator,
                    onChanged: changed,
                    decoration:  InputDecoration(
                      contentPadding:const EdgeInsets.all(10),
                      hintText: title,
                      hintStyle: const TextStyle(
                          color:Color(0XFFA9A3A3)
                      ),

                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

  }
}*/
class CustomTextFields extends StatelessWidget {
  final String title;
  final FormFieldValidator validator;
  final ValueChanged changed;
  final TextInputType type;



  const CustomTextFields({Key? key, required this.title, required this.validator, required this.changed, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        child: Container(
          decoration:  BoxDecoration(
              color: const Color(0XFFF3F3F3),
              borderRadius: BorderRadius.circular(16)
          ),
          child: TextFormField(
            style: const TextStyle(
                color: Color(0XFF666161)
            ),
            keyboardType: type,
            validator: validator,
            onChanged: changed,
            decoration:  InputDecoration(
              contentPadding:const EdgeInsets.all(10),
              hintText: title,
              hintStyle: const TextStyle(
                  color:Color(0XFF666161)
              ),

              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );

  }
}