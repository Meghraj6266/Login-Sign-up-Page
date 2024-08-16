import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    // _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'aaa')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashWidget(),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(
      //         height: 100 ,
      //         width: 100,
      //         color: Colors.purple,
      //         child: Text('Splash Screen', style: TextStyle(
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold
      //         ),),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  SplashWidget(){
    return AnimatedSplashScreen(
      // splash: Icons.account_box_outlined,
      // curve: Curves.easeOut,
      // duration: 3000,
      // nextScreen: MyHomePage(title: 'nnn',),
      splashTransition: SplashTransition.sizeTransition,
      //   backgroundColor: Colors.black,

      splash: Text('Login & Sign-in Page', style: TextStyle(
        color: Colors.blue[300],
        fontSize: 40,
        fontWeight: FontWeight.bold,

      ),),
      nextScreen: MyHomePage(title: 'Registration Page',),
    );
  }
}
