// ignore_for_file: file_names

import 'package:flutter/material.dart';

Widget textField({String? title}) {
  return TextFormField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        focusedBorder: InputBorder.none,
        labelText: title,
        focusColor: Colors.black,
        hoverColor: Colors.black,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: Colors.black),
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.all(15),
      ),
      );
}