// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_collage_fm/utils/couleurs.dart';

Widget textField({String? title, TextEditingController? controller}) {
  return TextFormField(    
    textAlign: TextAlign.center,
      cursorColor: Couleurs.primaryColor,      
      style: const TextStyle(color: Couleurs.primaryColor ),
      decoration: InputDecoration(         
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Couleurs.primaryColor), 
        ),   
        labelText: title,     
        focusColor: Couleurs.primaryColor,
        hoverColor: Couleurs.primaryColor,
        fillColor: Couleurs.primaryColor,
        hintStyle: const TextStyle(color: Couleurs.primaryColor),
        labelStyle: const TextStyle(color: Couleurs.primaryColor),
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