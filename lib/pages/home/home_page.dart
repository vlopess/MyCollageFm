import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_collage_fm/pages/home/collage_page.dart';
import 'package:my_collage_fm/pages/home/nostalgia_page.dart';
import 'package:my_collage_fm/pages/home/profile_page.dart';
import 'package:my_collage_fm/service/prefs_service.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
// ignore: must_be_immutable
class Home extends StatefulWidget {
  String userName;
  String userImage;
  final String userUrl;
  Home({super.key, required this.userName, required this.userImage, required this.userUrl});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {  
  int currentPageIndex = 0;  

  @override
  Widget build(BuildContext context) {    
    final List<PreferredSizeWidget> appbars = [
        AppBar(
          backgroundColor: Couleurs.secondary,
          centerTitle: true,
          primary: false,
          title: Text(widget.userName, style: const TextStyle(fontFamily: "Barlow",color: Colors.white),),
          automaticallyImplyLeading: false,
          actions: [IconButton(onPressed: () => showSheetExit(context), icon: const Icon(Icons.more_vert),color: Colors.white,)]
        ),
        AppBar(primary: false, backgroundColor: Couleurs.secondary, centerTitle: true,title:  const Text("Nostalgia", style: TextStyle(fontFamily: "Barlow",color: Colors.white),),automaticallyImplyLeading: false,),
        AppBar(primary: false, backgroundColor: Couleurs.secondary, centerTitle: true,title:  const Text("Collage Generator", style: TextStyle(fontFamily: "Barlow",color: Colors.white),),automaticallyImplyLeading: false,)
    ];

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Couleurs.grey200,
        appBar: appbars[currentPageIndex],
          body: <Widget>[    
              Profile(userName: widget.userName, userImage: widget.userImage, userUrl: widget.userUrl),
              const Nostalgia(),
              const Collage(),
          ][currentPageIndex],
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Couleurs.greyLight,
            selectedItemColor: Couleurs.primaryColor,
            backgroundColor: Couleurs.greyMedium,
            currentIndex: currentPageIndex,
            onTap: (index) => setState(() => currentPageIndex = index),
            items: const [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.music_note_list),label: 'Nostalgia'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.chart_bar_square_fill),label: 'Collage'),
            ],
          )
      ),
    );
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
            child: const Text("Sair da Conta", style: TextStyle(fontFamily: 'Barlow', color: Couleurs.white),
            ),
          ),
          ),
        );
      });
  }  
}