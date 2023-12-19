import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_collage_fm/components/ColumnCustom.dart';
import 'package:my_collage_fm/models/user.dart';
import 'package:my_collage_fm/pages/home/components/lovedtrackcomponent.dart';
import 'package:my_collage_fm/pages/home/components/topalbumscomponent.dart';
import 'package:my_collage_fm/pages/home/components/topartistscomponent.dart';
import 'package:my_collage_fm/pages/home/components/toptrackcomponent.dart';
import 'package:my_collage_fm/pages/login_page.dart';
import 'package:my_collage_fm/service/apiService.dart';
import 'package:my_collage_fm/service/prefs_service.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:my_collage_fm/widgets/Loading.dart';
import 'package:url_launcher/url_launcher.dart';

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
    double? width = MediaQuery.of(context).size.width;
    double coverHeight = 60;
    double profileHeight = 144;
    double top = coverHeight - profileHeight / 2.5;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Couleurs.grey200,
        appBar: currentPageIndex == 1 ? AppBar(backgroundColor: Couleurs.primaryColor, centerTitle: true,title:  const Text("Collage Geranator", style: TextStyle(fontFamily: "Barlow"),),automaticallyImplyLeading: false,):null,
          body: RefreshIndicator(
            backgroundColor: Couleurs.grey200,
            color: Couleurs.primaryColor,
            onRefresh: () async{
              widget.user = await ApiService.getAllInfoUser(widget.user.name!);
              setState(() {});
            },
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
                            child:  Row(     
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,   
                              children: [
                                SizedBox(width: width * 0.1),
                                Center(child: Text(widget.user.name!, style: const  TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),)),
                                IconButton(onPressed: () => showSheet(context), icon: const Icon(Icons.more_vert),color: Colors.white,)
                              ],
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
                            top: coverHeight,
                            left: coverHeight * 2,
                            child: Row(
                                children: [
                                  ColumnCustom(label: 'Scrobbles', title: widget.user.playcount!),
                                  ColumnCustom(label: 'Artists', title: widget.user.artistCount!),
                                  ColumnCustom(label: 'Loved Tracks', title: widget.user.lovedtracks.track!.length.toString()),
                                ],
                            ),
                          ),                                                                                              
                        ],        
                      ),
                      SizedBox(height: profileHeight/2),
                      ///Visibility(visible: widget.user.recentTrack.playnow != null,child: buildCardTrack(track: widget.user.recentTrack)),
                      //buildCardTrack(track: widget.user.recentTrack),
                      Visibility(
                        visible: widget.user.recentTrack.playnow != null,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                              onTap: () async{
                                var url = Uri.parse(widget.user.recentTrack.url!);
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                            child: Container(
                              height: 75,
                              decoration: BoxDecoration(color: Couleurs.grey100,borderRadius: BorderRadius.circular(15.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 4 /3,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      child:
                                      Image.network(
                                        verificarImagem(widget.user.recentTrack.image!), 
                                        fit: BoxFit.cover,
                                      ), 
                                    ),
                                  ),
                                  ColumnCustom(label: widget.user.recentTrack.name!,title: widget.user.recentTrack.artist!,),
                                  const Loading(width: 80),
                                ],
                              )
                            ),
                          ),
                        ),
                      ),
                      Visibility(visible: widget.user.lovedtracks.track!.isNotEmpty,child: lovedTrackComponent(tracks: widget.user.lovedtracks.track!)),
                      toptrackcomponent(tracks: widget.user.toptracks),
                      topartistscomponent(artists: widget.user.topartists!, title: 'Top Artists'),
                      topalbumscomponent(albuns: widget.user.topalbums!, title: 'Top Albums'),  
                    ],
                  ),
                ),
            
                ///Collage Page
                const Center(child: Text("Collage Page Content"),)
            ][currentPageIndex],
          ),
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
      ),
    );
  }


  Future<dynamic> showSheet(BuildContext context) {
    return showModalBottomSheet(
                                  context: context, 
                                  backgroundColor: Couleurs.grey200,
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                                  builder: (context) {
                                   return SizedBox(
                                    height: 100,
                                    child: Center(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),
                                    onPressed: () {
                                        SharedPreference.remove();
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login(),));
                                    },
                                    child: const Text("Sair da Conta", style: TextStyle(fontFamily: 'Barlow'),
                                    ),
                                   ),
                                  ),
                                 );
                                });
  }
}