// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:my_collage_fm/utils/couleurs.dart';
// import 'package:shimmer/shimmer.dart';

// // ignore: must_be_immutable
// class ShiningHome extends StatefulWidget {
//   const ShiningHome({super.key});

//   @override
//   State<ShiningHome> createState() => _ShiningHomeState();
// }

// class _ShiningHomeState extends State<ShiningHome> {  
//   int currentPageIndex = 0;
//   @override
//   Widget build(BuildContext context) {    
//     double? width = MediaQuery.of(context).size.width;
//     double coverHeight = 60;
//     double profileHeight = 144;
//     double top = coverHeight - profileHeight / 2.5;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Couleurs.grey200,
//         appBar: currentPageIndex == 1 ? AppBar(backgroundColor: Couleurs.primaryColor, centerTitle: true,title:  const Text("Collage Generator", style: TextStyle(fontFamily: "Barlow"),),automaticallyImplyLeading: false,):null,
//           body: <Widget>[
//               SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Stack(
//                       clipBehavior: Clip.none,
//                       alignment: Alignment.topLeft,
//                       children: [
//                         Container(
//                           color: Couleurs.primaryColor,
//                           height: coverHeight,
//                           width: double.infinity,          
//                           child:  Row(     
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,   
//                             children: [
//                               SizedBox(width: width * 0.1),
//                               const Center(child: Text('', style: TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),)),
//                               IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert),color: Colors.white,)
//                             ],
//                           ),        
//                         ),
//                         Positioned(
//                           top: top,
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Shimmer.fromColors(
//                               baseColor: Colors.grey.shade900,
//                               highlightColor: Couleurs.grey200,
//                               period: const Duration(milliseconds: 2000),
//                               child: CircleAvatar(
//                                 radius: profileHeight / 3,
//                                 backgroundColor: Couleurs.grey200,                                      
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: coverHeight,
//                           left: coverHeight * 2,
//                           child: Row(
//                               children: [
//                                 Column(
//                                   children: [
//                                     const Padding(
//                                       padding:  EdgeInsets.only(left: 8.0, top: 5),
//                                       child:  Text('Scrobbles',overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.primaryColor)),
//                                     ),
//                                     Shimmer.fromColors(baseColor: Colors.grey.shade900, highlightColor: Couleurs.grey200, period: const Duration(milliseconds: 2000), child: Container(width: 54,height: 14, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Couleurs.backgroundColor))),
//                                   ],
//                                 ),                        
//                                 Column(
//                                   children: [
//                                     const Padding(
//                                       padding:  EdgeInsets.only(left: 8.0, top: 5),
//                                       child:  Text('Artists',overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.primaryColor)),
//                                     ),
//                                     Shimmer.fromColors(baseColor: Colors.grey.shade900, highlightColor: Couleurs.grey200, period: const Duration(milliseconds: 2000), child: Container(width: 44,height: 14, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Couleurs.backgroundColor))),
//                                   ],
//                                 ),                        
//                                 Column(
//                                   children: [
//                                     const Padding(
//                                       padding: EdgeInsets.only(left: 8.0, top: 5),
//                                       child: Text('Loved Tracks',overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: "Barlow", fontWeight: FontWeight.bold, fontSize: 17, color: Couleurs.primaryColor)),
//                                     ),
//                                     Shimmer.fromColors(baseColor: Colors.grey.shade900, highlightColor: Couleurs.grey200, period: const Duration(milliseconds: 2000), child: Container(width: 54,height: 14, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Couleurs.backgroundColor))),
//                                   ],
//                                 ),                                                        
//                               ],
//                           ),
//                         ),                                                                                              
//                       ],        
//                     ),
//                     SizedBox(height: profileHeight - 23),                    
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         children: [
//                           const Align(
//                             alignment: Alignment.topLeft,
//                             child: Text('Scrobbling now', style: TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),)),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 16),
//                             child: Shimmer.fromColors(
//                               baseColor: Colors.grey.shade900, highlightColor: Couleurs.grey200, period: const Duration(milliseconds: 2000),
//                               child: Container(
//                                 height: 75,
//                                 decoration: BoxDecoration(color: Couleurs.grey100,borderRadius: BorderRadius.circular(15.0))
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10, right: 10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [        
//                           const Align(
//                             alignment: Alignment.topLeft,
//                             child: Row(
//                               children: [              
//                                 Text('Loved Tracks', style: TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),),
//                                 Icon(Icons.favorite, color: Colors.red,),
//                               ],
//                             )),
//                           SizedBox(
//                             height: 130,
//                             child: ListView.separated(
//                               padding: const EdgeInsets.all(16),
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) => Shimmer.fromColors(
//                                 baseColor: Colors.grey.shade900,
//                                 highlightColor: Couleurs.grey200,
//                                 period: const Duration(milliseconds: 2000),                                
//                                 child: Container(width: 100, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Couleurs.backgroundColor), ),
//                               ), 
//                               separatorBuilder: (context, index) => const SizedBox(width: 12), 
//                               itemCount: 4
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10, right: 10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [        
//                           const Align(
//                             alignment: Alignment.topLeft,
//                             child: Row(
//                               children: [              
//                                 Text('Top Tracks', style: TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),),
//                               ],
//                             )),
//                           SizedBox(
//                             height: 200,
//                             child: ListView.separated(
//                               padding: const EdgeInsets.all(16),
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) => Shimmer.fromColors(
//                                 baseColor: Colors.grey.shade900,
//                                 highlightColor: Couleurs.grey200,
//                                 period: const Duration(milliseconds: 2000),                                
//                                 child: Container(width: 160, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Couleurs.backgroundColor), ),
//                               ), 
//                               separatorBuilder: (context, index) => const SizedBox(width: 12), 
//                               itemCount: 4
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10, right: 10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [        
//                           const Align(
//                             alignment: Alignment.topLeft,
//                             child: Row(
//                               children: [              
//                                 Text('Top Artist', style: TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),),
//                               ],
//                             )),
//                           SizedBox(
//                             height: 200,
//                             child: ListView.separated(
//                               padding: const EdgeInsets.all(16),
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) => Shimmer.fromColors(
//                                 baseColor: Colors.grey.shade900,
//                                 highlightColor: Couleurs.grey200,
//                                 period: const Duration(milliseconds: 2000),                                
//                                 child: Container(width: 160, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Couleurs.backgroundColor), ),
//                               ), 
//                               separatorBuilder: (context, index) => const SizedBox(width: 12), 
//                               itemCount: 4
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10, right: 10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [        
//                           const Align(
//                             alignment: Alignment.topLeft,
//                             child: Row(
//                               children: [              
//                                 Text('Top Albums', style: TextStyle(fontFamily: 'Barlow', fontSize: 20, color: Couleurs.white, fontWeight: FontWeight.bold),),
//                               ],
//                             )),
//                           SizedBox(
//                             height: 200,
//                             child: ListView.separated(
//                               padding: const EdgeInsets.all(16),
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) => Shimmer.fromColors(
//                                 baseColor: Colors.grey.shade900,
//                                 highlightColor: Couleurs.grey200,
//                                 period: const Duration(milliseconds: 2000),                                
//                                 child: Container(width: 160, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Couleurs.backgroundColor), ),
//                               ), 
//                               separatorBuilder: (context, index) => const SizedBox(width: 12), 
//                               itemCount: 4
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
          
//               ///Collage Page
//               const Center(child: Text("Collage Page Content"),)
//           ][currentPageIndex],
//           bottomNavigationBar: BottomNavyBar(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             selectedIndex: currentPageIndex,
//             onItemSelected: (index) => setState(() => currentPageIndex = index),
//             backgroundColor: Couleurs.grey100,
//             items:  [
//               BottomNavyBarItem(icon: const Icon(Icons.person_2_outlined), title: const Text('Profile', style: TextStyle(fontFamily: "Barlow"),), activeColor: Couleurs.primaryColor),
//               BottomNavyBarItem(icon: const Icon(Icons.filter), title: const Text('Collage', style: TextStyle(fontFamily: "Barlow"),), activeColor: Couleurs.primaryColor),
//             ],          
//           ),
//       ),
//     );
//   }
// }