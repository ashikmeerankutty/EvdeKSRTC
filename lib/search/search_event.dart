import 'package:equatable/equatable.dart';

class SearchEvent extends Equatable{
  SearchEvent([List props = const []]) : super(props);
}

class Fetch extends SearchEvent
{
  final String source;
  final String destination;
  Fetch({this.source,this.destination}):super([source,destination]);
  @override
  String toString() => 'Fetch';
}