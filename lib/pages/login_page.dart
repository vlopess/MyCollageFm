import 'package:flutter/material.dart';
import 'package:my_collage_fm/components/textField.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:my_collage_fm/widgets/Loading.dart';
import 'package:my_collage_fm/widgets/WaveClipperBottom.dart';
import 'package:my_collage_fm/widgets/WaveClipperTop.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool onclick = true;
  @override
  Widget build(BuildContext context) {    
    double? width = MediaQuery.of(context).size.width;
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Couleurs.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [      
            Stack(
              children: [
                ClipPath(
                  clipper: WaveClipperTop(),
                  child: Container(
                    color: Couleurs.primaryColor,
                    height: 150,
                    width: width,
                  ),
                ),
                Opacity(
                  opacity: 0.5,
                  child: ClipPath(
                    clipper: WaveClipperTop(),
                    child: Container(
                      color: Couleurs.primaryColor,
                      height: 180,
                      width: width,
                    ),
                  ),
                ), 
              ],
            ),                 
            Center(
              child: SizedBox(
                width: width * 0.80,
                child: textField(
                  title: 'Username'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Visibility(
                visible: onclick,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),
                  onPressed: () {
                    setState(() {
                      onclick = !onclick;
                    });
                  }, 
                  child: const  Text('Let Me In!')),
              ),
            ),
            Visibility(
              visible: !onclick,
              child: const Padding(
                padding: EdgeInsets.all(25.0),
                child:  Loading(width: 50),
              ),
            ),
            Expanded(
              flex: 1,
              child: Stack(
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
            ),
          ],
        ),
      ),
    );
  }
}