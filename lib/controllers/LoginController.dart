// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_collage_fm/models/user.dart';
import 'package:my_collage_fm/service/apiService.dart';
import 'package:my_collage_fm/service/prefs_service.dart';

class LoginController {

  final _crtUsername = TextEditingController();

  TextEditingController get crtUsername => _crtUsername;

  Future<User> getUser() async {
      String userName = crtUsername.text;
      SharedPreference.save(userName);
      return await ApiService.getAllInfoUser(userName);
  }

}