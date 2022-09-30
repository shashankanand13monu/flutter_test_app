import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:ytel_app/screens/login_screen.dart';

class DashBoard extends StatelessWidget {

  final userdata = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome ${userdata.read('email')}",
              style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold),
            ),
            Text(
              //Display API_Token first few words
              "API_Token: ${userdata.read('token').toString().substring(0, 15)} ...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                          width: 140,
                          height: 50,
                          child: FloatingActionButton(
                            onPressed: () {
                
                userdata.erase();
                Get.offAll(LoginPage());

                              
                            },
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                        ),
                ],
              ),
            ),
          );
        }
      }

  