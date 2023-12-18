import 'package:flutter/material.dart';
import 'package:my_collage_fm/components/textField.dart';
import 'package:my_collage_fm/controllers/LoginController.dart';
import 'package:my_collage_fm/pages/home/home_page.dart';
import 'package:my_collage_fm/utils/couleurs.dart';
import 'package:my_collage_fm/widgets/Loading.dart';
import 'package:my_collage_fm/widgets/WaveClipperBottom.dart';
import 'package:my_collage_fm/widgets/WaveClipperTop.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool tapped = false;
  final _formKey = GlobalKey<FormState>();
  LoginController controller = LoginController();
  @override
  Widget build(BuildContext context) {    
    double? width = MediaQuery.of(context).size.width;
    double? height = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: Couleurs.grey200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [      
              Stack(
                children: [
                  ClipPath(
                    clipper: WaveClipperTop(),
                    child: Container(
                      color: Couleurs.primaryColor,
                      height: 100,
                      width: width,
                    ),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: ClipPath(
                      clipper: WaveClipperTop(),
                      child: Container(
                        color: Couleurs.primaryColor,
                        height: 120,
                        width: width,
                      ),
                    ),
                  ), 
                ],
              ),      
              SizedBox(
                height: height * 0.65,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 180,
                      child: Center(
                        child: Text(
                          "MyCollageFm",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Couleurs.primaryColor,
                            fontFamily: "Barlow"
                          ),
                        ),
                      ),              
                    ),
                    SizedBox(
                      width: width * 0.70,
                      child: Form(
                        key: _formKey,
                        child: textField(
                          title: 'Username',
                          controller: controller.crtUsername
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:tapped ? const Loading(width: 50) : 
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),
                        onPressed: () async {
                          
                          if(_formKey.currentState!.validate()){ 
                            setState(() {
                              tapped = !tapped;
                            });                           
                            await controller.getUser().then((user) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(user: user))));                            
                          }
                        }, 
                        child: const  Text('Let Me In!', style: TextStyle(fontFamily: "Barlow")
                        )
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [                
                  Opacity(
                    opacity: 0.5,
                    child: ClipPath(
                      clipper: WaveClipperBottom(),
                      child: Container(
                        color: Couleurs.primaryColor,
                        height: 180,
                        width: width,
                      ),
                    ),
                  ), 
                  ClipPath(
                    clipper: WaveClipperBottom(),
                    child: Container(
                      color: Couleurs.primaryColor,
                      height: 150,
                      width: width,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}