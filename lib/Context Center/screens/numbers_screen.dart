//import material.dart
import 'dart:convert';
import 'dart:async';
// import 'dart:html';
// import 'dart:html';
import 'dart:io';
import 'dart:math';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//import http
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ytel_app/Context%20Center/screens/dashboard_screen.dart';
import 'package:ytel_app/main.dart';

import '../../Universe/widgets/app_drawer.dart';
import '../../Universe/widgets/get_numbers_api.dart';
import '../../Universe/widgets/search_widget.dart';
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
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
            ],
            leading: IconButton(
              onPressed: () {
                Get.to(() => DashBoard());
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
                    //two Icons titled "Add" and "Refresh"
                    if (apiList != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              PermissionStatus status =
                                  await Permission.storage.request();

                              if (status == PermissionStatus.granted) {
                                downloadAPIinCSV();
                                print("Granted");
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.download),
                                Text('Call Registry Export'),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              downloadAPIinCSV();
                            },
                            child: Row(
                              children: [
                                Icon(Icons.download),
                                Text('Export'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    //Search Field

                    // searchNum(),
                    // Expanded(
                    //   child: ListView.builder(
                    //       itemCount: number_list.length,
                    //       itemBuilder: (context, index) {
                    //         final numb = number_list[index];
                    //         return ListTile(
                    //           title: Text(number_list[index]),
                    //         );
                    //       }),
                    // ),
                    if (apiList != null) searchNum(),
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
            return Card(
              elevation: 1,
              shadowColor: Colors.black,
              color: Color.fromARGB(255, 91, 172, 231),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: GestureDetector(
                onTap: () {
                  print(index);
                },
                child: ListTile(
                  title: //text from Payload list

                      Text(number_list[index]),
                  trailing: //Info and edit button
                      Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Details'),
                                  content: Text(
                                      'accountSid: ${apiList['payload'][index]['accountSid']} \n phoneSid: ${apiList['payload'][index]['phoneSid']} \n phoneNumber: ${apiList['payload'][index]['phoneNumber']} \n voiceUrl: ${apiList['payload'][index]['voiceUrl']} \n voiceMethod: ${apiList['payload'][index]['voiceMethod']} \n voiceFallbackUrl: ${apiList['payload'][index]['voiceFallbackUrl']} \n voiceFallbackMethod: ${apiList['payload'][index]['voiceFallbackMethod']} \n renewalDate: ${apiList['payload'][index]['renewalDate']} \n purchaseDate: ${apiList['payload'][index]['purchaseDate']} \n region: ${apiList['payload'][index]['region']} \n timezone: ${apiList['payload'][index]['timezone']} \n smsUrl: ${apiList['payload'][index]['smsUrl']} \n smsMethod: ${apiList['payload'][index]['smsMethod']} \n smsFallbackUrl: ${apiList['payload'][index]['smsFallbackUrl']} \n smsFallbackMethod: ${apiList['payload'][index]['smsFallbackMethod']} \n heartbeatUrl: ${apiList['payload'][index]['heartbeatUrl']} \n heartbeatMethod: ${apiList['payload'][index]['heartbeatMethod']} \n hangupCallbackUrl: ${apiList['payload'][index]['hangupCallbackUrl']} \n hangupCallbackMethod: ${apiList['payload'][index]['hangupCallbackMethod']}'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Close'),
                                    ),
                                  ],
                                );
                              });
                        },
                        color: Colors.white,
                        icon: Icon(Icons.info),
                      ),
                      IconButton(
                        onPressed: () {},
                        color: Colors.white,
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
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
                      Get.offAll(LoginPage());
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
    }).toList();

    setState(() {
      this.query = query;
      number_list = numbers;
      if (query == "") {
        number_list = number_list2;
      }
      // print("Numbers: ${this.number_list}");
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
    if (Platform.isAndroid) {
      dir = "/storage/emulated/0/Download";
    } else {
      dir = (await getApplicationDocumentsDirectory()).path;
    }
    // final String dir = (await getExternalStorageDirectory())!.path;
    print(dir);
    //Time in string

    final String path = '$dir/numbers$count.csv';
    setState(() {
      count++;
    });
    final File file = File(path);
    await file.writeAsString(csv);

    print("File Saved");

    // print(csv);
  }
}
