// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_collage_fm/utils/couleurs.dart';

Widget textField({String? title, TextEditingController? controller}) {
  return Theme(
    data: ThemeData(
      outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Couleurs.primaryColor)
        )
      )
    ),
    child: TextFormField(    
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
          borderSide: const BorderSide(color: Couleurs.primaryColor),
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
      ),
  );
}


Widget textArea({String? title, TextEditingController? controller}) {
  return Theme(
    data: ThemeData(
      outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Couleurs.primaryColor)
        )
      )
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title!, textAlign: TextAlign.start, style: const TextStyle(color: Couleurs.primaryColor, fontWeight: FontWeight.bold),),
        ),
        TextFormField(    
          maxLength: 365,
          maxLines: 5,
          cursorColor: Couleurs.primaryColor,      
          style: const TextStyle(color: Couleurs.primaryColor ),
          decoration: InputDecoration(     
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent),              
            ),               
            focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent),
            ),   
            border: OutlineInputBorder( 
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10)
            ),          
            contentPadding: const EdgeInsets.all(15),  
            filled: true,
            fillColor: Couleurs.secondary,      
          ),
          controller: controller,
          validator: (value) {
                if (value == null || value.isEmpty) {
                    return 'Please enter text';
                }
                return null;
            },
          ),
      ],
    ),
  );
}