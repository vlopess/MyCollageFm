import 'package:flutter/material.dart';
import 'package:my_collage_fm/utils/couleurs.dart';

class Erro extends StatefulWidget {
  const Erro({super.key});

  @override
  State<Erro> createState() => _ErrorState();
}

class _ErrorState extends State<Erro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Couleurs.grey100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: Text("Something went wrong", style: TextStyle(fontFamily: 'Barlow', fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white))),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Couleurs.primaryColor),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false),
              child: const Text("Try Again", style: TextStyle(fontFamily: 'Barlow'),
              ),
            ),
          ],
        ),
    );
  }
}