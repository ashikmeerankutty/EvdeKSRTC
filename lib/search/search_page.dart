import 'package:findmybus/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultPage extends StatefulWidget {
  final String source;
  final String destination;
  ResultPage(this.source, this.destination);
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
              Fetch(source: widget.source, destination: widget.destination));
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
                        return busListItem(state.routes[index], widget.source,
                            widget.destination);
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
                    child: Text(route.route),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0,top: 2.0,bottom: 2.0),
                    child: Text(route.type.toUpperCase(),style: TextStyle(color: Colors.grey.shade700),),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                    child: Text(
                        '${route.destinations[source]["time"]} - ${route.destinations[destination]["time"]}'),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                    child: Text('${route.destinations[source]["time"]} from $source',style: TextStyle(color: Colors.grey.shade700),),
                  ),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right:8.0),
                child: Icon(Icons.chevron_right,size: 40.0,),
              )
            ],
          )
        ],
      ),
    ),
  );
}
