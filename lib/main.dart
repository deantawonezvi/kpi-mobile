import 'package:flutter/material.dart';
import 'package:production_entry/models/auth-model.dart';
import 'package:production_entry/pages/auth/login.dart';
import 'package:production_entry/pages/home.dart';
import 'package:production_entry/pages/tasks/successPage.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final AuthModel _auth = AuthModel();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthModel>.value(value: _auth),
      ],
      child: MaterialApp(
        title: 'Schweppes Production Entry',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.black
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.black,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.black
            )
        ),
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthModel>(builder: (context, model, child) {
          if (model?.user != null) return HomePage();
          return LoginPage();
        }),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => new LoginPage(),
          '/home': (BuildContext context) => new HomePage(),
          '/success': (BuildContext context) => new SuccessPage(),

        },
      ),
    );
  }
}

