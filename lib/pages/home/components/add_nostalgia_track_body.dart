import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_collage_fm/components/textField.dart';
import 'package:my_collage_fm/controllers/nostalgiaTrackController.dart';
import 'package:my_collage_fm/models/track_dto.dart';
import 'package:my_collage_fm/pages/home/components/container_image.dart';
import 'package:my_collage_fm/pages/home/components/lovedtrackcomponent.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:my_collage_fm/widgets/LoadingCollage.dart';

class AddNostalgiaTrackBody extends ConsumerStatefulWidget {
  final TrackDTO track;
  const AddNostalgiaTrackBody({super.key, required this.track});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddNostalgiaTrackBodyState();
}

class _AddNostalgiaTrackBodyState extends ConsumerState<AddNostalgiaTrackBody> {
  bool isLoading = false;
  late NostalgiaTrackController controller;  
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller = NostalgiaTrackController(ref: ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    controller.crtTrack = widget.track;
    return SizedBox(
      height: height * 0.9,
      width: width,
      child: Container(
        decoration: const BoxDecoration(
          color: Couleurs.grey200,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        child: Column(
          children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Couleurs.greyLight,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                width: width,
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
                            imageUrl: verificarImagem(widget.track.image),
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
                          Text(widget.track.name!,overflow: TextOverflow.visible, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 18, color: Couleurs.primaryColor)),
                          Text("por ${widget.track.artist!}",overflow: TextOverflow.visible, textAlign: TextAlign.start,style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                        ],
                      ),
                    )
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                  width: width * 0.95,
                  child: Form(
                    key: formKey,
                    child: textArea(
                      title: 'Enter Description',
                      controller: controller.crtDescription
                    ),
                  ),
                ),
                            ),
              ),
            Flexible(
              child: ContainerImage(
                onGet: (image) {
                  setState(() {
                    controller.crtFile = image;
                  });
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: isLoading ? const LoadingCollage(width: 60,) : Visibility(
                  visible: controller.isValid,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),
                    onPressed: () async {
                      setState(() => isLoading = !isLoading);
                      if (formKey.currentState!.validate()) {
                        await controller.save().then((value){                          
                          Navigator.pop(context, true);
                        });
                      }
                      setState(() => isLoading = !isLoading);
                    },
                    child: const Text("Save", style: TextStyle(fontFamily: 'Barlow', color: Couleurs.white)),
                  ),
                ),
              ),
            ),              
          ],
        ),
      ),
    );
  }
}
