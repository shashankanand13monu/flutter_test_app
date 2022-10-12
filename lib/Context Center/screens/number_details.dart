import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ytel_app/Universe/widgets/neuporphic_tile.dart';
import 'package:http/http.dart' as http;

import 'login_screen2.dart';

class NumberDetalis extends StatefulWidget {
  final String phoneNo;
  NumberDetalis({Key? key, required this.phoneNo}) : super(key: key);

  @override
  State<NumberDetalis> createState() => _NumberDetalisState(phoneNo);
}

class _NumberDetalisState extends State<NumberDetalis> {
  var apiList;
  final userdata = GetStorage();
  bool _isLoading = false;
  String phoneNo;
  _NumberDetalisState(this.phoneNo);

  @override
  void initState() {
    super.initState();
    getNumbersFromAPI();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.phoneNo),
      ),
      //Print index
      body: Center(
        child: Column(
          children: [
            //Display API Response in screen
            SizedBox(
              height: 20,
            ),
            NeuTile(
              title: 'Account Detalis',
              subtitle: '',
              color: Colors.blue,
              height: 40,
              width: MediaQuery.of(context).size.width * 0.85,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    depth: 4,
                    lightSource: LightSource.topLeft,
                    color: Colors.white,
                    intensity: 5.5,
                    // surfaceIntensity: 0.1,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 4),
                    height: MediaQuery.of(context).size.height * 0.67,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _isLoading==true?   Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Text('Loading..'),
                          ],
                        ),
                      ): SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //SeizedBox for spacing
                            SizedBox(
                              height: 9,
                            ),
                            //Display API Response in scree with List View Builder
                            ListView.builder(
                              shrinkWrap: true,
                              
                              itemCount: apiList['payload'][0].length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        
                                        Text(
                                          apiList['payload'][0]
                                              .keys
                                              .elementAt(index)
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        apiList['payload'][0]
                                                    .values
                                                    .elementAt(index)
                                                    .toString()
                                                    .length >
                                                35
                                            ? Text(
                                                apiList['payload'][0]
                                                    .values
                                                    .elementAt(index)
                                                    .toString()
                                                    .substring(0, 35),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  // fontWeight: FontWeight.,
                                                ),
                                              )
                                            : Text(
                                                apiList['payload'][0]
                                                    .values
                                                    .elementAt(index)
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  // fontWeight: FontWeight.,
                                                ),
                                              ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.black,
                                      thickness: 0.2,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Text(apiList['payload'][0].keys.elementAt(4).toString()),
            // Text(apiList['payload'][0].values.elementAt(4).toString()),
          ],
        ),
      ),
    );
  }

  Future<void> getNumbersFromAPI() async {
    _isLoading = true;
    String url = 'https://api.ytel.com/api/v4/number/$phoneNo/';

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
          _isLoading = false;
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
