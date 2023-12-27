// ignore_for_file: file_names


import 'package:my_collage_fm/models/dto.dart';
import 'package:my_collage_fm/service/apiService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiCollage {

  static String address = "http://192.168.10.22:5000/generateCollage";

  static Future<void> gerarCollage(String tipo, String time, int size) async {
      int limit = size * size;
      String period = time;
      Dto dto = Dto(null,id: idGenerator(), size: size);
      if(tipo.compareTo('track') == 0) {
        var tracks = await ApiService.gettoptracksUser(period: period, limit: limit);
        dto.setCellListTrack(tracks!);
      }
      if(tipo.compareTo('artist') == 0) {
        var artists = await  ApiService.gettopartistsUser(period: period, limit: limit);
        dto.setCellListArtist(artists!);
      }
      if(tipo.compareTo('album') == 0) {
        var albums = await ApiService.gettopalbumsUser(period: period, limit: limit);
        dto.setCellListAlbum(albums!);
      }
      await generateCollage(dto);
  }
  static Future<Dto?> generateCollage(Dto dados) async {
    var url = Uri.parse(address);
    var data = dados.toMap();
    final responsed = await http.post(url, body: {'data':json.encode(data)});
    if (responsed.statusCode == 200) {
      return null;
    }
    return null;
  }
}

String idGenerator() {
  final now = DateTime.now();
  return now.microsecondsSinceEpoch.toString();
}