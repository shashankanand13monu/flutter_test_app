import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ytel_app/Context%20Center/screens/dashboard_screen.dart';
import 'package:ytel_app/Context%20Center/screens/login_screen2.dart';
import 'package:ytel_app/Context%20Center/screens/navigation_controller.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Color.fromARGB(255, 11, 209, 227),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: Center(
          child: Stack(
            children: [
              Positioned(
                bottom: 350,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 130,
                    ),
                    SizedBox(
                      height: 10,
                    
                    ),
                    const Text(
                      'Welcome to Ytel',
                      style: TextStyle(
                        fontSize: 39,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration:  TextDecoration.none,
                        fontFamily:  'OpenSans',
                      ),

                      

                    ),

                    
                  ],
                ),
              ),
              Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.offAll(() => NavigationScreen());
                      },
                      child: Container(
              width: 140,
              height: 50,
              child: FloatingActionButton(
                hoverColor: Color.fromARGB(255, 211, 216, 218),
                onPressed: () {
                  Get.offAll(() => LoginScreen2());
                
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 50, 123)),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Colors.white,
                elevation: 14,
              ),
            ),
                    ),
                  )),

                //Bottom Picture from images
                

            ],
          ),
        ),
      ),
    );
  }
}