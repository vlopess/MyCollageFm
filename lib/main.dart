import 'package:flutter/material.dart';
import 'package:my_collage_fm/models/user.dart';
import 'package:my_collage_fm/pages/home/home_page.dart';
import 'package:my_collage_fm/pages/login_page.dart';
import 'package:my_collage_fm/pages/splash_page.dart';
import 'package:my_collage_fm/service/prefs_service.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Couleurs.primaryColor)
        ),
      debugShowCheckedModeBanner: false,
      home: const Authenticate(),
      //const Authenticate(),
      routes: {
        '/login' : (_) => const Login(),
      },
    );
  }
}

class Authenticate extends StatelessWidget {
  const Authenticate({super.key});

@override
Widget build(BuildContext context) {
  return FutureBuilder(
    future: auth(), 
    builder: (context, snapshot) {
      User user;
      if(snapshot.connectionState == ConnectionState.waiting) return const SplashPage();
      if(snapshot.connectionState == ConnectionState.done){
        user = snapshot.data!;
        if (user.isNull()) {
          return const Login();
        }
        return Home(userName: user.name!,userImage: user.image!, userUrl: user.url!,);
      } 
      return const SplashPage();
    },
  );
}

  
  Future<User?> auth() async{
      var userName = await SharedPreference.getUsername();
      var userImage = await SharedPreference.getUserImage();
      var userUrl = await SharedPreference.getUserUrl();
      User user = User(image: userImage, name: userName, url: userUrl);
      return user;
  }  
}


