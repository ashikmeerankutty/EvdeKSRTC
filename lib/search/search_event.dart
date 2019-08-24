import 'package:equatable/equatable.dart';

class SearchEvent extends Equatable{
  SearchEvent([List props = const []]) : super(props);
}

class Fetch extends SearchEvent
{
  final String source;
  final String destination;
  final String type;
  Fetch({this.source,this.destination,this.type}):super([source,destination,type]);
  @override
  String toString() => 'Fetch';
}