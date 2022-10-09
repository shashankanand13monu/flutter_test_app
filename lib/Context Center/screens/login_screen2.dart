import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ytel_app/Context%20Center/screens/navigation_controller.dart';
import 'package:http/http.dart' as http;

import '../../Universe/widgets/dialog_box.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({Key? key}) : super(key: key);

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  final username_controller = TextEditingController();

  final password_controller = TextEditingController();

  final userdata = GetStorage();
  //Loading Variable
  bool _loading = false;

  //!Functions Here:

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

          Get.offAll(() => NavigationScreen());
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xfff0f1f5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: RichText(
                        text: const TextSpan(
                            text: 'Ytel\n',
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                          TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                color: Colors.black87,
                              ))
                        ])),
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height * .42,
                    child: Image.asset('assets/images/bg.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: size.height * .35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.2),
                              spreadRadius: 2,
                              blurRadius: 20,
                              offset: const Offset(0, 0),
                            )
                          ]),
                      child: _loading == true
                          ? Center(
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator()))
                          : Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  top: 10,
                                  left: 20,
                                  child: Text(
                                    'Login Here',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 50,
                                    left: 20,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.mail_outline,
                                              color: Colors.grey,
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              width: 300,
                                              child: TextFormField(
                                                controller: username_controller,
                                                cursorColor: Colors.grey,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'example@gmail.com',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: size.width * .8,
                                          child: Divider(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )),
                                Positioned(
                                    top: 120,
                                    left: 20,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.lock,
                                              color: Colors.grey,
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              width: 300,
                                              child: TextFormField(
                                                obscureText: true,
                                                controller: password_controller,
                                                cursorColor: Colors.grey,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 20,
                                                  letterSpacing: 1.4,
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '...........',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: size.width * .8,
                                          child: Divider(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )),
                                Positioned(
                                    top: 180,
                                    left: 20,
                                    child: SizedBox(
                                      width: size.width * .8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Create Account',
                                            style: TextStyle(
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            'Forgot Details',
                                            style: TextStyle(
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Container(
                      
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 14, 161, 246),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          String username = username_controller.text;
                          String password = password_controller.text;
                          print("pressed");

                          login_user(username, password);
                        },
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
