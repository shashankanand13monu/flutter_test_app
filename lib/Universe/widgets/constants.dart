import 'package:flutter/material.dart';
import 'package:ytel_app/Context%20Center/screens/chat_home_screen.dart';
import 'package:ytel_app/Context%20Center/screens/chat_screen.dart';
import 'package:ytel_app/Context%20Center/screens/dashboard_screen.dart';
import 'package:ytel_app/Context%20Center/screens/login_screen.dart';
import 'package:ytel_app/Context%20Center/screens/profile_screen.dart';
import 'package:ytel_app/Context%20Center/screens/welcome.dart';
import 'package:ytel_app/Context%20Center/work_under_progress.dart';

import '../../Context Center/screens/numbers_screen.dart';
import '../chats/user_model.dart';

//declare User
User user = User(
  id: 0,
  name: 'Ytel',
  imageUrl: 'assets/images/fr_flag.png',
);
List<Widget> navScreenItems = [
  // Welcome(),
  UnderProgress(),
// DashBoard(),
// NumberScreen(),
// LoginPage(),
ChatHomeScreen(),
// ChatScreen(),
ProfileScreen(),

];