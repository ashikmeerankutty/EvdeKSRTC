import 'package:equatable/equatable.dart';
import 'package:findmybus/models/routes.dart';

abstract class SearchState extends Equatable{
  SearchState([List props = const[]]) : super(props);
}

class RoutesUninitialized extends SearchState {
  @override
  String toString() => 'Routes Uninitialized';
}

class RoutesLoaded extends SearchState {
  List<Routes> routes;
  RoutesLoaded({this.routes}) : super([routes]);
  @override
  String toString() => 'Routes Loaded';
}

class RoutesError extends SearchState {
  @override
  String toString() => 'Routes Error';
}