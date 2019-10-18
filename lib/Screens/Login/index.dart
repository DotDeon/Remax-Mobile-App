import 'package:flutter/material.dart';
import 'package:remaxinfoagent/Components/SignUpLink.dart';
import 'package:remaxinfoagent/Screens/Login/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginAnimation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import '../../Components/WhiteTick.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'authentication.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
with TickerProviderStateMixin {
  TextEditingController txtUsername;
  TextEditingController txtPassword;

  AnimationController _loginButtonController;
  bool loggedin = false;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _userId = "";
 

  var animationStatus = 0;
  @override
  void initState() {
    super.initState();
    _singout();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

   void _showDialog() 
   {
     showDialog(
       context: context,
       builder: (BuildContext context){
         return AlertDialog(
           title: new Text('Invalid Login'),
           content: new Text('Please check the username and password and try again'),
           actions: <Widget>[
             new FlatButton(
               child: new Text('Close'),
               onPressed: () {
                 Navigator.of(context).pop();
               },
             )

           ],
         );

       }
     );


   }

  void _singout() async {
   await widget.auth.signOut();
  }


   void _validateAndSubmit() async {
    setState(() {   });

      try {
        if(_email == 'remax' && _password == 'remax')
        {
          
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new SignUpScreen()));
        }
        else
        {
        _userId = await widget.auth.signIn(_email,  _password);
        if (_userId.length > 0 && _userId != null) {

          animationStatus = 1;
          
         _playAnimation();
         
        }
        }
      }
      catch(e)
      {
            _formKey.currentState.reset();
            _showDialog();

      }
      } 

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text('Are you sure?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, "/home"),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return (new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          body: new Container(
              decoration: new BoxDecoration(
                image: backgroundImage,
              ),
              child: new Container(
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                    colors: <Color>[
                      const Color.fromRGBO(162, 146, 199, 0.8),
                      const Color.fromRGBO(51, 51, 63, 0.9),
                    ],
                    stops: [0.2, 1.0],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                  )),
                  child: new ListView(
                    padding: const EdgeInsets.all(0.0),
                    children: <Widget>[
                      new Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Tick(image: tick),
                              new Container(
                                margin:
                                    new EdgeInsets.symmetric(horizontal: 20.0),
                                child: new Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    new Form(
                                      key: _formKey,
                                      child: new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        new Container(
                                                      decoration: new BoxDecoration(
                                                        border: new Border(
                                                          bottom: new BorderSide(
                                                            width: 0.5,
                                                            color: Colors.white24,
                                                          ),
                                                        ),
                                                      ),
                                                      child: TextFormField(
                                                        obscureText: false,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        decoration: new InputDecoration(
                                                          icon: new Icon(
                                                            Icons.person_outline,
                                                            color: Colors.white,
                                                          ),
                                                          border: InputBorder.none,
                                                          hintText: "Username",
                                                          hintStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                                                          contentPadding: const EdgeInsets.only(
                                                              top: 30.0, right: 30.0, bottom: 30.0, left: 5.0),
                                                        ),
                                                        onSaved: (value) => _email = value.trim(),
                                                      ),
                                                    ),
                                      new Container(
                                                      decoration: new BoxDecoration(
                                                        border: new Border(
                                                          bottom: new BorderSide(
                                                            width: 0.5,
                                                            color: Colors.white24,
                                                          ),
                                                        ),
                                                      ),
                                                      child: TextFormField(
                                                        obscureText: true,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        decoration: new InputDecoration(
                                                          icon: new Icon(
                                                            Icons.lock_outline,
                                                            color: Colors.white,
                                                          ),
                                                          border: InputBorder.none,
                                                          hintText: "Password",
                                                          hintStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                                                          contentPadding: const EdgeInsets.only(
                                                              top: 30.0, right: 30.0, bottom: 30.0, left: 5.0),
                                                        ),
                                                        onSaved: (value) => _password = value.trim(),
                                                      ),
                                                    ),
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                              new InkWell(
                                     
                                      onTap: () {
                                         final form = _formKey.currentState;
                                          form.save();
                                         _validateAndSubmit();
                                      },
                                      //padding: const EdgeInsets.only(bottom: 50.0),
                                      child: new Container(
                                        width: 320.0,
                                        height: 60.0,
                                        
                                        margin: const EdgeInsets.only(top: 60.0),
                                        alignment: FractionalOffset.center,
                                        decoration: new BoxDecoration(
                                          color: const Color.fromRGBO(
                                              207, 0, 15, 1),
                                          borderRadius: new BorderRadius.all(
                                              const Radius.circular(30.0)),
                                        ),
                                        child: new Text(
                                          "Sign In",
                                          style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                      )),
                            ],
                          ),
                          animationStatus == 0
                          ? new Padding(
                                  padding: const EdgeInsets.only(top: 60.0),
                                )
                          : new StaggerAnimation(
                                  buttonController:
                                      _loginButtonController.view),
                        ],
                      ),
                    ],
                  ))),
        )));
  }
}