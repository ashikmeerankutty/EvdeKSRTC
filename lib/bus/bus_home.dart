import 'package:findmybus/bus/search_result.dart';
import 'package:flutter/material.dart';

class BusHome extends StatefulWidget {
  
  @override
  _BusHomeState createState() => _BusHomeState();
}

class _BusHomeState extends State<BusHome> {

  final sourceController = new TextEditingController();
  final destinationController = new TextEditingController();

  void _searchBus()
  {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => ResultPage()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 48.0, right: 48.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "FIND MY BUS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24.0),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: TextField(
                      controller: sourceController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          hintText: "Source"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextField(
                      controller: destinationController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          hintText: "Destination"),
                    ),
                  ),
                  RaisedButton(
                    onPressed: _searchBus,
                    child: Text('FIND BUS'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
