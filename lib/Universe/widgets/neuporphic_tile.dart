import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

//Return NeuTile Container

class NeuTile extends StatelessWidget {
  //Accepts 2 text parameter and color
  final String title;
  final String subtitle;
  final Color color;
  //Optional parameter
  final double height ;
  final double width ;
 

  const NeuTile({
    Key? key,
    required this.title,
    this.subtitle='',
    required this.color,
    this.height = 90,
    this.width = 100,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
        depth: 4,
        lightSource: LightSource.topLeft,
        color: color,
        intensity: 5.5,
        // surfaceIntensity: 0.1,
      ),
      child: Container(
        // margin: EdgeInsets.all(4),
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.black),
        //   borderRadius: BorderRadius.circular(13),
        // ),
        height: height,
        width: width,
        child: Center(
          child: Column(
            children: [
              // SeizedBox for spacing
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),

              // Text(
              //   subtitle,
              //   style: TextStyle(
              //     fontSize: 15,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


