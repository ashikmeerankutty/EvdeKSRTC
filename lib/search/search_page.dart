import 'package:findmybus/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultPage extends StatefulWidget {
  final String source;
  final String destination;
  ResultPage(this.source,this.destination);
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
          _searchBloc.dispatch(Fetch(source: widget.source,destination: widget.destination));
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
                appBar: AppBar(
                  automaticallyImplyLeading: true,
                  title: Text('Routes'),
                ),
                body: Container(
                  child: ListView.builder(
                      itemCount: state.routes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(state.routes[index].route),
                          subtitle: Text(state.routes[index].destinations['KATTAPPANA (KTP)']),
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
