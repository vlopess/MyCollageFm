// ignore_for_file: file_names
import 'dart:io';

import 'package:my_collage_fm/models/dto.dart';
import 'package:my_collage_fm/service/apiService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class ApiCollage {

  static String address = "http://192.168.10.22:5000/generateCollage";

  static Future<String> gerarCollage(String tipo, String time, int size) async {
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
      return await generateCollage(dto);
      
  }
  static Future<String> generateCollage(Dto dados) async {
    String filename = "";
    try {
      var url = Uri.parse(address);
      var data = dados.toMap();
      final response = await http.post(url, body: {'data':json.encode(data)});
      if (response.statusCode == 200) {
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        filename = '$tempPath/${dados.id}.pdf';
        File file = File(filename);
        await file.writeAsBytes(response.bodyBytes);      
      }
      return filename;
    } catch (e) {
      return filename;
    }
  }
}

String idGenerator() {
  final now = DateTime.now();
  return now.microsecondsSinceEpoch.toString();
}