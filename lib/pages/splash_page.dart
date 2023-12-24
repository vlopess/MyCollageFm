// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:my_collage_fm/widgets/WaveClipperBottom.dart';
import 'package:my_collage_fm/widgets/WaveClipperTop.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {    
    double? width = MediaQuery.of(context).size.width;
    double? height = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: Couleurs.grey200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [      
              Stack(
                children: [
                  ClipPath(
                    clipper: WaveClipperTop(),
                    child: Container(
                      color: Couleurs.primaryColor,
                      height: 100,
                      width: width,
                    ),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: ClipPath(
                      clipper: WaveClipperTop(),
                      child: Container(
                        color: Couleurs.primaryColor,
                        height: 120,
                        width: width,
                      ),
                    ),
                  ), 
                ],
              ),      
              SizedBox(
                height: height * 0.65,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.55,
                      child: const Center(
                        child: Text(
                          "MyCollageFm",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Couleurs.primaryColor,
                            fontFamily: "Barlow"
                          ),
                        ),
                      ),              
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [                
                  Opacity(
                    opacity: 0.5,
                    child: ClipPath(
                      clipper: WaveClipperBottom(),
                      child: Container(
                        color: Couleurs.primaryColor,
                        height: 180,
                        width: width,
                      ),
                    ),
                  ), 
                  ClipPath(
                    clipper: WaveClipperBottom(),
                    child: Container(
                      color: Couleurs.primaryColor,
                      height: 150,
                      width: width,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }  
}

