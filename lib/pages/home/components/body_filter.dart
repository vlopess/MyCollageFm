import 'package:flutter/material.dart';
import 'package:my_collage_fm/models/album.dart';
import 'package:my_collage_fm/models/artist.dart';
import 'package:my_collage_fm/pages/home/components/nothingfoundcomponent.dart';
import 'package:my_collage_fm/pages/home/components/topalbumscomponent.dart';
import 'package:my_collage_fm/pages/home/components/topartistscomponent.dart';
import 'package:my_collage_fm/pages/home/components/toptrackcomponent.dart';
import 'package:my_collage_fm/pages/home/shining/shining.dart';
import 'package:my_collage_fm/service/apiService.dart';
import 'package:my_collage_fm/utils/couleurs.dart';

class BodyFilter extends StatefulWidget {
  const BodyFilter({super.key});

  @override
  State<BodyFilter> createState() => _BodyFilterState();
}

class _BodyFilterState extends State<BodyFilter> {
  String filter = '7day';
  bool _select1 = true;
  bool _select2 = false;
  bool _select3 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Filter: $filter", style: const TextStyle(color: Couleurs.primaryColor, fontSize: 16)),
                IconButton(onPressed: () => showSheetFilter(context), icon: const Icon(Icons.list), color: Couleurs.primaryColor,),
              ],
            ),
          ), 
        FutureBuilder(
            future: ApiService.gettoptracksUser(period: filter), 
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
              return const Shining(title: 'Top Tracks');
              }
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError) return const NothingFoundComponent(title: 'Top Tracks');
                var tracks = snapshot.data!; 
                return tracks.isEmpty ?  const NothingFoundComponent(title: 'Top Tracks') : TopTrackComponent(tracks: tracks);
              }
              return const Shining(title: 'Top Tracks');
            },
          ),
          FutureBuilder(
            future: ApiService.gettopartistsUser(period: filter), 
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Shining(title: 'Top Artists');
              }
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError) return const NothingFoundComponent(title: 'Top Artists');
                List<Artist> artists = List.empty();
                if(snapshot.hasData) artists = snapshot.data!;                
                return artists.isEmpty ? const NothingFoundComponent(title: 'Top Artists') : TopArtistsComponent(artists: artists);
              }
              return const Shining(title: 'Top Artists');
            },
          ),
          FutureBuilder(
            future: ApiService.gettopalbumsUser(period: filter), 
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Shining(title: 'Top Albums');
              }
              if(snapshot.connectionState == ConnectionState.done){
                List<Album> albuns = List.empty();
                if(snapshot.hasData) albuns = snapshot.data!;                 
                return albuns.isEmpty ? const NothingFoundComponent(title: 'Top Albums') : TopAlbumComponent(albuns: albuns);
              }
              return const Shining(title: 'Top Albums');
            },
          ),
      ],
    );
  }
  
void enableAll() {
  _select1 = false;
  _select2 = false;
  _select3 = false;
}

Future<dynamic> showSheetFilter(BuildContext context) {
    return showModalBottomSheet(
      context: context, 
      backgroundColor: Couleurs.grey200,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      builder: (context) {
      return SizedBox(
        height: 210,
        child: Column(
          children: [
            const Center(child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Filter', style: TextStyle(color: Couleurs.primaryColor,fontSize: 18),),
            )),
            GestureDetector(onTap: () async{
              Navigator.pop(context);
              setState(() {
                filter = '7day';
                enableAll();
                _select1 = true;
              });                  
            }, child: SizedBox(height: 50,child: Text("Last 7 days", style: TextStyle(fontSize: 18, color: _select1 ? Couleurs.primaryColor :Colors.white)),),),
            GestureDetector(onTap: () async{
              Navigator.pop(context);                            
              setState(() {
                filter = '1month';
                enableAll();
                _select2 = true;
              });    
            }, child: SizedBox(height: 50,child: Text("Last 30 days", style: TextStyle(fontSize: 18, color: _select2 ? Couleurs.primaryColor :Colors.white)),),),
            GestureDetector(onTap: () async{
              Navigator.pop(context);
              setState(() {
                filter = 'OverAll';
                enableAll();
                _select3 = true;
              });                  
            }, child: SizedBox(height: 50,child: Text("All Time", style: TextStyle(fontSize: 18, color: _select3 ? Couleurs.primaryColor :Colors.white)),),),
          ],
        ),
    );
    });
  }
}