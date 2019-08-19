import 'package:flutter/material.dart';

class BusHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(243, 244, 245, 1),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top:40.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("FIND MY BUS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}