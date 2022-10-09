import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:ytel_app/Universe/widgets/neuporphic_tile.dart';

class NumberDetalis extends StatelessWidget {
  final dynamic apiList;
  final int ind;
  NumberDetalis({Key? key, required this.apiList, required this.ind})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(apiList['payload'][ind]['phoneNumber'].toString()),
      ),
      //Print index
      body: Center(
        child: Column(
          children: [


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

            //Display API Response in screen
            SizedBox(
              height: 20,
            
            ),
            NeuTile(title: 'Account Detalis', subtitle: '', color: Colors.blue,height: 40, width: MediaQuery.of(context).size.width * 0.85,
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
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
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
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //SeizedBox for spacing
                                SizedBox(
                                  height: 10,
                                ),
                                //Display API Response in scree with List View Builder
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 9,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      apiList['payload'][ind].keys
                                          .elementAt(index)
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      apiList['payload'][ind].values
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
}
