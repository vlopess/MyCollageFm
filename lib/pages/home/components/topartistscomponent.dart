  import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collage_fm/models/artist.dart';
import 'package:my_collage_fm/pages/home/components/lovedtrackcomponent.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:url_launcher/url_launcher.dart';

Widget topartistscomponent({required List<Artist> artists}) => Padding(
    padding: const  EdgeInsets.only(left: 10, right: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [        
        const Align(
          alignment: Alignment.topLeft,
          child: Text('Top Artists', style: TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),)),
        SizedBox(
          height: 230,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => buildCardArtist(artist: artists[index]), 
            separatorBuilder: (context, index) => const SizedBox(width: 12), 
            itemCount: artists.length
          ),
        ),
      ],
    ),
  );
    Widget buildCardArtist({required Artist artist}) => SizedBox(
    width: 160,
    child: Column(
      children: [
        Expanded(child: AspectRatio(
          aspectRatio: 4 /3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
              onTap: () async{
                var url = Uri.parse(artist.url!);
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: CachedNetworkImage(
                key: UniqueKey(),
                imageUrl: verificarImagem(artist.image!), 
                height: 75,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Colors.black12,),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
              // Image.network(
              //   verificarImagem(artist.image!), 
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
        )),
        const SizedBox(height: 8),
        Text(artist.name!, overflow: TextOverflow.ellipsis,style: const  TextStyle(fontFamily: 'Barlow', fontSize: 18, color: Couleurs.white, fontWeight: FontWeight.bold),)
      ],
    ),
  );