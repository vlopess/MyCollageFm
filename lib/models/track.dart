// ignore_for_file: unnecessary_this

import 'dart:convert';

import 'package:my_collage_fm/models/user.dart';

class Track {
  String? artist;
  String? url;
  String? name;
  String? image;
  String? playnow;

  Track(
      {this.artist,
      this.url,
      this.name,
      this.image,
      this.playnow});

  Track.fromJson(Map<String, dynamic> json) {
    if(json['artist']['name'] == null){
      artist = formatar(json['artist']['#text']);
    }else{
      artist = formatar(json['artist']['name']);      
    }    
    url = json['url'];
    String jsonString = '{"texto": "${json['name']}"}';
    var decodedJson = jsonDecode(utf8.decode(jsonString.runes.toList()));
    name = decodedJson['texto'];
    image = json['image'][3]['#text'];    
    if(json['@attr'] != null) {
      playnow = json['@attr']['nowplaying'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['artist'] = this.artist!;
    data['url'] = this.url;
    data['name'] = this.name;
    data['image'] = this.image;
    data['nowplaying'] = this.playnow;
    return data;
  }
}