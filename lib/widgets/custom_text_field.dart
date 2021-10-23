import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  String label;
  TextEditingController controller;
  bool isHidden;
  TextInputType textInputType;
  CustomTextFeild({
    required this.label,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.isHidden = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        obscureText: isHidden,
        keyboardType: textInputType,
        controller: this.controller,
        validator: (v) {},
        decoration: InputDecoration(
            labelText: label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }
}
