import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_collage_fm/pages/home/collage_page.dart';
import 'package:my_collage_fm/pages/home/profile_page.dart';
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
enum SingingCharacter { lafayette, jefferson }

class _HomeState extends State<Home> {  
  int currentPageIndex = 0;  

  
  @override
  Widget build(BuildContext context) {    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Couleurs.grey200,
        appBar: currentPageIndex == 1 ? AppBar(backgroundColor: Couleurs.primaryColor, centerTitle: true,title:  const Text("Collage Generator", style: TextStyle(fontFamily: "Barlow"),),automaticallyImplyLeading: false,):null,
          body: RefreshIndicator(
            backgroundColor: Couleurs.grey200,
            color: Couleurs.primaryColor,
            onRefresh: () async {
                setState(() {});    
                //widget.user = await ApiService.findUserByUsername(widget.user.name!).then((user) => ApiService.getAllInfoUser(user)); 
            },
            child: <Widget>[    
                Profile(userName: widget.userName, userImage: widget.userImage, userUrl: widget.userUrl),
                const Collage(),
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
}