//import material.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ytel_app/Context%20Center/screens/numbers_screen.dart';

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
            decoration: 
                BoxDecoration(color: Colors.blue),

            child: Column(
              
                children: [
                  CircleAvatar(
                    //Black Border
                    backgroundColor: Colors.grey,
                    //Border radius

                    radius: 40,
                    backgroundImage: NetworkImage(
                        "https://media.istockphoto.com/photos/portrait-of-smiling-caucasian-man-pose-in-office-picture-id1303206644?k=20&m=1303206644&s=612x612&w=0&h=B_CmLsEzLVKNb11awhk2S8HZkIoNpgBEe-dECLlYq0Y="),
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
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Inbox'),
            leading: Icon(Icons.inbox),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          //Expansion Tile for "Contacts" into  "Contacts","Contact import Status","Attributes" without leading icon
          ExpansionTile(
            title: Text('Contacts'),
            leading: Icon(Icons.contacts),
            children: [
              ListTile(
                title: Text('Contacts'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Contact import Status'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Attributes'),
                onTap: () {
                  // Update the state of the app.
                  // ...
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
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Message templates'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Webhooks'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Enrollment'),
                onTap: () {
                  // Update the state of the app.
                  // ...
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
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Routes'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Timezone'),
                onTap: () {
                  // Update the state of the app.
                  // ...
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
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Manage'),
                onTap: () {
                  //Go to Numbers Screen
                  Get.to(NumberScreen());
                },
              ),
              ListTile(
                title: Text('Number Sets'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
          ListTile(
            title: Text('Reporting'),
            leading: Icon(Icons.analytics),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
                   //Expansion Tile for "Settings" into  "Billing","Accounts","Buissness Profiles", "Assests","Api Tokens","Callbacks","CNAM Management","Compilance","Audit" without leading icon
          ExpansionTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            children: [
              ListTile(
                title: Text('Billing'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Accounts'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Buissness Profiles'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Assests'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Api Tokens'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Callbacks'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('CNAM Management'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Compilance'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Audit'),
                onTap: () {
                  // Update the state of the app.
                  // ...
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
              // ...
            },
          ),
          //Phone symbol
          ListTile(
            title: Text('UCaaS'),
            leading: Icon(Icons.phone),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          //Logout button
          ListTile(
            title: Text('Add Feature'),
            leading: Icon(Icons.add),
            onTap: () {
              
              // Update the state of the app.
              // ...
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () {
              userdata.remove("token");
                Get.offAll(LoginPage());
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}