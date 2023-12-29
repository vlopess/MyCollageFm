import 'package:my_collage_fm/models/album.dart';
import 'package:my_collage_fm/models/artist.dart';
import 'package:my_collage_fm/models/track.dart';

class Dto {
  String id;
  List<Cell>? cellList;
  final int size;

  Dto(this.cellList,{required this.id,required this.size});  

  setCellListTrack(List<Track> tracks){
      List<Cell> cellList = [];
      for (var e in tracks) {
        Cell cell = Cell(e.image!, '${e.artist} - ${e.name!}');
        cellList.add(cell);
      }
      this.cellList = cellList;
  }
  setCellListArtist(List<Artist> artists){
      List<Cell> cellList = [];
      for (var e in artists) {
        Cell cell = Cell(e.image!, e.name!);
        cellList.add(cell);
      }
      this.cellList = cellList;
  }
  setCellListAlbum(List<Album> albums){
      List<Cell> cellList = [];
      for (var e in albums) {
        Cell cell = Cell(e.image!, '${e.artist!.name} - ${e.name!}');
        cellList.add(cell);
      }
      this.cellList = cellList; 
  }

  Map<String, dynamic>? toMap() {
    return <String, dynamic>{
      'id': id,
      'size': size,
      'cellList': cellList?.map((x) => x.toMap()).toList(),
    };
  }
}

class Cell {
  String urlImage;
  String name;
  Cell(this.urlImage, this.name);

  Map<String, dynamic>? toMap() {
    return <String, dynamic>{
      'urlImage': urlImage,
      'name': name
    };
  }
}