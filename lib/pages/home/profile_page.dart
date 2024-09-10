import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collage_fm/components/ColumnCustom.dart';
import 'package:my_collage_fm/components/CustomExpansionTile.dart';
import 'package:my_collage_fm/models/lovedtracks.dart';
import 'package:my_collage_fm/models/track.dart';
import 'package:my_collage_fm/pages/home/components/body_filter.dart';
import 'package:my_collage_fm/pages/home/components/lovedtrackcomponent.dart';
import 'package:my_collage_fm/pages/home/components/scrobblescomponent.dart';
import 'package:my_collage_fm/pages/home/shining/shiningLovedTracks.dart';
import 'package:my_collage_fm/pages/home/shining/shiningScrobble.dart';
import 'package:my_collage_fm/service/apiService.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  final String userName;
  final String userImage;
  final String userUrl;
  const Profile({super.key, required this.userName, required this.userImage, required this.userUrl});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async{
                      var url = Uri.parse(widget.userUrl);
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(                      
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CachedNetworkImage(
                            key: UniqueKey(),
                            imageUrl: verificarImagem(widget.userImage),
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(color: Colors.black12,),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: ApiService.findUserByUsername(widget.userName), 
                    builder: (context, snapshot) {                    
                      if(snapshot.connectionState == ConnectionState.done){
                        var user = snapshot.data; 
                        return Row(
                            children: [
                              ColumnCustom(label: 'Scrobbles', title: user?.playcount),
                              ColumnCustom(label: 'Artists', title: user?.artistCount!),
                            ],
                        ); 
                      }
                      return Container();
                    },
                  ), 
                  const SizedBox(
                    width: 10,
                  )
                ],        
              ),
            ),                      
            FutureBuilder(
              future: ApiService.getrecenttracksUser(), 
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const ShiningScrobble();
                }
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError) return Container();                  
                  List<Track> tracks = snapshot.data!; 
                  Track track = tracks.removeAt(0);
                  return Column(
                    children: [
                      track.playnow == null? Container() : Scrobbling(track: track),
                      CustomExpansionTile(
                        title: "Scrobbles Recents",
                        tracks: List.from(tracks),
                      ), 
                    ],
                  );
                }
                return const ShiningScrobble();
              },
            ),
            FutureBuilder(
              future: ApiService.getlovedtracksUser(), 
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const ShiningLovedTracks();
                }
                if(snapshot.connectionState == ConnectionState.done){
                  Lovedtracks tracks = Lovedtracks();
                  if(snapshot.hasData) tracks = snapshot.data!;
                  return tracks.track!.isEmpty ? Container() : lovedTrackComponent(tracks: tracks.track!);
                }
                return const ShiningLovedTracks();
              },
            ),
            const BodyFilter(),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}