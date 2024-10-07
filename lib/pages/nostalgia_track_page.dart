import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_collage_fm/models/nostalgia_track.dart';
import 'package:my_collage_fm/pages/detail_image.dart';
import 'package:my_collage_fm/pages/home/components/lovedtrackcomponent.dart';
import 'package:my_collage_fm/utils/couleurs.dart';


class NostalgiaTrackDetail extends ConsumerStatefulWidget {
  final NostalgiaTrack track;
  const NostalgiaTrackDetail({super.key, required this.track});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NostalgiaTrackDetailState();
}

class _NostalgiaTrackDetailState extends ConsumerState<NostalgiaTrackDetail> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Couleurs.secondaryDark,
      appBar: AppBar(backgroundColor: Couleurs.secondary, centerTitle: true,title:  const Text("Track Nostalgia", style: TextStyle(fontFamily: "Barlow",color: Colors.white),)),
      body: RefreshIndicator(
        backgroundColor: Couleurs.grey200,
        color: Couleurs.primaryColor,
        onRefresh: () async {
            setState(() {});    
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Couleurs.grey200,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Column(
                      children: [                      
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                            decoration: const BoxDecoration(
                              color: Couleurs.secondary,
                              borderRadius: BorderRadius.all(Radius.circular(20))                  
                            ),
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ClipRRect(      
                                    borderRadius: const BorderRadius.all(Radius.circular(15)),                                     
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: CachedNetworkImage(
                                        key: UniqueKey(),
                                        imageUrl: verificarImagem(widget.track.track!.image),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Container(color: Colors.black12,),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(widget.track.track!.name!,overflow: TextOverflow.visible, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 18, color: Couleurs.primaryColor)),
                                      Text("por ${widget.track.track!.artist!}",overflow: TextOverflow.visible, textAlign: TextAlign.start,style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                                    ],
                                  ),
                                )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),                      
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(alignment: Alignment.topLeft,child: Text("Description", textAlign: TextAlign.start, style: TextStyle(color: Couleurs.primaryColor, fontWeight: FontWeight.bold),)),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Couleurs.secondary,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  width: width * 0.95,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(widget.track.description!,overflow: TextOverflow.visible, textAlign: TextAlign.start,style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                                  )),
                              ],
                            )
                          ),                  
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: width,
                            height: height * 0.3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(15)),                                     
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailImage(imageurl: widget.track.imageUrl!),
                                  ));
                                },
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: widget.track.imageUrl!,
                                  placeholder: (context, url) => Container(color: Colors.black12,),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        )            
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

