//import material.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ytel_app/Context%20Center/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);
  final userdata = GetStorage();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Profile Screen'),
            //Logout button
            ElevatedButton(
              onPressed: () {
                userdata.erase();
                Get.offAll(LoginPage());
                
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}