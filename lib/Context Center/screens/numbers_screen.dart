import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ytel_app/Context%20Center/screens/dashboard_screen.dart';
import 'package:ytel_app/Context%20Center/screens/login_screen2.dart';

import 'package:ytel_app/Context%20Center/screens/navigation_controller.dart';
import 'package:ytel_app/Context%20Center/screens/number_details.dart';
import 'package:ytel_app/Context%20Center/screens/welcome.dart';
import 'package:ytel_app/main.dart';

import '../../Universe/widgets/app_drawer.dart';
import '../../Universe/widgets/get_numbers_api.dart';
import '../../Universe/widgets/search_widget.dart';
import 'edit_phoneNo_screen.dart';
import 'login_screen.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({Key? key}) : super(key: key);

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  // List<GetNumbersAPI>? apiList;

  var apiList;

  //Generate random number int
  int count = 10;
  bool search_pressed = false;
  List<String> number_list = [];
  List<String> number_list2 = [];
  String query = '';
  //Make a map of list of numbers

  final userdata = GetStorage();
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getNumbersFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Numbers'),
            //Search icon in the end of appbar
            actions: [
              IconButton(
                onPressed: () async {
                  PermissionStatus status = await Permission.storage.request();

                  if (status == PermissionStatus.granted) {
                    downloadAPIinCSV();
                    print("Granted");
                  }
                },
                icon: Icon(Icons.download),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    search_pressed = !search_pressed;
                  });
                },
                icon: Icon(Icons.search),
              ),
              //Download icon
            ],
            leading: IconButton(
              onPressed: () {
                Get.to(() => NavigationScreen());
              },
              icon: Icon(Icons.arrow_back),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Phone Numbers',
                ),
                Tab(
                  text: 'Short codes',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // if (apiList != null) getNumbers(),
                    //Show Loading icon and text "Loading.."while fetching data
                    if (apiList == null)
                      Center(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              Text('Loading..'),
                            ],
                          ),
                        ),
                      ),

                    if (apiList != null && search_pressed) searchNum(),
                    //Table heading
                    if (apiList != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Number",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            Text("Actions   ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    if (apiList != null) getNumbers(),
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    //title of the table: "Phone Numbers", "Status", "Action"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'AgentId',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Action',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    if (apiList != null) getNumShortCode(),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  // Widget to get Numbers from API
  Widget getNumbers() {
    return Expanded(
      child: ListView.builder(
          itemCount: number_list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // mapTheNumber();
            return Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(number_list[index],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                            )),

                        //Arrao icon to show the status of the number
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // NumberDetalis(apiList: apiList, index: index);

                                Get.to(EditPhoneNumber(
                                  phoneId: number_list[index],
                                ));

                                // print(index);
                              },
                              icon: Icon(Icons.edit,
                                  color: Colors.grey, size: 20),
                            ),
                            IconButton(
                              onPressed: () {
                                // NumberDetalis(apiList: apiList, index: index);

                                Get.to(NumberDetalis(
                                  phoneNo: number_list[index],
                                ));

                                // print(index);
                              },
                              icon: Icon(Icons.info,
                                  color: Colors.grey, size: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget getNumShortCode() {
    /* Display "AgentId", Status(Cupertino Switch) and "action" which has 3 functinalities "copy"," edit" and "Delete" from API*/
    // try and catch loading

    return Expanded(
      child: ListView.builder(
          itemCount:
              apiList['payload'].length == null ? 0 : apiList['payload'].length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              shadowColor: Colors.white,
              child: ListTile(
                leading: //text from Payload list

                    Text(apiList['payload'][index]['phoneNumber']),
                subtitle: Switch(
                  value: true,
                  onChanged: (value) {
                    print(value);
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      iconSize: 15,
                      onPressed: () {},
                      icon: Icon(Icons.copy),
                    ),
                    IconButton(
                      iconSize: 15,
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      iconSize: 15,
                      onPressed: () {},
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  //API Call to get Numbers
  Future<void> getNumbersFromAPI() async {
    String url = 'https://api.ytel.com/api/v4/number/?offset=0';

    try {
      var result = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          });

      if (result.statusCode == 200) {
        print("OK");
        /* 
      Example Response
{
  "status": true,
  "count": 576,
  "page": 1,
  "payload": [
    {
      "accountSid": "173c6f7f-c911-f823-fb2d-a13e4780c300",
      "phoneSid": "25431e50-6866-11ea-9ea9-d1464f98b813",
      "phoneNumber": "+15552283797",
      "voiceUrl": "https://testdomain.com",
      "voiceMethod": "GET",
      "voiceFallbackUrl": "",
      "voiceFallbackMethod": "POST",
      "renewalDate": 1611101028432,
      "purchaseDate": 1584459850921,
      "region": "US-NJ",
      "timezone": -20,
      "smsUrl": "",
      "smsMethod": "POST",
      "smsFallbackUrl": "",
      "smsFallbackMethod": "POST",
      "heartbeatUrl": "",
      "heartbeatMethod": "POST",
      "hangupCallbackUrl": "",
      "hangupCallbackMethod": "POST",
      "attributes": [
        "voice-enabled"
      ],
      "numberType": 1
    },
    {
      "accountSid": "173c6f7f-c911-f823-fb2d-a13e4780c300",
      "phoneSid": "8567a510-6886-11ea-9b6f-e6478104197e",
      "phoneNumber": "+15552283811",
      "voiceUrl": "https://testdomain.com",
      "voiceMethod": "GET",
      "voiceFallbackUrl": "",
      "voiceFallbackMethod": "POST",
      "renewalDate": 1611360251655,
      "purchaseDate": 1584473756124,
      "region": "US-NJ",
      "timezone": -20,
      "smsUrl": "",
      "smsMethod": "POST",
      "smsFallbackUrl": "",
      "smsFallbackMethod": "POST",
      "heartbeatUrl": "",
      "heartbeatMethod": "POST",
      "hangupCallbackUrl": "",
      "hangupCallbackMethod": "POST",
      "attributes": [
        "voice-enabled"
      ],
      "numberType": 1
    }
  ]
}
      */
        var data = json.decode(result.body);

        // print(data);

        if (data['status'] == false) {
          // print(data);

          /*{status: false, count: 0, page: 0, error: [{code: 401, message: Permission denied, moreInfo: null}]} */

          //Display Dialog Box of error message with "Logout" button

          //go to catch throw error
          throw Exception(data['error'][0]['message']);
        }

        setState(() {
          apiList = data;

          for (Map i in apiList['payload']) {
            number_list2.add(i['phoneNumber']);
          }
          number_list = number_list2;
        });
      }
    } catch (e) {
      //Display Dialog Box of error message with "Logout" button
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      userdata.erase();
                      Get.offAll(() => LoginScreen2());
                    },
                    child: Text('Login'))
              ],
            );
          });
    }
  }

  Widget searchNum() => SearchWidget(
        text: query,
        hintText: 'Search No.',
        onChanged: searchTheNumber,
      );

  void searchTheNumber(String query) {
    print(query);
    // final n= apiList[]

    final numbers = number_list2.where((numb) {
      final numLower = numb.toLowerCase();
      final queryLower = query.toLowerCase();

      return numLower.contains(queryLower);

      // return numLower.contains(apiList['payload'][0]['phoneNumber']);
    }).toList();

    setState(() {
      this.query = query;
      number_list = numbers;
      if (query == "") {
        number_list = number_list2;
      }
      // print("Numbers: ${this.number_list}");
      //Add Searched Number to new list of all api data
      // apiListofAllDataCopy['payload'].add(number_list);
      // print(apiListofAllDataCopy);
    });
  }

  Future<void> downloadAPIinCSV() async {
    /*
  
  "accountSid": "173c6f7f-c911-f823-fb2d-a13e4780c300",
      "phoneSid": "25431e50-6866-11ea-9ea9-d1464f98b813",
      "phoneNumber": "+15552283797",
      "voiceUrl": "https://testdomain.com",
      "voiceMethod": "GET",
      "voiceFallbackUrl": "",
      "voiceFallbackMethod": "POST",
      "renewalDate": 1611101028432,
      "purchaseDate": 1584459850921,
      "region": "US-NJ",
      "timezone": -20,
      "smsUrl": "",
      "smsMethod": "POST",
      "smsFallbackUrl": "",
      "smsFallbackMethod": "POST",
      "heartbeatUrl": "",
      "heartbeatMethod": "POST",
      "hangupCallbackUrl": "",
      "hangupCallbackMethod": "POST",

   */

    //convert in csv
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add("accountSid");
    row.add("phoneSid");
    row.add("phoneNumber");
    row.add("voiceUrl");
    row.add("voiceMethod");
    row.add("voiceFallbackUrl");
    row.add("voiceFallbackMethod");
    row.add("renewalDate");
    row.add("purchaseDate");
    row.add("region");
    row.add("timezone");
    row.add("smsUrl");
    row.add("smsMethod");
    row.add("smsFallbackUrl");
    row.add("smsFallbackMethod");
    row.add("heartbeatUrl");
    row.add("heartbeatMethod");
    row.add("hangupCallbackUrl");
    row.add("hangupCallbackMethod");
    rows.add(row);

    for (Map i in apiList['payload']) {
      row = [];
      row.add(i['accountSid']);
      row.add(i['phoneSid']);
      row.add(i['phoneNumber']);
      row.add(i['voiceUrl']);
      row.add(i['voiceMethod']);
      row.add(i['voiceFallbackUrl']);
      row.add(i['voiceFallbackMethod']);
      row.add(i['renewalDate']);
      row.add(i['purchaseDate']);
      row.add(i['region']);
      row.add(i['timezone']);
      row.add(i['smsUrl']);
      row.add(i['smsMethod']);
      row.add(i['smsFallbackUrl']);
      row.add(i['smsFallbackMethod']);
      row.add(i['heartbeatUrl']);
      row.add(i['heartbeatMethod']);
      row.add(i['hangupCallbackUrl']);
      row.add(i['hangupCallbackMethod']);
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);
    final String dir;
    //Now time in string
    var now = DateTime.now().toString();
    //remove '.;:' from string
    var now2 = now.replaceAll(RegExp(r'[.:]'), '');
    if (Platform.isAndroid) {
      dir = "/storage/emulated/0/Download";
    } else {
      dir = (await getApplicationDocumentsDirectory()).path;
    }
    // final String dir = (await getExternalStorageDirectory())!.path;
    print(dir);
    //Time in string

    final String path = '$dir/numbers$now2.csv';
    print(path);
    setState(() {
      count++;
    });
    final File file = File(path);
    await file.writeAsString(csv);

    print("File Saved");

    // print(csv);
  }
}
