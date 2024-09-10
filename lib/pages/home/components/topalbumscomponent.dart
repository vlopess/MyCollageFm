import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collage_fm/models/album.dart';
import 'package:my_collage_fm/pages/home/components/lovedtrackcomponent.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:url_launcher/url_launcher.dart';

class TopAlbumComponent extends StatelessWidget {
  final List<Album> albuns;
  const TopAlbumComponent({super.key, required this.albuns});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const  EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [        
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Top Albums', style: TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),),
            )),
          Container(
            decoration: BoxDecoration(
              color: Couleurs.greyMedium,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 230,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => buildCardAlbum(album: albuns[index]), 
              separatorBuilder: (context, index) => const SizedBox(width: 12), 
              itemCount: albuns.length
            ),
          ),
        ],
      ),
    );
  }
}


  Widget buildCardAlbum({required Album album}) => SizedBox(
    width: 160,
    child: Column(
      children: [
        Expanded(
          child: AspectRatio(
          aspectRatio: 4 /3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
              onTap: () async{
                var url = Uri.parse(album.url!);
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: CachedNetworkImage(
                key: UniqueKey(),
                imageUrl: verificarImagem(album.image), 
                height: 75,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Colors.black12,),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            ),
          ),
        )),
        const SizedBox(height: 8),
        Text(album.name!, overflow: TextOverflow.ellipsis,style: const  TextStyle(fontFamily: 'Barlow', fontSize: 18, color: Couleurs.white, fontWeight: FontWeight.bold),)
      ],
    ),
  );