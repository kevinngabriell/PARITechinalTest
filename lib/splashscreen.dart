import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technicaltest/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Person.png', width: MediaQuery.of(context).size.width * 0.7,),
              const Text('Hi, Team Recruiter PT. PARI', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),),
              const SizedBox(height: 5,),
              const Text('Hello, my name is Kevin Gabriel Florentino, and here are the results of the technical test that I have completed. Thank you and enjoy.'),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  Get.to(const Home());
                }, 
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFFFFFFFF),
                  backgroundColor: const Color(0xff4ec3fc),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Proceed to Main Page')
              )
            ],
          ),
        ),
      ),
    );
  }
}