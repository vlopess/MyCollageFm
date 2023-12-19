// ignore_for_file: unnecessary_this

import 'package:my_collage_fm/models/user.dart';

class Artist {
  String? image;
  String? url;
  String? playcount;
  String? name;

  Artist(
      {
      this.image,
      this.url,
      this.playcount,
      this.name});

  Artist.fromJson(Map<String, dynamic> json) {
    if(json['image'] != null) {
      image = json['image'][3]['#text'];
    }    
    url = json['url'];
    if(json['playcount'] != null) {
      playcount = json['playcount'];
    }
    name = formatar(json['name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = this.image;
    data['url'] = this.url;
    data['playcount'] = this.playcount;
    data['name'] = this.name;
    return data;
  }
}