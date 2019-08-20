import 'package:equatable/equatable.dart';

class Routes extends Equatable{
    final String route;
    final String type;
    final Map<String,dynamic> destinations;
    Routes({this.route,this.type,this.destinations}):super([route,type,destinations]);

    @override
    String toString() => 'Route { route:$this.route }';
}
