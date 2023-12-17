// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_collage_fm/models/album.dart';
import 'package:my_collage_fm/models/artist.dart';
import 'package:my_collage_fm/models/lovedtracks.dart';
import 'package:my_collage_fm/models/track.dart';
import 'package:my_collage_fm/models/user.dart';


class ApiService {
  static const apiKey = "53ca750ff08680650a1aa431bf02a97a";

  static Future<User> getAllInfoUser(String userName) async {
    try {
        User user = User();
        // 1) Pega os dados básicos do user [x]
        Uri url = Uri.parse("https://ws.audioscrobbler.com/2.0/?method=user.getinfo&user=$userName&api_key=$apiKey&format=json");
        var responsed = await http.get(url);        
        if (responsed.statusCode == 200) {
          var list = jsonDecode(responsed.body);
          user = User.fromJson(list['user']);
        }
        // 2) Pega as faixas preferidas do user [x]
        url = Uri.parse("https://ws.audioscrobbler.com/2.0/?method=user.getlovedtracks&user=$userName&api_key=$apiKey&format=json");
        responsed = await http.get(url);
        if (responsed.statusCode == 200) {
          var list = jsonDecode(responsed.body);
          user.lovedtracks = Lovedtracks.fromJson(list['lovedtracks']);
        }
        // 3) Pega as faixas recentes do user [ok]
        url = Uri.parse("https://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=$userName&api_key=$apiKey&limit=1&format=json");
        responsed = await http.get(url);
        if (responsed.statusCode == 200) {
          var list = jsonDecode(responsed.body);
          list = list['recenttracks'];
          user.recentTrack = List<Track>.from((list['track'] as List<dynamic>).map<Track>((x) => Track.fromJson(x as Map<String, dynamic>))).first;
        }
        // 4) Pega top faixas do user [ok]
        url = Uri.parse("https://ws.audioscrobbler.com/2.0/?method=user.gettoptracks&user=$userName&api_key=$apiKey&limit=5&format=json");
        responsed = await http.get(url);
        if (responsed.statusCode == 200) {
          var list = jsonDecode(responsed.body);
          list = list['toptracks'];
          user.toptrack = List<Track>.from((list['track'] as List<dynamic>).map<Track>((x) => Track.fromJson(x as Map<String, dynamic>)));
        }
        // 4) Pega top artista do user [ok]
        url = Uri.parse("https://ws.audioscrobbler.com/2.0/?method=user.gettopartists&user=$userName&api_key=$apiKey&limit=5&format=json");
        responsed = await http.get(url);
        if (responsed.statusCode == 200) {
          var list = jsonDecode(responsed.body);
          list = list['topartists'];
          user.topartists = List<Artist>.from((list['artist'] as List<dynamic>).map<Artist>((x) => Artist.fromJson(x as Map<String, dynamic>)));
        }
        // 4) Pega top albuns do user [ok]
        url = Uri.parse("https://ws.audioscrobbler.com/2.0/?method=user.gettopalbums&user=$userName&api_key=$apiKey&limit=5&format=json");
        responsed = await http.get(url);
        if (responsed.statusCode == 200) {
          var list = jsonDecode(responsed.body);
          list = list['topalbums'];
          user.topalbums = List<Album>.from((list['album'] as List<dynamic>).map<Album>((x) => Album.fromJson(x as Map<String, dynamic>)));
        }
        return user;
      
    } catch (ex) {
      rethrow;
    }
  }

}