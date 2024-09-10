import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_collage_fm/utils/couleurs.dart';

class ContainerImage extends StatefulWidget {
  final void Function(File image)? onGet;
  const ContainerImage({super.key, required this.onGet});

  @override
  State<ContainerImage> createState() => _ContainerImageState();
}

class _ContainerImageState extends State<ContainerImage> {
  File? file;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        height: height * 0.3,
        decoration: const BoxDecoration(
          color: Couleurs.secondary,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Center(
          child: GestureDetector(
            onLongPress: getImage,
            onTap: getImage,
            child: file != null ?
            Image.file(file!)
            : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo_outlined, color: Couleurs.greyLight,),
                Text("Add Image", style: TextStyle(fontFamily: 'Barlow', color: Couleurs.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    ImageSource? source = await _openDialogChoice<ImageSource>(context);
    var image = await _pickImage(source);
    if(image != null) {
      setState(() {
        file = image;        
      });
      widget.onGet!(image);
    }
  }


  Future _pickImage(ImageSource? source) async {
    if(source == null) return;
    var file =  await ImagePicker().pickImage(source: source);
    if(file == null) return;
    return File(file.path);
  }

  Future<T?> _openDialogChoice<T>(BuildContext context) async {
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
                  const Text('Choose the image source', style: TextStyle(fontFamily: "Barlow", color: Couleurs.white)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),onPressed: () { Navigator.pop(context, ImageSource.gallery); }, child: const Text("Gallery", style: TextStyle(fontFamily: "Barlow", color: Couleurs.white))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),onPressed: () { Navigator.pop(context, ImageSource.camera);}, child: const Text("Camera", style: TextStyle(fontFamily: "Barlow", color: Couleurs.white))),
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