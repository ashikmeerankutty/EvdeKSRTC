import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bloc/bloc.dart';
import 'package:findmybus/data/data.dart';
import 'package:http/http.dart' as http;


class DataBloc extends Bloc<DataEvents,DataState>{
  @override
  DataState get initialState => DataUninitialized();

  @override
  Stream<DataState> mapEventToState(DataEvents event)  async*{
    if(event is Fetch){
      try{
        if(currentState is DataUninitialized)
        {
          final data = await _fetchData();
          yield DataFetched(searchData: data);
        }
        if (currentState is DataFetched) {
          final data = await _fetchData();
          yield DataFetched(searchData: data);
        }
      }
      catch(_){
        yield DataError();
      }
    }
  }
}

Future<List<dynamic>> _fetchData()async{
  final response = await http.get(DotEnv().env['LOCATION_URL']);
  if (response.statusCode == 200) {
    final rawData = json.decode(response.body);
    final data =  rawData[0]['locations'];
    return data;
  } else {
    throw Exception('error fetching posts');
  }
}