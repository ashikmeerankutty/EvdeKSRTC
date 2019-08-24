import 'package:findmybus/models/routes.dart';
import 'package:findmybus/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultPage extends StatefulWidget {
  final String source;
  final String destination;
  final String type;
  ResultPage(this.source, this.destination,this.type);
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _searchBloc,
      builder: (BuildContext context, state) {
        if (state is RoutesUninitialized) {
          _searchBloc.dispatch(
              Fetch(source: widget.source, destination: widget.destination,type:widget.type));
          return SafeArea(
            child: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state is RoutesError) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
                title: Text('Routes'),
              ),
              body: Center(
                child: Text('Failed to fetch routes'),
              ),
            ),
          );
        }
        if (state is RoutesLoaded) {
          if (state.routes.isEmpty) {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: true,
                  title: Text('Routes'),
                ),
                body: Center(
                  child: Text('No routes found'),
                ),
              ),
            );
          } else
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  automaticallyImplyLeading: true,
                  title: Text('Routes'),
                ),
                body: Container(
                  child: ListView.builder(
                      itemCount: state.routes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RouteDetails(
                                        route: state.routes[index])));
                          },
                          child: busListItem(state.routes[index], widget.source,
                              widget.destination),
                        );
                      }),
                ),
              ),
            );
        }
      },
    );
  }
}

Widget busListItem(route, source, destination) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.1),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.directions_bus),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: (route.route.length>40)?Text(route.route.substring(0,40)):Text(route.route),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 3.0, top: 2.0, bottom: 2.0),
                    child: Text(
                      route.type.toUpperCase(),
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                    child: Text(
                        '${formatTime(route.destinations[source]["time"])} - ${formatTime(route.destinations[destination]["time"])}'),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                    child: Text(
                      '${formatTime(route.destinations[source]["time"])} from $source',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.chevron_right,
                  size: 40.0,
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}

class RouteDetails extends StatefulWidget {
  final Routes route;
  RouteDetails({this.route});
  @override
  _RouteDetailsState createState() => _RouteDetailsState();
}

class _RouteDetailsState extends State<RouteDetails> {
  List<dynamic> destinations;
  List<String> time;

  @override
  void initState() {
    super.initState();
    List<dynamic> dest = new List();
    List<String> tim = new List();
    widget.route.destinations.forEach((key, value) {
      dest.add(key);
      tim.add(formatTime(value["time"]));
    });
    setState(() {
      destinations = dest;
      time = tim;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            widget.route.route,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        body: Container(
          child: ListView.builder(
              itemCount: widget.route.destinations.length,
              itemBuilder: (BuildContext context, int index) {
                return detailTile(destinations, time, index);
              }),
        ),
      ),
    );
  }
}

Widget detailTile(destinations, time, index) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(destinations[index]), Text(time[index])],
      ),
    ),
  );
}


formatTime(String time)
  {
    RegExp exp = new RegExp(r"([0-9]+):([0-9]+):([0-9]+)");
    Iterable<RegExpMatch> matches = exp.allMatches(time);
    var match = matches.elementAt(0);
    int hour =  int.parse(match.group(1));
    if(hour>12)
      return "${hour-12}:${match.group(2)} PM";
    else
      return "$hour:${match.group(2)} AM";
  }