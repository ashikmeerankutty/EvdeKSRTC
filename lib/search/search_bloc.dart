import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bloc/bloc.dart';
import 'package:findmybus/models/routes.dart';
import 'package:findmybus/search/search_event.dart';
import 'package:findmybus/search/search_state.dart';
import 'package:http/http.dart' as http;

class SearchBloc extends Bloc<SearchEvent,SearchState> {
  @override
  SearchState get initialState => RoutesUninitialized();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async*{
    if(event is Fetch){
      try{
        if(currentState is RoutesUninitialized){
          final routes = await _fetchRoutes(event.source,event.destination);
          yield RoutesLoaded(routes:routes);
        }
        if(currentState is RoutesLoaded){
          final routes = await _fetchRoutes(event.source,event.destination);
          yield RoutesLoaded(routes:routes);
        }
      }catch(_){
        print(_);
        yield RoutesError();
      }
    }
  }
}

Future<List<Routes>>_fetchRoutes(String source,String destination) async {
  final response = await http.post('http://localhost:3000/route',body:{
    "source" : source,
	  "destination" : destination
  });
  if (response.statusCode == 200) {
    final rawData = json.decode(response.body) as List;
    return rawData.map((rawPost) {
      return Routes(
        route: rawPost['route'],
        type: rawPost['type'],
        destinations: rawPost['destinations'] as Map
      );
    }).toList();
  } else {
    throw Exception('error fetching posts');
  }
}
