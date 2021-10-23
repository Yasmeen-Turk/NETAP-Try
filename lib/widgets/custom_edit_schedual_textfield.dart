import 'package:flutter/material.dart';
import 'package:flutter_netap/provider/schedualProvider.dart';

import 'package:provider/provider.dart';

class CustomEditSchedualTextfeild extends StatelessWidget {
  Icon icons;
  String label;

  TextEditingController controller;

  bool isHidden;
  TextInputType textInputType;
  CustomEditSchedualTextfeild({
    required this.icons,
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
        cursorColor: Color.fromRGBO(152, 2, 255, 1),
        obscureText: isHidden,
        keyboardType: textInputType,
        controller: this.controller,
        validator: (v) => Provider.of<SchedualProvider>(context, listen: false)
            .nullValidate(v!),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Icon(
            icons.icon,
            color: Color.fromRGBO(152, 2, 255, 1),
            size: 20,
          ),
          labelText: label,
          labelStyle: TextStyle(color: Color.fromRGBO(152, 2, 255, 1)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Color.fromRGBO(243, 215, 255, 1))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Color.fromRGBO(243, 215, 255, 1))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Color.fromRGBO(243, 215, 255, 1))),
        ),
      ),
    );
  }
}
