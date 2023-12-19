  import 'package:flutter/material.dart';
import 'package:my_collage_fm/models/track.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:url_launcher/url_launcher.dart';

Widget lovedTrackComponent({required List<Track> tracks}) => Padding(
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [        
        const Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [              
              Text('Loved Tracks', style: TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),),
              Icon(Icons.favorite, color: Colors.red,),
            ],
          )),
        SizedBox(
          height: 200,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => buildCardTrack(track: tracks[index]), 
            separatorBuilder: (context, index) => const SizedBox(width: 12), 
            itemCount: tracks.length
          ),
        ),
      ],
    ),
  );
    Widget buildCardTrack({required Track track}) => SizedBox(
    width: 100,
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            onTap: () async{
              var url = Uri.parse(track.url!);
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
            child: Image.network(
              verificarImagem(track.image), 
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(track.name!, overflow: TextOverflow.visible,style: const  TextStyle(fontFamily: 'Barlow', fontSize: 18, color: Couleurs.white, fontWeight: FontWeight.bold),)
      ],
    ),
  );

String verificarImagem(String? image) => image!.isEmpty ? 'https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png':image;