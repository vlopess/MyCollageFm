import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_collage_fm/models/user.dart';
import 'package:my_collage_fm/pages/home/components/lovedtrackcomponent.dart';
import 'package:my_collage_fm/pages/home/components/topalbumscomponent.dart';
import 'package:my_collage_fm/pages/home/components/topartistscomponent.dart';
import 'package:my_collage_fm/pages/home/components/toptrackcomponent.dart';
import 'package:my_collage_fm/service/apiService.dart';
import 'package:my_collage_fm/service/prefs_service.dart';
import 'package:my_collage_fm/utils/couleurs.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  User user;
  Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {  
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {    
    //double? height = MediaQuery.of(context).size.height;
    double coverHeight = 100;
    double profileHeight = 144;
    double top = coverHeight - profileHeight / 2.5;
    return Scaffold(
      backgroundColor: Couleurs.grey200,
      appBar: currentPageIndex == 1 ? AppBar(backgroundColor: Couleurs.primaryColor, title: const Center(child:  Text("Collage Geranator", style: TextStyle(fontFamily: "Barlow"),)),automaticallyImplyLeading: false,):null,
        body: RefreshIndicator(
          backgroundColor: Couleurs.grey200,
          color: Couleurs.primaryColor,
          onRefresh: () async{
            widget.user = await ApiService.getAllInfoUser(widget.user.name!);
            setState(() {});
          },
          child: SafeArea(
            child: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: [
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
                            top: top * 1.4,
                            right:profileHeight * 1.45,
                            child: Column(
                                children: [
                                  Text(widget.user.name!, style: const TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),                        
                                  //Text(widget.user.playcount!, style: const TextStyle(fontFamily: "Barlow")),
                                ],
                            ),
                          ),                                                                                              
                        ],        
                      ),
                      SizedBox(height: top),
                      ///Visibility(visible: widget.user.recentTrack.playnow != null,child: buildCardTrack(track: widget.user.recentTrack)),
                      //buildCardTrack(track: widget.user.recentTrack),
                      Visibility(visible: widget.user.lovedtracks.track!.isNotEmpty,child: lovedTrackComponent(tracks: widget.user.lovedtracks.track!)),
                      toptrackcomponent(tracks: widget.user.toptrack),
                      topartistscomponent(artists: widget.user.topartists!, title: 'Top Artists'),
                      topalbumscomponent(albuns: widget.user.topalbums!, title: 'Top Albums'),  
                    ],
                  ),
                ),
          
                ///Collage Page
                const Center(child: Text("Collage Page Content"),)
            ][currentPageIndex],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          selectedIndex: currentPageIndex,
          onItemSelected: (index) {
            SharedPreference.remove();
            setState(() => currentPageIndex = index);
          },
          backgroundColor: Couleurs.grey100,
          items:  [
            BottomNavyBarItem(icon: const Icon(Icons.person_2_outlined), title: const Text('Profile', style: TextStyle(fontFamily: "Barlow"),), activeColor: Couleurs.primaryColor),
            BottomNavyBarItem(icon: const Icon(Icons.filter), title: const Text('Collage', style: TextStyle(fontFamily: "Barlow"),), activeColor: Couleurs.primaryColor),
          ],          
        ),
    );
  }
}