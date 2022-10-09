import 'package:flutter/material.dart';
import 'package:ytel_app/Universe/widgets/app_drawer.dart';

class UnderProgress extends StatelessWidget {
  const UnderProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      //hellow world
      appBar: AppBar(
        title: Text('Work Under Progress'),
      ),
      body: Center(
        child: Text('Under Process'),
      ),
    );
  }
}
