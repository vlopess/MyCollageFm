import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_collage_fm/models/nostalgia_track.dart';
import 'package:my_collage_fm/service/user_service.dart';
import 'package:my_collage_fm/utils/couleurs.dart';


class ContainerNostalgiaTrackList extends ConsumerStatefulWidget {
  final List<NostalgiaTrack> tracks;
  final String title;
  final IconData iconDetail;
  final void Function(NostalgiaTrack track) onPressedDetail;
  final double? height;
  const ContainerNostalgiaTrackList({super.key,required this.title, required this.tracks, required this.iconDetail, required this.onPressedDetail,this.height = 300});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContainerNostalgiaTrackListState();
}

class _ContainerNostalgiaTrackListState extends ConsumerState<ContainerNostalgiaTrackList> {

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
              itemBuilder: (context, index) => buildCardTrack(track: widget.tracks[index], onLongPress: () async {
                bool? toDelete = await _openDialogDelete<bool>(context, widget.tracks[index]);
                if (toDelete != null && toDelete) {
                  setState(() {
                  widget.tracks.removeAt(index);
                });
                }
              },), 
              itemCount: widget.tracks.length
            ),
          ),
        ),
      ],
    );
  }
  Widget buildCardTrack({required NostalgiaTrack track, required Function()? onLongPress}) => Padding(
    padding: const EdgeInsets.only(top: 16),
    child: GestureDetector(
      onLongPress: onLongPress,
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
                  imageUrl: track.track!.image!,
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
                    child:  Text(track.track!.name!,overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 14, color: Couleurs.primaryColor)),
                  ),
                  Text("por ${track.track!.artist!}",overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  Text("${track.description}",overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
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

  Future<T?> _openDialogDelete<T>(BuildContext context, NostalgiaTrack nostalgiaTrack) async {
    return showGeneralDialog(   
      barrierLabel: '',
      barrierDismissible: true, 
      context: context, 
      pageBuilder: (context, animation, secondaryAnimation) => Container(),
      transitionBuilder: (context, animation, secondaryAnimation, child) 
        => ScaleTransition(
          scale: Tween<double>(begin: 0.5,end: 1.0).animate(animation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5,end: 1.0).animate(animation),
            child: AlertDialog(
              backgroundColor: Couleurs.grey200,                              
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Want to remove nostalgia track?', style: TextStyle(fontFamily: "Barlow", color: Couleurs.white)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),onPressed: () { Navigator.pop(context, false); }, child: const Text("No", style: TextStyle(fontFamily: "Barlow", color: Couleurs.white))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),onPressed: () async { ref.read(userService).deleteNostalgiaTrack(nostalgiaTrack: nostalgiaTrack);  Navigator.pop(context, true);}, child: const Text("Yes", style: TextStyle(fontFamily: "Barlow", color: Couleurs.white))),
                      ),                      
                    ],
                  )
                ],
              ),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
    );
  }

}
