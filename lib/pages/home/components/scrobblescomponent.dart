import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collage_fm/models/track.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:my_collage_fm/widgets/Loading.dart';
import 'package:url_launcher/url_launcher.dart';

Widget scrobbling({required Track track}){
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text('Scrobbling now', style: TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),)),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: GestureDetector(
            onTap: () async{
              var url = Uri.parse(track.url!);
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
            child: Container(
              height: 75,
              decoration: BoxDecoration(color: Couleurs.grey100,borderRadius: BorderRadius.circular(15.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), topLeft: Radius.circular(15)),
                    child: CachedNetworkImage(
                      key: UniqueKey(),
                      imageUrl: track.image!,
                      height: 75,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.black12,),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    )
                  ),
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 5),
                          child:  Text(track.name!,overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.primaryColor)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 5),
                          child:  Text(track.artist!,overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),  
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Loading(width: 50),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}