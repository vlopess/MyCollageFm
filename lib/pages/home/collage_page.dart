
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_collage_fm/service/apiCollage.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:my_collage_fm/widgets/Done.dart';
import 'package:my_collage_fm/widgets/LoadingCollage.dart';
import 'package:open_file/open_file.dart';

class Collage extends StatefulWidget {
  const Collage({super.key});

  @override
  State<Collage> createState() => _CollageState();
}

class _CollageState extends State<Collage> {
  int? _sliding1 = 0;
  int? _sliding2 = 0;
  int? _sliding3 = 0;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    double? height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      backgroundColor: Couleurs.grey200,
      color: Couleurs.primaryColor,
      onRefresh: () async {
          setState(() {});    
      },
      child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [            
            Flexible(
              child: SizedBox(
                height: height * 0.35,
                child: Image.asset("assets/png/Music-bro.png")
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Couleurs.greyMedium,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text('Collage Type', style: TextStyle(fontFamily: 'Barlow', fontSize: 18, color: Couleurs.white, fontWeight: FontWeight.bold),)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: CupertinoSlidingSegmentedControl(
                          backgroundColor: Couleurs.primaryColor,
                          onValueChanged: (int? value) { 
                            setState(() {
                              _sliding1 = value;
                            });
                            },
                          groupValue: _sliding1,
                          children: const {
                            0:Text("Track"),
                            1:Text("Artist"),
                            2:Text("Albums")
                          },
                        ),
                      ),
                    ),     
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text('Time Period', style: TextStyle(fontFamily: 'Barlow', fontSize: 18, color: Couleurs.white, fontWeight: FontWeight.bold),)
                    ),                                                                                       
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: CupertinoSlidingSegmentedControl(
                          backgroundColor: Couleurs.primaryColor,
                          onValueChanged: (int? value) { 
                            setState(() {
                              _sliding2 = value;
                            });
                            },
                          groupValue: _sliding2,
                          children: const {
                            0:Text("OverAll"),
                            1:Text("7 days"),
                            2:Text("1 month")
                          },
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text('Dimensions', style: TextStyle(fontFamily: 'Barlow', fontSize: 18, color: Couleurs.white, fontWeight: FontWeight.bold),)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: CupertinoSlidingSegmentedControl(
                          backgroundColor: Couleurs.primaryColor,
                          onValueChanged: (int? value) { 
                            setState(() {
                              _sliding3 = value;
                            });
                            },
                          groupValue: _sliding3,
                          children: const {
                            0:Text("3x3"),
                            1:Text("4x4"),
                            2:Text("5x5")
                          },
                        ),
                      ),
                    ),                                    
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Center(
              child: _loading ? const LoadingCollage(width: 75) : ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),
                onPressed: () async{
                  setState(() => _loading = !_loading);
                  var tipo = getTipo(_sliding1);                
                  var time = getTime(_sliding2);              
                  var size = getSize(_sliding3);                
                    await ApiCollage.gerarCollage(tipo, time, size).then((value) {
                    setState(() => _loading = !_loading);
                    value.isNotEmpty ? _openDialogSuccess(context, value) : _openDialogError(context);
                  });             
                }, 
                child: const  Text('Generate', style: TextStyle(fontFamily: "Barlow", color: Couleurs.white)),
              ),
            ), 
          ],
        ),
      ),
    );
  }

  void _openDialogSuccess(BuildContext context, String filename){
    showGeneralDialog(    
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
                  const Done(),
                  const Text('Successfully generated collage!', style: TextStyle(fontFamily: "Barlow", color: Couleurs.white)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),onPressed: () { Navigator.pop(context); File(filename).delete(recursive: true);}, child: const Text("Close", style: TextStyle(fontFamily: "Barlow", color: Couleurs.white))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),onPressed: () { Navigator.pop(context); OpenFile.open(filename);}, child: const Text("Open", style: TextStyle(fontFamily: "Barlow", color: Couleurs.white))),
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

  void _openDialogError(BuildContext context){
    showGeneralDialog(    
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
                  const Icon(Icons.error, color: Couleurs.primaryColor, size: 50),
                  const Text('Erro ao gerar a collage', style: TextStyle(fontFamily: "Barlow", color: Couleurs.white)),
                  const Text('Tente novamente', style: TextStyle(fontFamily: "Barlow", color: Couleurs.white)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),onPressed: () { Navigator.pop(context);}, child: const Text("Close", style: TextStyle(fontFamily: "Barlow"))),
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
  
  String getTipo(int? sliding1) {
    if(sliding1 == 0) return 'track';
    if(sliding1 == 1) return 'artist';
    return 'album';
  }
  
  String getTime(int? sliding2) {
    if(sliding2 == 0) return 'OverAll';
    if(sliding2 == 1) return '7day';
    return '1month';
  }
  
  int getSize(int? sliding3) {
    if(sliding3 == 0) return 3;
    if(sliding3 == 0) return 4;
    return 5;
  }

}