import 'package:equatable/equatable.dart';

class DataState extends Equatable{
    DataState([List props = const []]) : super(props);
}

class DataUninitialized extends DataState{
  @override
  String toString() => 'Data Uninitialized';
}

class DataFetched extends DataState{
  final List<dynamic> searchData;
  DataFetched({this.searchData}):super([searchData]);
  @override
  String toString() => 'Data Fetched';
}

class DataError extends DataState{
  @override
  String toString() => 'Data Error';
}