// import 'package:flutter/material.dart';
// import 'package:my_collage_fm/pages/error.dart';
// import 'package:my_collage_fm/pages/home/home_page.dart';
// import 'package:my_collage_fm/pages/shininghome_page.dart';
// import 'package:my_collage_fm/service/apiService.dart';

// class HomeController extends StatelessWidget {
//   final String userName;
//   const HomeController({super.key, required this.userName});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: ApiService.findUserByUsername(userName).then((user) => ApiService.getAllInfoUser(user)), 
//       builder: (context, snapshot) {
//         if(snapshot.connectionState == ConnectionState.waiting){
//           return const ShiningHome();
//         }
//         if(snapshot.connectionState == ConnectionState.done){
//           if(snapshot.hasError) return const Erro();
//           var user = snapshot.data!; 
//           return Home(user: user);
//         }
//         return const ShiningHome();
//       },
//     );
//   }
// }