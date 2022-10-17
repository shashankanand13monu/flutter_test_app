import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ytel_app/Context%20Center/screens/Number%20Sets/number_add_screen.dart';
import 'package:ytel_app/Context%20Center/screens/Number%20Sets/number_set_details.dart';
import 'package:ytel_app/Context%20Center/screens/Number%20Sets/number_set_edit.dart';

import '../login_screen2.dart';

class NumberSets extends StatefulWidget {
  const NumberSets({Key? key}) : super(key: key);

  @override
  State<NumberSets> createState() => _NumberSetsState();
}

class _NumberSetsState extends State<NumberSets> {
  @override
  void initState() {
    super.initState();
    getNumbersFromAPI();
  }

  final userdata = GetStorage();
  var apiList;
  List<String> number_setID = [];
  List<String> number_setName = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Sets'),
        //Add icon in end
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() =>  NumberSetAdd());
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body:  Center(
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

                    
                    //Table heading
                    if (apiList != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Name",
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
    );
  }

   Widget getNumbers() {
    return Expanded(
      child: ListView.builder(
          itemCount: number_setID.length,
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
                        //number_setName[index] substring 
                        number_setName[index].length>30?
                        Text(number_setName[index].substring(0,30)+'...',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            )) : Text(number_setName[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            )),

                        //Arrao icon to show the status of the number
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.to(EditPhoneSets(setID: number_setID[index]));
                              },
                              icon: Icon(Icons.edit,
                                  color: Colors.grey, size: 20),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.to(NumberSetEdit(numberSetID: number_setID[index]));
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

  Future<void> getNumbersFromAPI() async {
    String url = 'https://api.ytel.com/api/v4/numberset/';

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
    "count": 14,
    "page": 1,
    "payload": [
        {
            "accountSid": "7c8693c6-976e-4324-9123-2c1d811605f9",
            "numberSetId": "00af9900-f64f-11ec-bc49-33f053b167a5",
            "cnam": "",
            "name": "Katelyn Test for InRoute to send her to an audio file",
            "forwardNumber": "",
            "callerIdName": "",
            "voiceUrl": "",
            "voiceMethod": "POST",
            "voiceFallbackUrl": "",
            "voiceFallbackMethod": "POST",
            "hangupCallbackUrl": "",
            "hangupCallbackMethod": "POST",
            "smsUrl": "",
            "smsMethod": "POST",
            "smsFallbackUrl": "",
            "smsFallbackMethod": "POST",
            "heartbeatUrl": "",
            "heartbeatMethod": "POST",
            "routeTag": "12"
        },
        {
            "accountSid": "7c8693c6-976e-4324-9123-2c1d811605f9",
            "numberSetId": "75820051-d6ed-11ec-aeb3-7579f86eb32b",
            "cnam": "",
            "name": "Busted Campaign Registry Test",
            "forwardNumber": "",
            "callerIdName": "",
            "voiceUrl": "",
            "voiceMethod": "POST",
            "voiceFallbackUrl": "",
            "voiceFallbackMethod": "POST",
            "hangupCallbackUrl": "",
            "hangupCallbackMethod": "POST",
            "smsUrl": "",
            "smsMethod": "POST",
            "smsFallbackUrl": "",
            "smsFallbackMethod": "POST",
            "heartbeatUrl": "",
            "heartbeatMethod": "POST",
            "rateConfig": {
                "att": "{\"max\":0,\"tph\":0}",
                "global": "{\"max\":0,\"tph\":0}",
                "tmobile": "{\"max\":0,\"tph\":0,\"brand\":\"BBBBBBB\"}",
                "verizon": "{\"max\":0,\"tph\":0}"
            },
            "routeTag": "Inbound ",
            "campaignRegistry": "CCCCCCC"
        },
        {
            "accountSid": "7c8693c6-976e-4324-9123-2c1d811605f9",
            "numberSetId": "3ed15ee0-baad-11ec-836b-dbb1be43a06d",
            "cnam": "",
            "name": "Test for Nick 04122022",
            "forwardNumber": "",
            "callerIdName": "",
            "voiceUrl": "",
            "voiceMethod": "POST",
            "voiceFallbackUrl": "",
            "voiceFallbackMethod": "POST",
            "hangupCallbackUrl": "",
            "hangupCallbackMethod": "POST",
            "smsUrl": "",
            "smsMethod": "POST",
            "smsFallbackUrl": "",
            "smsFallbackMethod": "POST",
            "heartbeatUrl": "",
            "heartbeatMethod": "POST",
            "keywordActions": {
                "KATELYN": {
                    "campaignId": "d1952cf0-c960-11eb-9e7b-eb55ed342d07"
                }
            },
            "rateConfig": {
                "att": "{\"max\":1.0,\"tph\":2.0}",
                "verizon": "{\"max\":1,\"tph\":2}"
            },
            "campaignRegistry": "TEST"
        }
    ]
    
        
      */
        var data = json.decode(result.body);
        // print(data);

        if (data['status'] == false) {
          throw Exception(data['error'][0]['message']);
        }

        setState(() {
          apiList = data;

          for (Map i in apiList['payload']) {
            number_setID.add(i['numberSetId']);
            number_setName.add(i['name']);
          }
          // number_list = number_list2;
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
}
