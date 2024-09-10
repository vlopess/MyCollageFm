// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_collage_fm/models/nostalgia_track.dart';
import 'package:my_collage_fm/models/track_dto.dart';
import 'package:my_collage_fm/service/user_service.dart';



class NostalgiaTrackController {
  final WidgetRef? ref;
  final  _crtDescription = TextEditingController();
  File? crtFile;
  late TrackDTO crtTrack;
  TextEditingController get crtDescription => _crtDescription;
  bool get isValid => crtFile != null && crtDescription.text.isNotEmpty;

  NostalgiaTrackController({this.ref});
  
  Future<void> save() async {
    if(isValid){
      String description = crtDescription.text;
      NostalgiaTrack track = NostalgiaTrack(description: description, image: crtFile, track: crtTrack);
      await ref?.read(userService).saveNostalgiaTrack(track);
    }
  }
  
}


