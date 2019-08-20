import 'package:equatable/equatable.dart';

class DataEvents extends Equatable{}

class AppStarted extends DataEvents{
  @override
  String toString() => 'AppStarted';
}

class Fetch extends DataEvents{
  @override
  String toString() => 'Fetch';
}