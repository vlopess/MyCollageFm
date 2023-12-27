import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_collage_fm/components/ColumnCustom.dart';
import 'package:my_collage_fm/models/track.dart';
import 'package:my_collage_fm/pages/home/components/lovedtrackcomponent.dart';
import 'package:my_collage_fm/pages/home/components/nothingfoundcomponent.dart';
import 'package:my_collage_fm/pages/home/components/scrobblescomponent.dart';
import 'package:my_collage_fm/pages/home/components/topalbumscomponent.dart';
import 'package:my_collage_fm/pages/home/components/topartistscomponent.dart';
import 'package:my_collage_fm/pages/home/components/toptrackcomponent.dart';
import 'package:my_collage_fm/pages/home/shining/shining.dart';
import 'package:my_collage_fm/pages/home/shining/shiningInfoUser.dart';
import 'package:my_collage_fm/pages/home/shining/shiningLovedTracks.dart';
import 'package:my_collage_fm/pages/home/shining/shiningScrobble.dart';
import 'package:my_collage_fm/service/apiService.dart';
import 'package:my_collage_fm/service/prefs_service.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  final String userName;
  final String userImage;
  final String userUrl;
  const Profile({super.key, required this.userName, required this.userImage, required this.userUrl});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String filter = 'OverAll';
  bool _select1 = false;
  bool _select2 = false;
  bool _select3 = true;
  @override
  Widget build(BuildContext context) {    
    double? width = MediaQuery.of(context).size.width;
    double coverHeight = 60;
    double profileHeight = 144;
    double top = coverHeight - profileHeight / 2.5;

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topLeft,
            children: [
              Container(
                color: Couleurs.grey100,
                height: coverHeight,
                width: double.infinity,          
                child:  Row(     
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,   
                  children: [
                    SizedBox(width: width * 0.1),
                    Center(child: Text(widget.userName, style: const  TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),)),
                    IconButton(onPressed: () => showSheetExit(context), icon: const Icon(Icons.more_vert),color: Colors.white,)
                  ],
                ),        
              ),
              Positioned(
                top: top,
                child: GestureDetector(
                  onTap: () async{
                    var url = Uri.parse(widget.userUrl);
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(                      
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CachedNetworkImage(
                          key: UniqueKey(),
                          imageUrl: verificarImagem(widget.userImage),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(color: Colors.black12,),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      //NetworkImage(widget.userImage),
                              
                    ),
                  ),
                ),
              ),
              Positioned(
                top: coverHeight,
                left: coverHeight * 3,
                child: FutureBuilder(
                  future: ApiService.findUserByUsername(widget.userName), 
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const ShiningInfoUser(); 
                    }
                    if(snapshot.connectionState == ConnectionState.done){
                      var user = snapshot.data!; 
                      return Row(
                          children: [
                            ColumnCustom(label: 'Scrobbles', title: user.playcount!),
                            ColumnCustom(label: 'Artists', title: user.artistCount!),
                          ],
                      ); 
                    }
                    return const ShiningInfoUser();
                  },
                ),
              ),                                                                                                                      
            ],        
          ),                      
          SizedBox(height: profileHeight / 2.5),    
          FutureBuilder(
            future: ApiService.getrecenttracksUser(), 
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const ShiningScrobble();
              }
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError) return Container();
                Track track = snapshot.data!; 

                return track.playnow == null? Container(): scrobbling(track: track);
              }
              return const ShiningScrobble();
            },
          ),
           
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Filter: $filter", style: const TextStyle(color: Couleurs.primaryColor, fontSize: 16)),
                IconButton(onPressed: () => showSheetFilter(context), icon: const Icon(Icons.list), color: Couleurs.primaryColor,),
              ],
            ),
          ),                
          FutureBuilder(
            future: ApiService.getlovedtracksUser(), 
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const ShiningLovedTracks();
              }
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError) return Container();
                var tracks = snapshot.data!; 
                return tracks.track!.isEmpty ? Container() :lovedTrackComponent(tracks: tracks.track!);
              }
              return const ShiningLovedTracks();
            },
          ),
          FutureBuilder(
            future: ApiService.gettoptracksUser(period: filter), 
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
              return const Shining(title: 'Top Tracks');
              }
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError) return nothingfoundcomponent(title: 'Top Tracks');
                var tracks = snapshot.data!; 
                return tracks.isEmpty ?  nothingfoundcomponent(title: 'Top Tracks') :toptrackcomponent(tracks: tracks);
              }
              return const Shining(title: 'Top Tracks');
            },
          ),
          FutureBuilder(
            future: ApiService.gettopartistsUser(period: filter), 
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Shining(title: 'Top Artists');
              }
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError) return nothingfoundcomponent(title: 'Top Artists');
                var artists = snapshot.data!; 
                return artists.isEmpty ? nothingfoundcomponent(title: 'Top Artists') : topartistscomponent(artists: artists);
              }
              return const Shining(title: 'Top Artists');
            },
          ),
          FutureBuilder(
            future: ApiService.gettopalbumsUser(period: filter), 
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Shining(title: 'Top Albums');
              }
              if(snapshot.connectionState == ConnectionState.done){
                var albuns = snapshot.data!; 
                return albuns.isEmpty ? nothingfoundcomponent(title: 'Top Albums') : topalbumscomponent(albuns: albuns);
              }
              return const Shining(title: 'Top Albums');
            },
          ),
        ],
      ),
    );
  }
  Future<dynamic> showSheetFilter(BuildContext context) {
    return showModalBottomSheet(
      context: context, 
      backgroundColor: Couleurs.grey200,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      builder: (context) {
      return SizedBox(
        height: 210,
        child: Column(
          children: [
            const Center(child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Filter', style: TextStyle(color: Couleurs.primaryColor,fontSize: 18),),
            )),
            GestureDetector(onTap: () async{
              Navigator.pop(context);
              setState(() {
                filter = '7day';
                enableAll();
                _select1 = true;
              });                  
            }, child: SizedBox(height: 50,child: Text("Last 7 days", style: TextStyle(fontSize: 18, color: _select1 ? Couleurs.primaryColor :Colors.white)),),),
            GestureDetector(onTap: () async{
              Navigator.pop(context);                            
              setState(() {
                filter = '1month';
                enableAll();
                _select2 = true;
              });    
            }, child: SizedBox(height: 50,child: Text("Last 30 days", style: TextStyle(fontSize: 18, color: _select2 ? Couleurs.primaryColor :Colors.white)),),),
            GestureDetector(onTap: () async{
              Navigator.pop(context);
              setState(() {
                filter = 'OverAll';
                enableAll();
                _select3 = true;
              });                  
            }, child: SizedBox(height: 50,child: Text("All Time", style: TextStyle(fontSize: 18, color: _select3 ? Couleurs.primaryColor :Colors.white)),),),
          ],
        ),
    );
    });
  }

  void enableAll() {
    _select1 = false;
    _select2 = false;
    _select3 = false;
  }

  Future<dynamic> showSheetExit(BuildContext context) {
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
                Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
            },
            child: const Text("Sair da Conta", style: TextStyle(fontFamily: 'Barlow'),
            ),
          ),
          ),
        );
      });
  }  
}