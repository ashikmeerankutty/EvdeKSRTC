import 'package:findmybus/bus/bus_home.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'common.dart/splash_page.dart';
import 'data/data.dart';

class MainApp extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

Future main() async {
  await DotEnv().load('.env');
  BlocSupervisor.delegate = MainApp();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  DataBloc _dataBloc;
  @override
  void initState() {
    _dataBloc = DataBloc();
    _dataBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _dataBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DataBloc>(
        bloc: _dataBloc,
        child: MaterialApp(
            theme: ThemeData(primaryColor: Colors.white),
            home: BlocBuilder<DataEvents, DataState>(
              bloc: _dataBloc,
              builder: (BuildContext context, DataState state) {
                if (state is DataUninitialized) {
                  _dataBloc.dispatch(Fetch());
                  return SplashPage();
                }
                if (state is DataError){
                  return Center(
                    child: Text('Unable to get data'),
                  );
                }
                if( state is DataFetched){
                  return MaterialApp(
                      theme: ThemeData(primaryColor: Colors.white),
                      home: BusHome(searchData: state.searchData,),
                    );
                }
              },
            )));
  }
}
