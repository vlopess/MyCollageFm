// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_collage_fm/components/snackBarCustom.dart';
import 'package:my_collage_fm/components/textField.dart';
import 'package:my_collage_fm/controllers/LoginController.dart';
import 'package:my_collage_fm/pages/home/home_page.dart';
import 'package:my_collage_fm/pages/tutorial_page.dart';
import 'package:my_collage_fm/service/user_service.dart';
import 'package:my_collage_fm/service/prefs_service.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:my_collage_fm/widgets/IconSong.dart';
import 'package:my_collage_fm/widgets/Loading.dart';
import 'package:my_collage_fm/widgets/WaveClipperBottom.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
    bool tapped = false;
  bool isLoading = false;
  bool showLogin = false;
  final _formKey = GlobalKey<FormState>();
  LoginController controller = LoginController();
  @override
  Widget build(BuildContext context) {    
    double? width = MediaQuery.of(context).size.width;
    double? height = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: Couleurs.grey200,
      body: SafeArea(
        child: ListView(       
          physics: const NeverScrollableScrollPhysics(),  
          children: [          
            Visibility(
              child: SizedBox(
                height: height * 0.2),
            ),
            SizedBox(
              height: height * 0.4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const IconSong(), 
                  Expanded(
                    flex: 2,
                    child: Visibility(
                      visible: !showLogin,
                      child: Hero(
                        tag: 'name_app',
                        child:  SizedBox(
                          height: height * 0.2,
                          width: width * 0.9,
                          child: const Center(
                            child: Column(
                              children: [
                                Text(
                                  "MyMusicTaste",
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Couleurs.white,
                                    fontFamily: "Barlow"
                                  ),
                                ),
                                Text(
                                  "Track your stats, save your memories, and generate collagens in one place!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(                                  
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Couleurs.primaryColor,
                                    fontFamily: "Barlow"
                                  ),
                                ),
                              ],
                            ),
                          ),              
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: showLogin,
                    child: Column(
                      children: [
                        SizedBox(
                          width: width * 0.70,
                          child: Form(
                            key: _formKey,
                            child: textField(
                              title: 'Enter with Username LastFm',
                              controller: controller.crtUsername,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child:tapped ? const Loading(width: 40) : 
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),
                            onPressed: () async {          
                              try {
                                await ref.read(userService).verifyUser(controller.crtUsername.text);                        
                              if(_formKey.currentState!.validate()){ 
                                setState(() {
                                  tapped = !tapped;
                                });       
                                try {
                                  await controller.findUser().then((user) async {
                                    await ref.read(userService).getCurrentUser(); 
                                    bool isFirstAccess = await SharedPreference.isFirstAccess();   
                                    if(isFirstAccess) await Navigator.push(context, MaterialPageRoute(builder: (context) => const TutorialPage()));

                                    SharedPreference.save(user);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home(userName: user.name!, userImage: user.image!,userUrl: user.url!,)));
                                  });                            
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(behavior: SnackBarBehavior.floating,elevation: 0, backgroundColor: Colors.transparent,content: SnackBarCustom(title: 'User not Found', cor: Couleurs.grey200)));                           
                                }  finally{
                                  setState(() {
                                    tapped = !tapped;
                                  }); 
                                }                  
                              }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(behavior: SnackBarBehavior.floating,elevation: 0, backgroundColor: Colors.transparent,content: SnackBarCustom(title: 'User Not Found', cor: Couleurs.grey200)));                           
                              }
                            }, 
                            child: const Text('Let Me In!', style: TextStyle(fontFamily: "Barlow", color: Couleurs.white)
                            )
                          ),
                        ),                      
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [                
                    Opacity(
                      opacity: 0.5,
                      child: ClipPath(
                        clipper: WaveClipperBottom(),
                        child: Container(
                          color: Couleurs.primaryColor,
                          height: 170,
                          width: width,
                        ),
                      ),
                    ), 
                    ClipPath(
                      clipper: WaveClipperBottom(),
                      child: Container(
                        color: Couleurs.primaryColor,
                        height: 140,
                        width: width,
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Couleurs.primaryColor,
                  height: height * 0.14,
                  child: Center(
                    child: SizedBox(
                      width: width * 0.6,
                      child: Visibility(
                        visible: !showLogin,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() => isLoading = !isLoading);
                            signInGoogle();
                          }, 
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,                      
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: isLoading ? const SizedBox(height: 15 , width: 15, child: CircularProgressIndicator(strokeWidth: 2, color: Couleurs.primaryColor,)) :
                                Image.asset("assets/png/google.png", height: 25),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Sign in with Google", style: TextStyle(fontFamily: "Lucida Sans", color: Couleurs.secondary, fontWeight: FontWeight.bold)),
                              )
                            ],
                          )
                        ),
                      ),
                    ),
                  ),
                )                
              ],
            ),
          ],
        ),
      ),
    );
  }  
  void signInGoogle() async {
    var user = await ref.read(userService).loginGoogle();
    SharedPreference.saveValue('email', user!.email!);
    SharedPreference.saveFirstAccess();
    setState(() => isLoading = !isLoading);   
    setState(() => showLogin = !showLogin);  
  }
}