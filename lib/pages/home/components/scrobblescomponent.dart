import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_collage_fm/models/track.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:my_collage_fm/widgets/Loading.dart';
import 'package:url_launcher/url_launcher.dart';

class Scrobbling extends StatelessWidget {
  final Track track;
  final Function()? onTapDetail;
  const Scrobbling({super.key, required this.track, this.onTapDetail});

  @override
  Widget build(BuildContext context) {
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
                height: 100,
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
                          height: 100,
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
                            child:  Text(track.name!,overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.primaryColor)),
                          ),
                          Text("por ${track.artist!}",overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white)),
                          if(track.album != null)...[
                            Text("do ${track.album}",overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white)),                          
                          ]
                        ],
                      ),
                    ), 
                    onTapDetail == null ? 
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Loading(width: 50),
                    ) :
                    IconButton(onPressed: onTapDetail, icon: const Icon(CupertinoIcons.add, color: Couleurs.primaryColor,))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}