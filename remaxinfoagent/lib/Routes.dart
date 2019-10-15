import 'package:flutter/material.dart';
import 'package:remaxinfoagent/Screens/Listings/Listinginfo.dart' as prefix0;
import 'package:remaxinfoagent/Screens/Listings/listinglist.dart';
import 'package:remaxinfoagent/Screens/Listings/listinginfo.dart';
import 'package:remaxinfoagent/Screens/Login/index.dart';
import 'package:remaxinfoagent/Screens/Home/index.dart';
import 'package:remaxinfoagent/Screens/Login/signup.dart';
import 'package:remaxinfoagent/Screens/ToDo/ToDo.dart';
import 'package:remaxinfoagent/Screens/Login/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Routes {
  String uid;

    void _getuser() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    uid = user.uid.toString();
  }

  Routes() {
    runApp(new MaterialApp(
      title: "Remax",
      debugShowCheckedModeBanner: false,
      //home: new LoginScreen(),
      home: new HomeScreen(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return new MyCustomRoute(
              builder: (_) => new LoginScreen(auth: new Auth()),
              settings: settings,
            );
             case '/SignUp':
            return new MyCustomRoute(
              builder: (_) => new SignUpScreen(auth: new Auth()),
              settings: settings,
            );
          case '/home':
            return new MyCustomRoute(
              builder: (_) => new HomeScreen(),
              settings: settings,
            );
          case '/listinglist':
            return new MyCustomRoute(
              builder: (_) => new ListingList('0', uid ),
              settings: settings,
            );
           case '/inspectionslist':
            return new MyCustomRoute(
              builder: (_) => new ListingList('1', uid ),
              settings: settings,
            );
            case '/ToDo':
            return new MyCustomRoute(
              builder: (_) => new ToDo(),
              settings: settings,
            );


        }
      },
    ));
  }
}



class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}
