import 'package:flutter/material.dart';

class CustomTextFields extends StatelessWidget {
  final String title;
  final FormFieldValidator validator;
  final ValueChanged changed;
  final TextInputType type;



  const CustomTextFields({Key? key, required this.title, required this.validator, required this.changed, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration:  BoxDecoration(
            color: const Color(0XFFF3F3F3),
            borderRadius: BorderRadius.circular(16)
        ),
        child: TextFormField(
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Color(0XFF666161)
          ),
          keyboardType: type,
          validator: validator,
          maxLines: null,
          onChanged: changed,
          decoration:  InputDecoration(
            contentPadding:const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
            hintText: title,
            hintStyle: const TextStyle(
                color:Color(0XFF666161)
            ),

            border: InputBorder.none,
          ),
        ),
      ),
    );

  }
}