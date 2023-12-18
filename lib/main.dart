import 'package:flutter/material.dart';
import 'package:my_collage_fm/models/user.dart';
import 'package:my_collage_fm/pages/home/home_page.dart';
import 'package:my_collage_fm/pages/login_page.dart';
import 'package:my_collage_fm/service/apiService.dart';
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
      String? userName;
      if(snapshot.connectionState == ConnectionState.waiting) return const Center(child: Text("Aguarde ..."),);
      if(snapshot.connectionState == ConnectionState.done){
        userName = snapshot.data;
        if (userName == null) {
          return const Login();
        }
      }      
      return FutureBuilder(
        future: getUser(userName!), 
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            var user = snapshot.data;
            return Home(user: user!);
          }
          return const Center(child: Text("Aguarde ..."));
        },
      );
    },
  );
}

  
  Future<String?> auth() async{
      var userName = await SharedPreference.getUsername();
      return userName;
  }
  
  Future<User> getUser(String userName) async {
    return await ApiService.getAllInfoUser(userName);
  }
}


