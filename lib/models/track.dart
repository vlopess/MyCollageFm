// ignore_for_file: unnecessary_this
import 'package:my_collage_fm/models/user.dart';

class Track {
  String? artist;
  String? url;
  String? name;
  String? image;
  String? album;
  String? playnow;

  Track(
      {this.artist='',
      this.url='',
      this.name='',
      this.image='',
      this.album='',
      this.playnow});

  Track.fromJson(Map<String, dynamic> json) {
    if(json['artist']['name'] == null){
      artist = formatar(json['artist']['#text']);
    }else{
      artist = formatar(json['artist']['name']);      
    }    
    url = json['url'];
    name = formatar(json['name']);
    image = json['image'][3]['#text'];    
    if(json['@attr'] != null) {
      playnow = json['@attr']['nowplaying'];
    }
    album = '';
    if (json['album'] != null) {
      album = formatar(json['album']['#text']);      
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['artist'] = this.artist!;
    data['url'] = this.url;
    data['name'] = this.name;
    data['image'] = this.image;
    data['nowplaying'] = this.playnow;
    data['album'] = this.album;
    return data;
  }
}