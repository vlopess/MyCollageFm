import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_collage_fm/pages/home/profile_page.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:my_collage_fm/widgets/Done.dart';
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
  int? _sliding1 = 0;
  int? _sliding2 = 0;
  int? _sliding3 = 0;
  bool _loading = false;
  
  @override
  Widget build(BuildContext context) {    
    double? height = MediaQuery.of(context).size.height;
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
                ///Collage Page////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                    SizedBox(height: height * 0.1),
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Text('Tipo de collage', style: TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.topCenter,
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
                      alignment: Alignment.topCenter,
                      child: Text('Tempo da collage', style: TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),)
                    ),                                                                                       
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.topCenter,
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
                      alignment: Alignment.topCenter,
                      child: Text('Tamanho da collage', style: TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.topCenter,
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
                    SizedBox(height: height * 0.05),
                    Center(
                      child: _loading ? const CircularProgressIndicator(color: Couleurs.primaryColor,) : ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),
                        onPressed: () async{
                          setState(() => _loading = !_loading);
                          await Future.delayed(const Duration(seconds: 1)).then((value) => _openDialog(context));                          
                          setState(() => _loading = !_loading);
                        }, 
                        child: const  Text('Gerar Collage', style: TextStyle(fontFamily: "Barlow")),
                      ),
                    ),
                  ],
                ),
              ),
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

  // FutureBuilder<User> onRefresh() {
  //   return FutureBuilder(
  //             future: ApiService.findUserByUsername(widget.user.name!).then((user) => ApiService.getAllInfoUser(user)), 
  //             builder: (context, snapshot) {
  //               if(snapshot.connectionState == ConnectionState.waiting){
  //                 return const ShiningHome();
  //               }
  //               if(snapshot.connectionState == ConnectionState.done){
  //                 if(snapshot.hasError) return const Center(child: Text("error"));
  //                 setState(() {
  //                   widget.user = snapshot.data!; 
  //                 });                     
  //               }
  //               return const ShiningHome();
  //             },
  //           );
  // }


 

  void _openDialog(BuildContext context){
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
                  const Text('Collage gerada com sucesso!', style: TextStyle(fontFamily: "Barlow")),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),onPressed: () => Navigator.pop(context), child: const Text("Download", style: TextStyle(fontFamily: "Barlow"))),
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
}