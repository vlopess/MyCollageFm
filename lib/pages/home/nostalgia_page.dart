import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_collage_fm/models/nostalgia_track.dart';
import 'package:my_collage_fm/models/track.dart';
import 'package:my_collage_fm/models/track_dto.dart';
import 'package:my_collage_fm/pages/home/components/add_nostalgia_track_body.dart';
import 'package:my_collage_fm/pages/home/components/container_list.dart';
import 'package:my_collage_fm/pages/home/components/container_track_list.dart';
import 'package:my_collage_fm/pages/home/components/nothingfoundcomponent.dart';
import 'package:my_collage_fm/pages/home/components/scrobblescomponent.dart';
import 'package:my_collage_fm/pages/nostalgia_track_page.dart';
import 'package:my_collage_fm/pages/home/shining/shiningScrobble.dart';
import 'package:my_collage_fm/pages/home/shining/shining_container_track_list.dart';
import 'package:my_collage_fm/service/apiService.dart';
import 'package:my_collage_fm/service/user_service.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:url_launcher/url_launcher.dart';


class Nostalgia extends ConsumerStatefulWidget {
  const Nostalgia({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NostalgiaState();
}

class _NostalgiaState extends ConsumerState<Nostalgia> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Couleurs.grey200,
      color: Couleurs.primaryColor,
      onRefresh: () async {
          setState(() {});    
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [   
            FutureBuilder(
              future: ApiService.getrecenttracksUser(), 
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const ShiningScrobble();
                }
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError) return Container();
                  Track track = snapshot.data!.first; 
          
                  return track.playnow == null? Container() : 
                  Scrobbling(track: track, onTapDetail: () async {                      
                      bool? hasAdd = await showSheetAddNostalgiaTrack(context, track);
                      if(hasAdd != null && hasAdd) setState(() {});
                  });
                }
                return const ShiningScrobble();
              },
            ),
          
            FutureBuilder(
              future: ApiService.gettoptracksUser(period: "7day"), 
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) return const SiningContainerTrakList(title: "Most Played in the last week", height: 200,);
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError) return const NothingFoundComponent(title: 'Top Tracks');
                  var tracks = snapshot.data!; 
                  return tracks.isEmpty ?  const NothingFoundComponent(title: 'Top Tracks') :
                  ContainerTrackList(
                    title: "Most Played in the last week",
                    tracks: tracks,
                    height: 200,
                    iconDetail: Icons.add,
                    onPressedDetail: (track) async {
                      bool? hasAdd = await showSheetAddNostalgiaTrack(context, track);
                      if(hasAdd != null && hasAdd) setState(() {});
                    },
                  );
                }
                return const SiningContainerTrakList(title: "Most Played in the last week", height: 200,);
              },
            ),
            FutureBuilder(
              future: ref.read(userService).getNostalgiaTracksUser(), 
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) return const SiningContainerTrakList(title: "Nostalgia");
                if(snapshot.connectionState == ConnectionState.done){
                  List<NostalgiaTrack> tracks = List.empty();                    
                  if(snapshot.hasData) {
                    var data = snapshot.data?.data()?['nostalgiaTracks'];
                    if(data != null) tracks =  List<NostalgiaTrack>.of((data as List<dynamic>).map((e) => NostalgiaTrack.fromMap(e))).toList();
                  }
                  return ContainerNostalgiaTrackList(
                    title: "Nostalgia",
                    tracks: tracks,
                    iconDetail: Icons.keyboard_arrow_right_sharp,
                    onPressedDetail: (track) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NostalgiaTrackDetail(track: track),));
                    },
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
  

  Widget buildCardTrack({required Track track}) => Padding(
    padding: const EdgeInsets.only(top: 16),
    child: GestureDetector(
      onTap: () async{
        var url = Uri.parse(track.url!);
        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
        }
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(color: Couleurs.secondary,borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 80,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), topLeft: Radius.circular(15)),
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: track.image!,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.black12,),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              ),
            ),
            SizedBox(
              width: 200,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 1.0, top: 5),
                    child:  Text(track.name!,overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 14, color: Couleurs.primaryColor)),
                  ),
                  Text("por ${track.artist!}",overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  Text("do ${track.album}",overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                ],
              ),
            ),
            IconButton(
              onPressed: () => showSheetAddNostalgiaTrack(context, track),
              icon: const Icon(Icons.arrow_forward_ios_rounded, color: Couleurs.primaryColor,)
            )
          ],
        ),
      ),
    ),
  );

Future<dynamic> showSheetAddNostalgiaTrack<T>(BuildContext context, Track track) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      backgroundColor: Couleurs.secondary,
      builder: (context) {
        return AddNostalgiaTrackBody(track: TrackDTO(name: track.name, artist: track.artist, image: track.image));
      });
  } 

}

