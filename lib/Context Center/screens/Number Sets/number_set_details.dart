import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../Universe/widgets/neuporphic_tile.dart';
import '../login_screen2.dart';

class NumberSetEdit extends StatefulWidget {
  String numberSetID;

  NumberSetEdit({Key? key, required this.numberSetID}) : super(key: key);

  @override
  State<NumberSetEdit> createState() => _NumberSetEditState(numberSetID);
}

class _NumberSetEditState extends State<NumberSetEdit> {
  String numberSetID;
  var apiList;
  bool _isLoading = false;
  final userdata = GetStorage();

  _NumberSetEditState(this.numberSetID);

  @override
  void initState() {
    super.initState();
    getNumbersFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Number Set Details"),
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
                      child: _isLoading == true
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  Text('Loading..'),
                                ],
                              ),
                            )
                          : SingleChildScrollView(
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

          ],
        ),
      ),
    );
  }

  Future<void> getNumbersFromAPI() async {
    _isLoading = true;
    String url = 'https://api.ytel.com/api/v4/numberset/$numberSetID/';

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
