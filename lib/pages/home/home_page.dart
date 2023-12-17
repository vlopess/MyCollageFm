import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_collage_fm/models/user.dart';
import 'package:my_collage_fm/utils/couleurs.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {  
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {    
    //double? height = MediaQuery.of(context).size.height;
    double coverHeight = 120;
    double profileHeight = 144;
    double top = coverHeight - profileHeight / 2.5;
    return Scaffold(
      backgroundColor: Couleurs.grey200,
      appBar: currentPageIndex == 1 ? AppBar(backgroundColor: Couleurs.primaryColor, title: const Center(child:  Text("Collage Geranator", style: TextStyle(fontFamily: "Barlow"),)),automaticallyImplyLeading: false,):null,
        body: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topLeft,
              children: [
                Container(
                  color: Couleurs.primaryColor,
                  height: coverHeight,
                  width: double.infinity,
                ),
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    color: Couleurs.primaryColor,
                    height: coverHeight + 20,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: top,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: profileHeight / 3,
                      backgroundColor: Couleurs.greyDark,
                      backgroundImage: NetworkImage(widget.user.image!),
                              
                    ),
                  ),
                ),
                Positioned(
                  top: top,
                  right:110,
                  child: Column(
                      children: [
                        Text(widget.user.name!, style: const TextStyle(fontFamily: "Barlow"),),
                        Text(widget.user.realname!, style: const TextStyle(fontFamily: "Barlow")),
                        Text(widget.user.playcount!, style: const TextStyle(fontFamily: "Barlow")),
                      ],
                  ),
                ),            
              ],        
            ),
            const Center(child: Text("Collage Page Content"),)
        ][currentPageIndex],
        bottomNavigationBar: BottomNavyBar(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          selectedIndex: currentPageIndex,
          onItemSelected: (index) => setState(() => currentPageIndex = index),
          backgroundColor: Couleurs.grey100,
          items:  [
            BottomNavyBarItem(icon: const Icon(Icons.person_2_outlined), title: const Text('Profile', style: TextStyle(fontFamily: "Barlow"),), activeColor: Couleurs.primaryColor),
            BottomNavyBarItem(icon: const Icon(Icons.filter), title: const Text('Collage', style: TextStyle(fontFamily: "Barlow"),), activeColor: Couleurs.primaryColor),
          ],          
        ),
    );
  }
}