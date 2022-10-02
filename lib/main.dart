import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ytel_app/screens/dashboard_screen.dart';
import 'package:ytel_app/screens/login_screen.dart';
import 'package:ytel_app/screens/navigation_controller.dart';



void main() async{
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ytel Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final userdate = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userdate.writeIfNull('isLogged', false);

    Future.delayed(Duration.zero,() async{
      checkiflogged();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child:  CircularProgressIndicator()
        ),
      ),

    );
  }

  void checkiflogged() {
    userdate.read('isLogged') ? Get.offAll(NavigationScreen()) : Get.offAll(LoginPage());
  }
  
}