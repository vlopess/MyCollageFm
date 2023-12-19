// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_collage_fm/models/user.dart';
import 'package:my_collage_fm/service/apiService.dart';

class LoginController {

  final _crtUsername = TextEditingController();

  TextEditingController get crtUsername => _crtUsername;

  Future<User> getUser() async {
      String userName = crtUsername.text;
      return await ApiService.getAllInfoUser(userName);
  }

}