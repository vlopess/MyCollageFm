// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_collage_fm/models/album.dart';
import 'package:my_collage_fm/models/artist.dart';
import 'package:my_collage_fm/models/lovedtracks.dart';
import 'package:my_collage_fm/models/track.dart';
import 'package:my_collage_fm/models/user.dart';
import 'package:my_collage_fm/pages/home/components/lovedtrackcomponent.dart';
import 'package:my_collage_fm/service/prefs_service.dart';
import 'package:my_collage_fm/utils/apiurl.dart';


class ApiService {
  static const apiKey = "53ca750ff08680650a1aa431bf02a97a";
  
  static Future<User> findUserByUsername(String userName) async{
    User user = User();
    // 1) Pega os dados básicos do user [x]
    Uri url = Uri.parse(ApiUrl.buildUrl(Method.getinfoUser(userName), apiKey));
    var responsed = await http.get(url);        
    if (responsed.statusCode == 200) {
      var list = jsonDecode(responsed.body);
      user = User.fromJson(list['user']);
    }
    if(user.isNull()) throw Exception();
    return user;
  }

  static Future<Lovedtracks> getlovedtracksUser() async {
    Lovedtracks lovedtracks = Lovedtracks();
    var userName = await SharedPreference.getUsername();
    Uri url = Uri.parse(ApiUrl.buildUrl(Method.getlovedtracksUser(userName), apiKey));
    var responsed = await http.get(url);
    if (responsed.statusCode == 200) {
      var list = jsonDecode(responsed.body);
      lovedtracks = Lovedtracks.fromJson(list['lovedtracks']);          
      for (var e in lovedtracks.track!) {
        url = Uri.parse(ApiUrl.buildUrl(Method.getinfoTrack(e.artist!, e.name!), apiKey));
        responsed = await http.get(url);
        if(responsed.statusCode == 200){
          var list = jsonDecode(responsed.body);
          if(list['error'] == null){                           
            if(list['track']['album'] != null){
              var realImage = list['track']['album']['image'][2]['#text'];
              e.image = realImage;
            } 
          }
        }
      }
    }
    return lovedtracks;
  }

  static Future<List<Track>?> getrecenttracksUser() async{
    var userName = await SharedPreference.getUsername();
    var url = Uri.parse(ApiUrl.buildUrl(Method.getrecenttracksUser(userName), apiKey));
    var responsed =  await http.get(url);
    List<Track> recentTrack = List.empty();
    if (responsed.statusCode == 200) {
      var list = jsonDecode(responsed.body);
      list = list['recenttracks'];
      if(list['track'].isNotEmpty){
          recentTrack = List<Track>.from((list['track'] as List<dynamic>).map<Track>((x) => Track.fromJson(x as Map<String, dynamic>)));
      }          
    }
    return recentTrack;
  }

  static Future<List<Track>?> gettoptracksUser({String period = 'overall', int limit = 15}) async{
    List<Track>? toptracks;
    var userName = await SharedPreference.getUsername();
    var url = Uri.parse(ApiUrl.buildUrl(Method.gettoptracksUser(userName, period, limit), apiKey));
    var responsed = await http.get(url);
    if (responsed.statusCode == 200) {
      var list = jsonDecode(responsed.body);
      list = list['toptracks'];
      toptracks = List<Track>.from((list['track'] as List<dynamic>).map<Track>((x) => Track.fromJson(x as Map<String, dynamic>)));
      for (var e in toptracks) {            
        url = Uri.parse(ApiUrl.buildUrl(Method.getinfoTrack(e.artist!, e.name!), apiKey));
        responsed = await http.get(url);
        if(responsed.statusCode == 200){
          var list = jsonDecode(responsed.body);
          if(list['error'] == null){
            if(list['track']['album'] != null){
              var realImage = list['track']['album']['image'][2]['#text'];
              e.image = realImage;
            }else{
              url = Uri.parse(ApiUrl.buildUrl(Method.gettopalbumsArtist(e.name!), apiKey));
              responsed = await http.get(url);
              if(responsed.statusCode == 200){
                var list = jsonDecode(responsed.body);
                if(list['topalbums'] != null){
                  var lista = list['topalbums']['album'];
                  if(lista.isNotEmpty){
                    var realImage = list['topalbums']['album'][0]['image'][3]['#text'];
                    e.image = realImage;
                  }
                }
              }
            }
          }              
        }
        e.image = verificarImagem(e.image);
      }
    }
    return toptracks;
  }

  static Future<List<Artist>?> gettopartistsUser({String period = 'overall', int limit = 15}) async{
    var userName = await SharedPreference.getUsername();
    List<Artist>? topartists;
    var url = Uri.parse(ApiUrl.buildUrl(Method.gettopartistsUser(userName, period, limit), apiKey));
    var responsed = await http.get(url);
    if (responsed.statusCode == 200) {
      var list = jsonDecode(responsed.body);
      list = list['topartists'];
      topartists = List<Artist>.from((list['artist'] as List<dynamic>).map<Artist>((x) => Artist.fromJson(x as Map<String, dynamic>)));
      for (var e in topartists) {
        url = Uri.parse(ApiUrl.buildUrl(Method.gettopalbumsArtist(e.name!), apiKey));
        responsed = await http.get(url);
        if(responsed.statusCode == 200){
          var list = jsonDecode(responsed.body);
          if(list['topalbums']['album'] != null){
            var lista = list['topalbums']['album'] as List<dynamic>;
            if (lista.isNotEmpty) {
              var realImage = list['topalbums']['album'][0]['image'][3]['#text'];
              e.image = realImage;
            }
          }
        }
        e.image = verificarImagem(e.image);
      }
    }
    return topartists;
  }

  static Future<List<Album>?> gettopalbumsUser({String period = 'overall', int limit = 15}) async{
    var userName = await SharedPreference.getUsername();
    var url = Uri.parse(ApiUrl.buildUrl(Method.gettopalbumsUser(userName, period, limit), apiKey));
    List<Album>? topalbums;
    var responsed = await http.get(url);
    if (responsed.statusCode == 200) {
      var list = jsonDecode(responsed.body);
      list = list['topalbums'];
      topalbums = List<Album>.from((list['album'] as List<dynamic>).map<Album>((x) => Album.fromJson(x as Map<String, dynamic>)));
    } 
    return topalbums;
  }



}