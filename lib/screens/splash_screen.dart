import 'package:advande_apkstatmangement/screens/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void>goingNext()async{
  await  Future.delayed(Duration(seconds: 5),(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NewsScreen()));
  });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goingNext();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 180,
              ),
              Container(
                height: 400,
                child: Positioned(
                  bottom: 5,
                  child: Lottie.asset(
                    'assets/news.json',
                    height: 400,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}