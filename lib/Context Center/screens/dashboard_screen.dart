// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// import 'package:get_storage/get_storage.dart';
// import 'package:get/get.dart';
// import 'package:ytel_app/Context%20Center/screens/chat_screen.dart';
// import 'package:ytel_app/Context%20Center/screens/login_screen.dart';
// import 'package:ytel_app/Context%20Center/screens/navigation_controller.dart';
// import 'package:ytel_app/Universe/widgets/app_drawer.dart';

// import '../../Universe/widgets/neuporphic_tile.dart';

// class DashBoard extends StatelessWidget {
//   final userdata = GetStorage();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Dashboard"),
//       ),
//       drawer: AppDrawer(),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.only(top: 20),
//           child: Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 //padding from left & top

//                 //NeuTile Container
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     NeuTile(
//                       title: "Agent",
//                       subtitle: "98",
//                       color: Colors.yellow,
//                     ),
//                     NeuTile(
//                       title: "Agent",
//                       subtitle: "98",
//                       color: Colors.blueAccent,
//                     ),
//                     NeuTile(
//                       title: "Agent",
//                       subtitle: "98",
//                       color: Colors.greenAccent,
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     NeuTile(
//                       title: "Agent",
//                       subtitle: "98",
//                       color: Colors.green,
//                     ),
//                     NeuTile(
//                       title: "Agent",
//                       subtitle: "98",
//                       color: Colors.redAccent,
//                     ),
//                     NeuTile(
//                       title: "Agent",
//                       subtitle: "98",
//                       color: Colors.purpleAccent,
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 //Neu Tile Container
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Neumorphic(
//                       style: NeumorphicStyle(
//                         shape: NeumorphicShape.concave,
//                         boxShape: NeumorphicBoxShape.roundRect(
//                             BorderRadius.circular(12)),
//                         depth: 4,
//                         lightSource: LightSource.topLeft,
//                         color: Colors.white,
//                         intensity: 5.5,
//                         // surfaceIntensity: 0.1,
//                       ),
//                       child: Container(
//                         // margin: EdgeInsets.all(4),
//                         // decoration: BoxDecoration(
//                         //   border: Border.all(color: Colors.black),
//                         //   borderRadius: BorderRadius.circular(13),
//                         // ),
//                         height: MediaQuery.of(context).size.height * 0.47,

//                         width: MediaQuery.of(context).size.width * 0.85,
//                         child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 //SeizedBox for spacing
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Dial Level:",
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       "3.091",
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(
//                                   color: Colors.black,
//                                   thickness: 0.2,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Dialable Leads:",
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       "9",
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(
//                                   color: Colors.black,
//                                   thickness: 0.2,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Dropped/Answered:",
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       "0/0",
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(
//                                   color: Colors.black,
//                                   thickness: 0.2,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Leads in Hopper:",
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       "9",
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(
//                                   color: Colors.black,
//                                   thickness: 0.2,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Filter:",
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       "Drop72Hour",
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(
//                                   color: Colors.black,
//                                   thickness: 0.2,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Calls Today:",
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       "0",
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(
//                                   color: Colors.black,
//                                   thickness: 0.2,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Statuses:",
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       "A,AA,AB,AFTHRS,B",
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(
//                                   color: Colors.black,
//                                   thickness: 0.2,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Dropped %:",
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       "0.0%",
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(
//                                   color: Colors.black,
//                                   thickness: 0.2,
//                                 ),

//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Order:",
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       "Down",
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// //?Logout Function

// /*
// Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               "Welcome ${userdata.read('email')}",
//               style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold),
//             ),
//             Text(
//               //Display API_Token first few words
//               "API_Token: ${userdata.read('token').toString().substring(0, 15)} ...",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//                           width: 140,
//                           height: 50,
//                           child: FloatingActionButton(
//                             onPressed: () {
                
//                 userdata.erase();
//                 Get.offAll(LoginPage());

                              
//                             },
//                             child: Text(
//                               'Logout',
//                               style: TextStyle(
//                                   fontSize: 23,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white),
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             backgroundColor: Colors.blue,
//                           ),
//                         ),
//                 ],
//               ),
//  */
  