import 'package:flutter/material.dart';
import 'package:flutter_app/ThemeData/AppTheme.dart';
import 'package:flutter_app/bloc/ThemeChangeBloc.dart';
import 'package:flutter_app/bloc/ThemeChangeEvent.dart';
import 'package:flutter_app/bloc/ThemeChangeState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeChangeBloc()..add(GetThemeChangeEvent()),
        )
      ],
      child: BlocBuilder<ThemeChangeBloc, ThemeChangeState>(builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Theme',
          theme: (state is GetThemeState) ? appThemeData[state.theme] : appThemeData[AppTheme.BlueLight],
          home: MyHomePage(title: 'Theme Changer'),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeChangeBloc, ThemeChangeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showdialog(context);
          },
          tooltip: 'Theme Change',
          child: Icon(Icons.add),
        ),
      );
    });
  }

  showdialog(BuildContext context) {
    return showDialog(
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      builder: (context) {
        String _groupValue = 'red';
        return Center(
          child: Wrap(
            children: [
              AlertDialog(
                content: BlocBuilder<ThemeChangeBloc, ThemeChangeState>(
                  builder: (context, state) {
                    if (state is GetThemeState) {
                      print(state.theme);
                      _groupValue = state.theme.toString();
                    }
                    /*GreenLight,
                    GreenDark,
                    BlueLight,
                    BlueDark,*/
                    return Column(
                      children: <Widget>[
                        RadioListTile(
                          value: 'AppTheme.GreenLight',
                          groupValue: _groupValue,
                          title: Text("Green Light"),
                          onChanged: (newValue) {
                            print(newValue);
                            BlocProvider.of<ThemeChangeBloc>(context).add(SetThemeChangeEvent('GreenLight'));
                            BlocProvider.of<ThemeChangeBloc>(context).add(GetThemeChangeEvent());
                          },
                          activeColor: Colors.green,
                          selected: false,
                        ),
                        RadioListTile(
                          value: 'AppTheme.GreenDark',
                          groupValue: _groupValue,
                          title: Text("Green Dark"),
                          onChanged: (newValue) {
                            print(newValue);
                            BlocProvider.of<ThemeChangeBloc>(context).add(SetThemeChangeEvent('GreenDark'));
                            BlocProvider.of<ThemeChangeBloc>(context).add(GetThemeChangeEvent());
                          },
                          activeColor: Colors.green[700],
                          selected: false,
                        ),
                        RadioListTile(
                          value: 'AppTheme.BlueLight',
                          groupValue: _groupValue,
                          title: Text("Blue Light"),
                          onChanged: (newValue) {
                            BlocProvider.of<ThemeChangeBloc>(context).add(SetThemeChangeEvent('BlueLight'));
                            BlocProvider.of<ThemeChangeBloc>(context).add(GetThemeChangeEvent());
                          },
                          activeColor: Colors.blue,
                          selected: false,
                        ),
                        RadioListTile(
                          value: 'AppTheme.BlueDark',
                          groupValue: _groupValue,
                          title: Text("Blue Dark"),
                          onChanged: (newValue) {
                            BlocProvider.of<ThemeChangeBloc>(context).add(SetThemeChangeEvent('BlueDark'));
                            BlocProvider.of<ThemeChangeBloc>(context).add(GetThemeChangeEvent());
                          },
                          activeColor: Colors.blue[700],
                          selected: false,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future setPrefData(dateTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("data", "$dateTime");
  }

  Future<Stream> getPrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }
}
