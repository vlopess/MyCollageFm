// ignore_for_file: unnecessary_this

import 'package:my_collage_fm/models/artist.dart';

class Album {
  Artist? artist;
  String? image;
  String? url;
  String? playcount;
  String? name;

  Album(
      {this.artist,
      this.image,
      this.url,
      this.playcount,
      this.name});

  Album.fromJson(Map<String, dynamic> json) {
    artist = json['artist'] != null ? Artist.fromJson(json['artist']) : null;
    image = json['image'][2]['#text'];    
    url = json['url'];
    playcount = json['playcount'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.artist != null) {
      data['artist'] = this.artist!.toJson();
    }
    data['image'] = this.image;
    data['url'] = this.url;
    data['playcount'] = this.playcount;
    data['name'] = this.name;
    return data;
  }
}