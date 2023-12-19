// ignore_for_file: file_names

import 'dart:convert';

import 'package:my_collage_fm/models/album.dart';
import 'package:my_collage_fm/models/artist.dart';
import 'package:my_collage_fm/models/lovedtracks.dart';
import 'package:my_collage_fm/models/track.dart';

class User {
  String? name;
  String? realname;
  String? playcount;
  String? artistCount;
  String? image;
  String? country;
  String? url;  
  late Lovedtracks lovedtracks;
  late Track recentTrack;
  late List<Track> toptracks;
  late Track toptrack;
  late List<Artist>? topartists;
  late List<Album>? topalbums;

  User(
      {this.name,
      this.realname,
      this.playcount,
      this.artistCount,
      this.image,
      this.country,
      this.url});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    realname = json['realname'];
    playcount = json['playcount'];
    artistCount = json['artist_count'];
    image = json['image'][3]['#text'];    
    country = json['country'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['realname'] = realname;
    data['playcount'] = playcount;
    data['artist_count'] = artistCount;
    data['image']  = image;
    data['country'] = country;
    data['url'] = url;
    return data;
  }
}

String formatar(String value) {
    String jsonString = '{"texto": "$value"}';
    var decodedJson = jsonDecode(utf8.decode(jsonString.runes.toList()));
    return decodedJson['texto'];
}