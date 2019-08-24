import 'package:findmybus/search/search.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class BusHome extends StatefulWidget {
  final List<dynamic> searchData;
  BusHome({this.searchData});
  @override
  _BusHomeState createState() => _BusHomeState();
}

class _BusHomeState extends State<BusHome> {
  final sourceController = new TextEditingController();
  final destinationController = new TextEditingController();
  String dropdownValue = 'All';
  List<String> dropdownItems = ["All","Ordinary","Limited Stop Ordinary","Town to Town Ordinary","Fast Passenger","Limited Stop Fast Passenger","Point to Point Fast Passenger","Super Fast","Super Express","Super Deluxe","Garuda King Class Volvo","Low Floor AC Volvo","Silver Line Jet","Low Floor Non AC","Ananthapuri Fast","Garuda Maharaja Scania"];

  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> destKey = new GlobalKey();

  List<String> destinations;
  String currentText = "";

  void _searchBus() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ResultPage(sourceController.text, destinationController.text,dropdownValue)));
  }

  @override
  void initState() {
    super.initState();
    List<String> data = widget.searchData.map((f) => f.toString()).toList();
    setState(() {
      destinations = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 48.0, right: 48.0),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'images/bus.png',
                      height: 120,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "EVIDE",
                              style: TextStyle(fontSize: 24.0),
                            ),
                            Text(
                              " KSRTC?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24.0),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SimpleAutoCompleteTextField(
                              key: key,
                              controller: sourceController,
                              suggestions: destinations,
                              submitOnSuggestionTap: true,
                              textChanged: (text) => {},
                              textSubmitted: (text) => {},
                              clearOnSubmit: false,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              textCapitalization: TextCapitalization.characters,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.gps_not_fixed,
                                  color: Colors.grey,
                                ),
                                hintText: "FROM",
                                hintStyle: TextStyle(letterSpacing: 2.0),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SimpleAutoCompleteTextField(
                              key: destKey,
                              controller: destinationController,
                              suggestions: destinations,
                              textChanged: (text) => {},
                              submitOnSuggestionTap: true,
                              textSubmitted: (text) => {},
                              clearOnSubmit: false,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              textCapitalization: TextCapitalization.characters,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.gps_fixed,
                                  color: Colors.grey,
                                ),
                                hintText: "TO",
                                hintStyle: TextStyle(letterSpacing: 2.0),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(0)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: InputDecorator(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.directions_bus,
                            color: Colors.grey,
                          ),
                          hintText: "TYPE",
                          hintStyle: TextStyle(letterSpacing: 2.0),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(0)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        isEmpty: dropdownValue == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: dropdownItems.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:30.0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: MaterialButton(
                          color: Color(0xffFA5D5D),
                          textColor: Colors.white,
                          onPressed: _searchBus,
                          child: Text('FIND BUS',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
