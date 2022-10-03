//import material.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//import http
import 'package:http/http.dart' as http;

import '../../Universe/widgets/get_numbers_api.dart';
import 'login_screen.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({Key? key}) : super(key: key);

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  // List<GetNumbersAPI>? apiList;

  var apiList;
  final userdata = GetStorage();

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
            children:[Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  if (apiList != null) getNumbers(),
                ],
              ),
            ),
            Center(
              child: Text('Short Codes'),
            ),
            ], 
          )),
    );
  }

  // Widget to get Numbers from API
  Widget getNumbers() {
    return Expanded(
      child: ListView.builder(
          itemCount:
              apiList['payload'].length == null ? 0 : apiList['payload'].length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
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

                      Text(apiList['payload'][index]['phoneNumber']),
                  subtitle: Text('valid till: ' +
                      DateTime.fromMillisecondsSinceEpoch(
                              apiList['payload'][index]['renewalDate'])
                          .toString()
                          .split(' ')[0]),
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
}
