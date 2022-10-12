import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class EditPhoneNumber extends StatefulWidget {
  String phoneId;

  EditPhoneNumber({Key? key, required this.phoneId}) : super(key: key);

  @override
  State<EditPhoneNumber> createState() => _EditPhoneNumberState(phoneId);
}

class _EditPhoneNumberState extends State<EditPhoneNumber> {
  String phoneId;
  List<String> method1 = ['POST', 'GET'];
  List<String> method2 = ['POST', 'GET'];
  List<String> method3 = ['POST', 'GET'];
  List<String> method4 = ['POST', 'GET'];
  List<String> sms1 = ['POST', 'GET'];
  List<String> sms2 = ['POST', 'GET'];
  List<String> record_method = ['Yes', 'No'];

  int m1 = 0;
  int m2 = 0;
  int m3 = 0;
  int m4 = 0;
  int s1 = 0;
  int s2 = 0;
  int rec = 0;

  final TextEditingController voice_request_URL = TextEditingController();
  final TextEditingController voice_fallback_URL = TextEditingController();
  final TextEditingController hangup_callback_URL = TextEditingController();
  final TextEditingController heartbeat_URL = TextEditingController();
  final TextEditingController sms_request_URL = TextEditingController();
  final TextEditingController sms_fallback_URL = TextEditingController();
  final TextEditingController friendly_name = TextEditingController();

