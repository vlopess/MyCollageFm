import 'package:flutter/material.dart';
import 'package:my_collage_fm/pages/indicator.dart';
import 'package:my_collage_fm/utils/couleurs.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Couleurs.secondary,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              width: size.width * 0.85,
              height: size.height * 0.8,
              child: PageView(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                children: [
                  Scrollbar(
                    child: Column(
                      children: [
                        Center(
                          child: Flexible(
                            child: SizedBox(
                              height: size.height * 0.6,
                              child: Image.asset("assets/png/femme1.png")
                            ),
                          ),
                        ),
                        const Text("Welcome to MyMusicTaste!", overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.primaryColor)),
                        const Text("A place to track your stats, save your best feelings about music and make collages.", overflow: TextOverflow.visible, textAlign: TextAlign.center,style: TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.white))
                      ],
                    ),
                  ),  
                  Scrollbar(
                    child: Column(
                      children: [
                        Center(
                          child: Flexible(
                            child: SizedBox(
                              height: size.height * 0.6,
                              child: Image.asset("assets/png/femme2.png")
                            ),
                          ),
                        ),
                        const Text("Save your memories", overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.primaryColor)),
                        const Text("Easily save memories with your favorite music and photos", overflow: TextOverflow.visible, textAlign: TextAlign.center ,style: TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.white))
                      ],
                    ),
                  ),              
                  Scrollbar(
                    child: Column(
                      children: [
                        Center(
                          child: Flexible(
                            child: SizedBox(
                              height: size.height * 0.6,
                              child: Image.asset("assets/png/femme3.png")
                            ),
                          ),
                        ),
                        const Text("Generate collages", overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.primaryColor)),
                        const Text("Create collages of your most listened to songs, artists, and albums in one time track", overflow: TextOverflow.visible, textAlign: TextAlign.center ,style: TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.white))
                      ],
                    ),
                  ),                  
                  Scrollbar(
                    child: Column(
                      children: [
                        Center(
                          child: Flexible(
                            child: SizedBox(
                              height: size.height * 0.6,
                              child: Image.asset("assets/png/homme1.png")
                            ),
                          ),
                        ),
                        const Text("Enjoy exploring MyMusicTaste!", overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.primaryColor)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(                          
                            color: Couleurs.primaryColor,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),                          
                            child: MaterialButton(                              
                              splashColor: Colors.transparent,
                              minWidth: double.infinity,
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Let Me In", overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.white)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    4,
                    (index) => Indicador(
                        active:
                            selectedIndex == index ? true : false))
              ],
            )
          ],
        ),
      )
    );
  }
}