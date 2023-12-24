// ignore_for_file: file_names

import 'dart:convert';

class User {
  String? name;
  String? realname;
  String? playcount;
  String? artistCount;
  String? image;
  String? country;
  String? url;  

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

  bool isNull(){
    return name == null || url == null || image == null;
  }
}

String formatar(String value) {
    value = value.replaceAll(RegExp(r'"'), ';');
    String jsonString = "{\"texto\": \"$value\"}";
    var decodedJson = jsonDecode(utf8.decode(jsonString.runes.toList()));
    decodedJson['texto'] = decodedJson['texto'].replaceAll(RegExp(r';'), '"');
    return decodedJson['texto'];
}