  final userdata = GetStorage();
  _EditPhoneNumberState(this.phoneId);
  @override
  Widget build(BuildContext context) {
    //Display 3 screen defaultTabController
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit  " + phoneId),
          bottom: TabBar(
            tabs: [
              Tab(text: "Inbound Voice"),
              Tab(text: "Inbound SMS"),
              Tab(text: "Webphone"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  //Text Form Field for "Friendly Name"
                  TextFormField(
                    controller: friendly_name,
                    decoration: InputDecoration(
                      labelText: "Friendly Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //Display a form with 4 textfield named "Voice request URL","Voice Fallback URL","Hangup callback URL","heartbeat URL" with a side drop down button which has "POST" and "GET" as options and default value as "POST" with DropdownButtonHideUnderline

                  TextFormField(
                    controller: voice_request_URL,
                    decoration: InputDecoration(
                      labelText: "Voice request URL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: m1,
                          items: method1.map((String value) {
                            return DropdownMenuItem(
                              value: method1.indexOf(value),
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              m1 = value as int;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  TextFormField(
                    controller: voice_fallback_URL,
                    decoration: InputDecoration(
                      labelText: "Voice Fallback URL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: m2,
                          items: method2.map((String value) {
                            return DropdownMenuItem(
                              value: method2.indexOf(value),
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              m2 = value as int;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: hangup_callback_URL,
                    decoration: InputDecoration(
                      labelText: "Hangup callback URL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: m3,
                          items: method3.map((String value) {
                            return DropdownMenuItem(
                              value: method3.indexOf(value),
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              m3 = value as int;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: heartbeat_URL,
                    decoration: InputDecoration(
                      labelText: "heartbeat URL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: m4,
                          items: method4.map((String value) {
                            return DropdownMenuItem(
                              value: method4.indexOf(value),
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              m4 = value as int;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //Display a button named "Save"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 90,
                        height: 38,
                        child: FloatingActionButton(
                          heroTag: "btn1",
                          onPressed: () {
                            //Go back using getx
                            Get.back();
                          },
                          child: Text(
                            'Cancel',
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
                      //Cancel button
                      Container(
                        width: 90,
                        height: 38,
                        child: FloatingActionButton(
                          heroTag: "btn2",
                          onPressed: () {
                            //Put API to edit fields
                            putApi(
                                voice_fallback_URL.text,
                                voice_request_URL.text,
                                hangup_callback_URL.text,
                                heartbeat_URL.text,
                                friendly_name.text);
                          },
                          child: Text(
                            'Save',
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
                ],
              ),
            )),

            //--------------------------------------------------------------------
            Center(
                child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  //Same thing as above with 2 fields  "SMS request URL" and "SMS fallback URL"
                  TextFormField(
                    controller: sms_request_URL,
                    decoration: InputDecoration(
                      labelText: "SMS request URL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: s1,
                          items: sms1.map((String value) {
                            return DropdownMenuItem(
                              value: sms1.indexOf(value),
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              s1 = value as int;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: sms_fallback_URL,
                    decoration: InputDecoration(
                      labelText: "SMS Fallback URL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: s2,
                          items: sms2.map((String value) {
                            return DropdownMenuItem(
                              value: sms2.indexOf(value),
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              s2 = value as int;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 90,
                        height: 38,
                        child: FloatingActionButton(
                          heroTag: "btn3",
                          onPressed: () {
                            //Go back using getx
                            Get.back();
                            // Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
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
                      //Cancel button
                      Container(
                        width: 90,
                        height: 38,
                        child: FloatingActionButton(
                          heroTag: "btn4",
                          onPressed: () {
                            putSMSApi(sms_fallback_URL.text,sms_request_URL.text);
                          },
                          child: Text(
                            'Save',
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
                ],
              ),
            )),
            //--------------------------------------------------------------------
            Center(
                child: Column(
              children: [
                //Dropdown button for Yes or No qith title "Enable Call Recording"
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Enable Call Recording",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: rec,
                          items: record_method.map((String value) {
                            return DropdownMenuItem(
                              value: record_method.indexOf(value),
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              rec = value as int;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 90,
                            height: 38,
                            child: FloatingActionButton(
                              heroTag: "btn5",
                              onPressed: () {
                                //Go back using getx
                                Get.back();
                                // Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
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
                          //Cancel button
                          Container(
                            width: 90,
                            height: 38,
                            child: FloatingActionButton(
                              heroTag: "btn6",
                              onPressed: () {
                                //Print All
                                print(voice_request_URL.text);
                                print(voice_fallback_URL.text);
                                print(hangup_callback_URL.text);
                                print(heartbeat_URL.text);
                              },
                              child: Text(
                                'Save',
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
                    ],
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Future<void> putApi(
    String voice_request_URL,String voice_fallback_URL,
    String hangup_callback_URL,String heartbeat_URL,
    String friendly_name,
  )
   async 
  {
    String url = "https://api.ytel.com/api/v4/number/$phoneId/";

    Map<String, String> body = {
      'voiceUrl': voice_request_URL,
      'voiceFallbackUrl': voice_fallback_URL,
      'hangupCallbackUrl': hangup_callback_URL,
      "hangupCallbackMethod": "POST",
      'heartbeatUrl': heartbeat_URL,
      "heartbeatMethod": "GET",
      "voiceFallbackMethod": "POST",
      "voiceMethod": "POST",
      'friendlyName': friendly_name,
    };

    try {
      http.Response response = await http.put(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('token')}',
        },
        body: jsonEncode(body),
      );

      var data = jsonDecode(response.body);

      /*
      {"status":false,"count":0,"page":0,"error":[{"code":"404","message":"Number not found","moreInfo":null}]}
     */

      if (response.statusCode == 200) {
        if (data['status'] == false) {
          throw Exception(data['error'][0]['message']);
        }
        //Show success message
        Get.snackbar(
          "Success",
          "Number updated successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("OK"))
              ],
            );
          });
    }
  }


Future<void> putSMSApi(String sms_fallback_URL, String sms_request_URL)
async {
     String url = "https://api.ytel.com/api/v4/shortcode/$phoneId/";

    Map<String, String> body = {
      "smsMethod": "GET",
      "smsUrl": sms_fallback_URL,
      "smsFallbackMethod": "POST",
      "smsFallbackUrl": sms_fallback_URL,
    };

    try {
      http.Response response = await http.put(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('token')}',
        },
        body: jsonEncode(body),
      );

      var data = jsonDecode(response.body);

      /*
      {"status":false,"count":0,"page":0,"error":[{"code":"404","message":"Number not found","moreInfo":null}]}
     */

      if (response.statusCode == 200) {
        if (data['status'] == false) {
          throw Exception(data['error'][0]['message']);
        }
        //Show success message
        Get.snackbar(
          "Success",
          "SMS updated successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("OK"))
              ],
            );
          });
    }
}

}


