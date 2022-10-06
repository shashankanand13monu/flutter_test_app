import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ytel_app/Context%20Center/screens/dashboard_screen.dart';

import '../../Universe/widgets/dialog_box.dart';
import 'navigation_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username_controller = TextEditingController();

  final password_controller = TextEditingController();

  final userdata = GetStorage();
  //Loading Variable
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    //!All Functions Here:

    void login_user(String email, String password) async {
      setState(() {
        _loading = true;
      
      });
      Map<String, String> body = {
        'captcha': '',
        'grantType': "resource_owner_credentials",
        'password': password,
        'username': email,
        'refreshToken': "120",
      };

      try {
        //http.everything to resolve Get Conflict
        http.Response response = await http.post(
            Uri.parse('https://api.ytel.com/auth/v2/token/'),
            body: jsonEncode(body),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            });

        if (response.statusCode == 200) {
          setState(() {
            _loading = false;
          
          });
          //Display Dialog Box
          var data = jsonDecode(response.body.toString());
          showDialog(
              context: context,
              builder: (BuildContext context) => DialogBox(
                    text: data['message'] == null
                        ? "Login Success"
                        : data['message'],
                  ));

          if (data['message'] == null) {
            userdata.write('token', data['accessToken']);
            userdata.write('refreshToken', data['refreshToken']);

            userdata.write('isLogged', true);
            userdata.write('email', email);
            

                    Get.offAll(NavigationScreen());
                    //Show Dialog of Login Succes
                    showDialog(
              context: context,
              builder: (BuildContext context) => DialogBox(
                    text: "Login Success",
                  ));


          }
          print(data);
        } else {
          // print("Login Failed...");
          setState(() {
            _loading = false;
          
          });
          //Display Dialog Box
          showDialog(
              context: context,
              builder: (BuildContext context) => DialogBox(
                    text: "Login Failed",
                  ));
        }
      } catch (e) {
        Get.snackbar('Error', e.toString());
      }
    }

//--------------------------------------------------------------

//!All Widgets Here:
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: username_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                obscureText: true,
                controller: password_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            _loading==true? 
            //Loading Widget
            CircularProgressIndicator():
            Container(
              width: 140,
              height: 50,
              child: FloatingActionButton(
                onPressed: () {
                  String username = username_controller.text;
                  String password = password_controller.text;

                  login_user(username, password);

                  
                },
                child: Text(
                  'Login',
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