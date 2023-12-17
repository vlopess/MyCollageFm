// ignore_for_file: file_names

import 'package:flutter/material.dart';

Widget textField({String? title, TextEditingController? controller}) {
  return TextFormField(
      style: const TextStyle(color: Colors.black,fontFamily: "Barlow"),
      decoration: InputDecoration( 
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black), 
        ),   
        labelText: title,
        
        focusColor: Colors.black,
        hoverColor: Colors.black,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: Colors.black),
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder( 
          borderSide: const BorderSide(color: Colors.pink),
          borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.all(15),        
        isDense: true,
      ),
      controller: controller,
      validator: (value) {
            if (value == null || value.isEmpty) {
                return 'Please enter username';
            }
            return null;
        },
      );
}