// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collage_fm/models/track.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:url_launcher/url_launcher.dart';

/// {@category Components}
class CustomExpansionTile extends StatelessWidget {
  final List<Track> tracks;
  final String? title;

  const CustomExpansionTile({super.key, 
    required this.tracks,
    this.title,
  });

  @override
  Widget build(BuildContext context) {  
    double height = MediaQuery.of(context).size.height;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(          
          decoration: BoxDecoration(
            color: Couleurs.greyMedium,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ExpansionTile(
            backgroundColor: Couleurs.greyMedium,
            initiallyExpanded: true,
            iconColor: Couleurs.primaryColor,
            tilePadding: const EdgeInsets.only(left: 10, right: 10),
            title: Text(title!,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,fontFamily: 'Barlow')),
            children: <Widget>[
              SizedBox(
                height: height * 0.4,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => buildCardTrack(track: tracks[index]), 
                  itemCount: tracks.length
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
          const SizedBox(
            width: 50,
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
                Text("do ${track.album!}",overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    ),
  ),
);

String verificarImagemtrack(String? image) => image!.isEmpty  ? 'https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png':image;

