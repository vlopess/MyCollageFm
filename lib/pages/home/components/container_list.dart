import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collage_fm/models/track.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:url_launcher/url_launcher.dart';

class ContainerTrackList extends StatefulWidget {
  final List<Track> tracks;
  final String title;
  final IconData iconDetail;
  final void Function(Track track) onPressedDetail;
  final double? height;
  const ContainerTrackList({super.key,required this.title, required this.tracks, required this.iconDetail, required this.onPressedDetail,this.height = 300});

  @override
  State<ContainerTrackList> createState() => _ContainerTrackListState();
}

class _ContainerTrackListState extends State<ContainerTrackList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title, style: const TextStyle(color: Couleurs.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(                  
              color: Couleurs.greyMedium,
              borderRadius: BorderRadius.all(Radius.circular(20))                  
            ),
            height: widget.tracks.isEmpty ? 200 : widget.height,
            child: widget.tracks.isEmpty ? const Center(child: Text("There is still no nostalgia",  style: TextStyle(fontFamily: 'Barlow', color: Couleurs.primaryColor, fontWeight: FontWeight.bold)),) :
             ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => buildCardTrack(track: widget.tracks[index]), 
              itemCount: widget.tracks.length
            ),
          ),
        ),
      ],
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
                ],
              ),
            ),
            IconButton(
              onPressed: () => widget.onPressedDetail(track),
              icon: Icon(widget.iconDetail, color: Couleurs.primaryColor,)
            )
          ],
        ),
      ),
    ),
  );

}
