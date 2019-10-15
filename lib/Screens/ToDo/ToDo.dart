import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class _Page {
  _Page({this.widget});
  final StatelessWidget widget;
}

List<_Page> _allPages = <_Page>[
  //_Page(widget: ToDo(""),),
];

class ToDo extends StatefulWidget {
  @override
  _ToDo createState() => new _ToDo();
}

class _ToDo extends State<ToDo> with SingleTickerProviderStateMixin {
  TabController _controller;
  String id;
  final db = Firestore.instance;
  final _formkey = GlobalKey<FormState>();
  String name;
  String uid = '';

  @override
  void initState() {
    super.initState();
    _getuser();
    _controller = TabController(vsync: this, length: _allPages.length);
  }

  Card buildItem(DocumentSnapshot doc) {
    return Card(
      child: new Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('!'),
              foregroundColor: Colors.white,
            ),
            title: Text('${doc.data['Name']}'),
            // subtitle: Text('SlidableDrawerDelegate'),
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => deleteData(doc),
          )
        ],
      ),
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Task Name',
        fillColor: Colors.grey[300],
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please eneter the name of your task';
        }
      },
      onSaved: (value) => name = value,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: const Text('To Do'),
          actions: <Widget>[
            // action button
            new IconButton(
                icon: new Icon(Icons.home),
                tooltip: 'Home',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                })
          ],
          backgroundColor: Color.fromRGBO(207, 0, 0, 1),
        ),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            Form(
              key: _formkey,
              child: buildTextFormField(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                    onPressed: createData,
                    child:
                        Text('Create', style: TextStyle(color: Colors.white)),
                    color: Colors.redAccent)
              ],
            ),
            StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection('ToDo')
                    .where('UserID', isEqualTo: uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: snapshot.data.documents
                            .map((doc) => buildItem(doc))
                            .toList());
                  } else {
                    return SizedBox();
                  }
                })
          ],
        ));
  }

  void createData() async {
    if (_formkey.currentState.validate()) {
      //final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      //final String uid = user.uid.toString();

      _formkey.currentState.save();
      DocumentReference ref =
          await db.collection('ToDo').add({'Name': '$name', 'UserID': uid});
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('ToDo').document(doc.documentID).delete();
    setState(() => id = null);
  }

  void _getuser() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    uid = user.uid.toString();
  }
}
