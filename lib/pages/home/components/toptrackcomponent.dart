  import 'package:flutter/material.dart';
import 'package:my_collage_fm/models/track.dart';
import 'package:my_collage_fm/pages/home/components/lovedtrackcomponent.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:url_launcher/url_launcher.dart';

Widget toptrackcomponent({required List<Track> tracks}) => Padding(
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [        
        const Align(
          alignment: Alignment.topLeft,
          child: Text('Top Tracks', style: TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),)),
        SizedBox(
          height: 230,
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
    width: 160,
    child: Column(
      children: [
        Expanded(child: AspectRatio(
          aspectRatio: 4 /3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
              onTap: () async{
                var url = Uri.parse(track.url!);
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: Image.network(
                verificarImagem(track.image!), 
                fit: BoxFit.cover,
              ),
            ),
          ),
        )),
        const SizedBox(height: 8),
        Text(track.name!, overflow: TextOverflow.ellipsis,style: const  TextStyle(fontFamily: 'Barlow', fontSize: 18, color: Couleurs.white, fontWeight: FontWeight.bold),)
      ],
    ),
  );