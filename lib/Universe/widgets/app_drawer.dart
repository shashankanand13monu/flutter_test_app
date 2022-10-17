//import material.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ytel_app/Context%20Center/screens/navigation_controller.dart';
import 'package:ytel_app/Context%20Center/screens/Number%20Sets/number_sets_screen.dart';
import 'package:ytel_app/Context%20Center/screens/numbers_screen.dart';
import 'package:ytel_app/Context%20Center/screens/welcome.dart';
import 'package:ytel_app/Context%20Center/work_under_progress.dart';

import '../../Context Center/screens/login_screen.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);
  final userdata = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              children: [
                CircleAvatar(
                  //Black Border
                  backgroundColor: Colors.blueAccent,
                  //Border radius

                  radius: 30,
                  child: Image.asset('assets/images/dp_default.png'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  userdata.read('email'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            title: Text('Dashboard'),
            leading: Icon(Icons.dashboard),
            onTap: () {
              Get.offAll(() => NavigationScreen());
            },
          ),
          ListTile(
            title: Text('Inbox'),
            leading: Icon(Icons.inbox),
            onTap: () {
              // Update the state of the app.
              Get.to(UnderProgress());
              
            },
          ),
          //Expansion Tile for "Contacts" into  "Contacts","Contact import Status","Attributes" without leading icon
          ExpansionTile(
            title: Text('Contacts'),
            leading: Icon(Icons.contacts),
            children: [
              ListTile(
                title: Text('Contacts'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('Contact import Status'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('Attributes'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
            ],
          ),

          //Expansion Tile for "Workflow" into  "Workflows","Message templates","Webhooks","Enrollment" without leading icon
          ExpansionTile(
            title: Text('Workflow'),
            leading: Icon(Icons.workspaces_filled),
            children: [
              ListTile(
                title: Text('Workflows'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('Message templates'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('Webhooks'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('Enrollment'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
            ],
          ),

          //Expansion Tile for "tracking" into  "Tracking Numbers","Routes","Timezone"
          ExpansionTile(
            title: Text('Tracking'),
            leading: Icon(Icons.cable),
            children: [
              ListTile(
                title: Text('Tracking Numbers'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('Routes'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('Timezone'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
            ],
          ),

          //Expansion Tile for "Numbers" into  "Purchase","Manage","Number Sets"
          ExpansionTile(
            title: Text('Numbers'),
            leading: Icon(Icons.tag),
            children: [
              ListTile(
                title: Text('Purchase'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('Manage'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  //Go to Numbers Screen
                  Get.to(NumberScreen());
                },
              ),
              ListTile(
                title: Text('Number Sets'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(NumberSets());
                },
              ),
            ],
          ),
          ListTile(
            title: Text('Reporting'),
            leading: Icon(Icons.analytics),
            onTap: () {
              // Update the state of the app.
              Get.to(UnderProgress());
            },
          ),
          //Expansion Tile for "Settings" into  "Billing","Accounts","Buissness Profiles", "Assests","Api Tokens","Callbacks","CNAM Management","Compilance","Audit" without leading icon
          ExpansionTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            children: [
              ListTile(
                title: Text('Billing'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('Accounts'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('Buissness Profiles'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('Assests'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('Api Tokens'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('Callbacks'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('CNAM Management'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('Compilance'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
              ListTile(
                title: Text('Audit'),
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  // Update the state of the app.
                  Get.to(UnderProgress());
                },
              ),
            ],
          ),

          //Contact Center
          ListTile(
            title: Text('Contact Center'),
            leading: Icon(Icons.contact_support),
            onTap: () {
              // Update the state of the app.
              Get.to(UnderProgress());
            },
          ),
          //Phone symbol
          ListTile(
            title: Text('UCaaS'),
            leading: Icon(Icons.phone),
            onTap: () {
              // Update the state of the app.
              Get.to(UnderProgress());
            },
          ),
          //Logout button
          ListTile(
            title: Text('Add Feature'),
            leading: Icon(Icons.add),
            onTap: () {
              // Update the state of the app.
              Get.to(UnderProgress());
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () {
              userdata.remove("token");
              Get.offAll(Welcome());
              
            },
          ),
        ],
      ),
    );
  }
}
