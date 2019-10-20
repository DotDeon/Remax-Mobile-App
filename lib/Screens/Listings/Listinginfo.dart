import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:remaxinfoagent/widgets/Listinginfo.dart';
import 'package:remaxinfoagent/Screens/Listings/placeholderwidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'listinglist.dart';

_ListingInfo liststate;
String hlistID;
String hlistType;
String hLoad;

class _Page {
  _Page({this.widget});
  final StatefulWidget widget;
}

List<_Page> _allPages = <_Page>[
  _Page(widget: ListingInfoW()),
  _Page(widget: ListingInfoPrice()),
  _Page(widget: ListingInfoOwner()),
  _Page(widget: ListingInfoTenant()),
  _Page(widget: ListingInfoBed()),
  _Page(widget: ListingInfoBath()),
  _Page(widget: ListingInfoIn()),
  _Page(widget: ListingInfoExterior()),
  _Page(widget: ListingInfoSec()),
];

class ListingInfo extends StatefulWidget {
  final formkey = GlobalKey<FormState>();

  @override
  createState() {
    liststate = new _ListingInfo();
    return liststate;
  }
}

class Listing {
  String listID;
  String userid;
  String listType;
  String detail_salerental;
  String detail_ComplexName;
  String detail_ErfNo;
  String detail_StreetName;
  String detail_Suburb;
  String detail_Unit;
  String detail_UnitSize;
  String price_nett;
  String price_MarkP;
  String price_Rates;
  String price_leveys;
  String own_Name;
  String own_Surname;
  String own_Tel;
  String own_Email;
  String own_Married;
  String ten_Name;
  String ten_Surname;
  String ten_Tel;
  String ten_Email;
  String bed_No;
  String bed_Add;
  String bath_No;
  String bath_Add;
  String bath_Guest;
  String int_Detail;
  String int_Add;
  String ext_Garden;
  String ext_Pool;
  String ext_Jacuzzi;
  String ext_Braai;
  String ext_add;
  String sec_eFence;
  String sec_eGate;
  String sec_Intercom;
  String sec_Camera;
  String sec_SecGate;
  String sec_Add;
}

class _ListingInfo extends State<ListingInfo>
    with SingleTickerProviderStateMixin {
  _ListingInfo();
  TabController _controller;
  final db = Firestore.instance;
  List<Listing> list;
  String listID = hlistID;
  String userid;
  String listType = mlistType;
  String detail_salerental;
  String detail_ComplexName;
  String detail_ErfNo;
  String detail_StreetName;
  String detail_Suburb;
  String detail_Unit;
  String detail_UnitSize;
  String price_nett;
  String price_MarkP;
  String price_Rates;
  String price_leveys;
  String own_Name;
  String own_Surname;
  String own_Tel;
  String own_Email;
  String own_Married;
  String ten_Name;
  String ten_Surname;
  String ten_Tel;
  String ten_Email;
  String bed_No;
  String bed_Add;
  String bath_No;
  String bath_Add;
  String bath_Guest;
  String int_Detail;
  String int_Add;
  String ext_Garden;
  String ext_Pool;
  String ext_Jacuzzi;
  String ext_Braai;
  String ext_add;
  String sec_eFence;
  String sec_eGate;
  String sec_Intercom;
  String sec_Camera;
  String sec_SecGate;
  String sec_Add;
  String init1 = '0';

  @override
  void initState() {
    super.initState();
    
    _getuser();
    readData();

    _controller = TabController(vsync: this, length: _allPages.length);
    // setState(() {});
    //Navigator.pop(context);
  }

  Future<void> _getuser() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    userid = user.uid.toString();
  }

  void mail() async {
    String username = 'remaxinfoagent@gmail.com';
    String password = 'kYqN7RyWCHjzh2rL';
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String email = user.email;
    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.
    // Create our message.
    final message = Message()
      ..from = Address(username, 'Remax Infoagent')
      ..recipients.add(email)
      //  ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject =
          '$detail_Unit $detail_StreetName $detail_Suburb  ${DateTime.now()}'
      ..text =
          'DETAILS \n Sales/Rental: $detail_salerental \n Complex Name: $detail_ComplexName \n Erf No: $detail_ErfNo \n Street Name: $detail_StreetName \n Suburb: $detail_Suburb \n Unit: $detail_Unit \n Unit Size: $detail_UnitSize \n PRICE \n Nett Price: $price_nett \n Market Price: $price_MarkP \n Rates: $price_Rates \n Levey:  $price_leveys \n OWNDER DETAILS \n Name: $own_Name \n Surname: $own_Surname \n Tel: $own_Tel \n Email: $own_Email \n Married in community of property: $own_Married \n TENANT \n Name: $ten_Name \n Surname $ten_Surname \n Tel: $ten_Tel \n Email: $ten_Email \n BEDROOMS \n No of Bedrooms: $bed_No \n Additional Info: $bed_Add \n BATHROOMS \n No of Bathrooms: $bath_No \n Guest Bathrooms: $bath_Guest \n Additional Info: $bath_Add \n INTERIOR \n Interior Detail: $int_Detail \n Interior Additional Info: $int_Add \n EXTERIOR \n Garden: $ext_Garden \n Pool: $ext_Pool \n Jacuzzi: $ext_Jacuzzi \n Braai: $ext_Braai \n Additional Info: $ext_add \n SECURITY \n Electric Fence: $sec_eFence \n Electric Gate: $sec_eGate \n Intercom: $sec_Intercom \n Camera: $sec_Camera \n Security Gate: $sec_SecGate \n Additional Info: $sec_Add';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Future<void> readData() async {
    //await new Future.delayed(new Duration(seconds: 3));
    if (hlistID != '0') {
      print('List ID' + hlistID.toString());
      DocumentSnapshot snapshot =
          await db.collection('Listings').document(hlistID).get();
      setState(() {
        detail_salerental = snapshot.data['lst_Type'];
        detail_ComplexName = snapshot.data['lst_ComplexName'];
        detail_ErfNo = snapshot.data['lst_Erf_No'];
        detail_StreetName = snapshot.data['lst_Street'];
        detail_Suburb = snapshot.data['lst_Suburb'];
        detail_Unit = snapshot.data['lst_Unit'];
        detail_UnitSize = snapshot.data['lst_UnitSize'];
        price_nett = snapshot.data['pri_Nett'];
        price_MarkP = snapshot.data['pri_Mark'];
        price_Rates = snapshot.data['pri_Rates'];
        price_leveys = snapshot.data['pri_Levey'];
        own_Name = snapshot.data['own_Name'];
        own_Surname = snapshot.data['own_Surname'];
        own_Tel = snapshot.data['own_Tel'];
        own_Email = snapshot.data['own_Email'];
        own_Married = snapshot.data['own_Married'];
        ten_Name = snapshot.data['ten_Name'];
        ten_Surname = snapshot.data['ten_Surname'];
        ten_Tel = snapshot.data['ten_Tel'];
        ten_Email = snapshot.data['ten_Email'];
        bed_No = snapshot.data['bed_No'];
        bed_Add = snapshot.data['bed_Add'];
        bath_No = snapshot.data['bath_No'];
        bath_Add = snapshot.data['bath_Add'];
        bath_Guest = snapshot.data['bath_Guest'];
        int_Detail = snapshot.data['int_Detail'];
        int_Add = snapshot.data['int_Add'];
        ext_Garden = snapshot.data['ext_Garden'];
        ext_Pool = snapshot.data['ext_Pool'];
        ext_Jacuzzi = snapshot.data['ext_Jacuzzi'];
        ext_Braai = snapshot.data['ext_Braai'];
        ext_add = snapshot.data['ext_Add'];
        sec_eFence = snapshot.data['sec_eFence'];
        sec_eGate = snapshot.data['sec_eGate'];
        sec_Intercom = snapshot.data['sec_Intercom'];
        sec_Camera = snapshot.data['sec_Camera'];
        sec_SecGate = snapshot.data['sec_SecGate'];
        sec_Add = snapshot.data['sec_Add'];
        print(snapshot.data['lst_Type']);
      });
    }

    return;
  }

  updateData() async {
    await Firestore.instance
        .collection('Listings')
        .document(hlistID)
        .updateData({
      'lst_AppType': mlistType,
      'lst_Archive': '0',
      'lst_ComplexName': detail_ComplexName,
      'lst_Erf_No': detail_ErfNo,
      'lst_Street': detail_StreetName,
      'lst_Suburb': detail_Suburb,
      'lst_Type': detail_salerental,
      'lst_Unit': detail_Unit,
      'lst_UnitSize': detail_UnitSize,
      'UserID': userid,
      'pri_Levey': price_leveys,
      'pri_Mark': price_MarkP,
      'pri_Nett': price_nett,
      'pri_Rates': price_Rates,
      'own_Email': own_Email,
      'own_Married': own_Married,
      'own_Name': own_Name,
      'own_Surname': own_Surname,
      'own_Tel': own_Tel,
      'ten_Name': ten_Name,
      'ten_Surname': ten_Surname,
      'ten_Email': ten_Email,
      'ten_Tel': ten_Tel,
      'bed_No': bed_No,
      'bed_Add': bed_Add,
      'bath_Add': bath_Add,
      'bath_Guest': bath_Guest,
      'bath_No': bath_No,
      'int_Detail': int_Detail,
      'int_Add': int_Add,
      'ext_Garden': ext_Garden,
      'ext_Pool': ext_Pool,
      'ext_Jacuzzi': ext_Jacuzzi,
      'ext_Braai': ext_Braai,
      'ext_Add': ext_add,
      'sec_eFence': sec_eFence,
      'sec_eGate': sec_eGate,
      'sec_Intercom': sec_Intercom,
      'sec_Camera': sec_Camera,
      'sec_SecGate': sec_SecGate,
      'sec_Add': sec_Add
    });
  }

  void _showModal() {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: 1,
              maxChildSize: 1,
              minChildSize: 1,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return new Column(
                  //mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new ListTile(
                      leading: new Icon(Icons.work),
                      title: new Text('Details'),
                      onTap: () {
                        _controller.animateTo(0);
                        Navigator.pop(context);
                      },
                    ),
                    new ListTile(
                      leading: new Icon(Icons.attach_money),
                      title: new Text('Price'),
                      onTap: () {
                        _controller.animateTo(1);
                        Navigator.pop(context);
                      },
                    ),
                    new ListTile(
                      leading: new Icon(Icons.person),
                      title: new Text('Owner Details'),
                      onTap: () {
                        _controller.animateTo(2);
                        Navigator.pop(context);
                      },
                    ),
                    new ListTile(
                      leading: new Icon(Icons.person_add),
                      title: new Text('Tenant Details'),
                      onTap: () {
                        _controller.animateTo(3);
                        Navigator.pop(context);
                      },
                    ),
                    new ListTile(
                      leading: new Icon(Icons.airline_seat_individual_suite),
                      title: new Text('Bedroom Details'),
                      onTap: () {
                        _controller.animateTo(4);
                        Navigator.pop(context);
                      },
                    ),
                    new ListTile(
                      leading: new Icon(Icons.hot_tub),
                      title: new Text('Bathroom Details'),
                      onTap: () {
                        _controller.animateTo(5);
                        Navigator.pop(context);
                      },
                    ),
                    new ListTile(
                      leading: new Icon(Icons.tv),
                      title: new Text('Interior Details'),
                      onTap: () {
                        _controller.animateTo(6);
                        Navigator.pop(context);
                      },
                    ),
                    new ListTile(
                      leading: new Icon(Icons.pool),
                      title: new Text('Exterior Details'),
                      onTap: () {
                        _controller.animateTo(7);
                        Navigator.pop(context);
                      },
                    ),
                    new ListTile(
                      leading: new Icon(Icons.security),
                      title: new Text('Security'),
                      onTap: () {
                        _controller.animateTo(8);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
        });
  }

  void createData() async {
    DocumentReference ref = await db.collection('Listings').add({
      'lst_AppType': mlistType,
      'lst_Archive': '0',
      'lst_ComplexName': detail_ComplexName,
      'lst_Erf_No': detail_ErfNo,
      'lst_Street': detail_StreetName,
      'lst_Suburb': detail_Suburb,
      'lst_Type': detail_salerental,
      'lst_Unit': detail_Unit,
      'lst_UnitSize': detail_UnitSize,
      'UserID': userid,
      'pri_Levey': price_leveys,
      'pri_Mark': price_MarkP,
      'pri_Nett': price_nett,
      'pri_Rates': price_Rates,
      'own_Email': own_Email,
      'own_Married': own_Married,
      'own_Name': own_Name,
      'own_Surname': own_Surname,
      'own_Tel': own_Tel,
      'ten_Name': ten_Name,
      'ten_Surname': ten_Surname,
      'ten_Email': ten_Email,
      'ten_Tel': ten_Tel,
      'bed_No': bed_No,
      'bed_Add': bed_Add,
      'bath_Add': bath_Add,
      'bath_Guest': bath_Guest,
      'bath_No': bath_No,
      'int_Detail': int_Detail,
      'int_Add': int_Add,
      'ext_Garden': ext_Garden,
      'ext_Pool': ext_Pool,
      'ext_Jacuzzi': ext_Jacuzzi,
      'ext_Braai': ext_Braai,
      'ext_Add': ext_add,
      'sec_eFence': sec_eFence,
      'sec_eGate': sec_eGate,
      'sec_Intercom': sec_Intercom,
      'sec_Camera': sec_Camera,
      'sec_SecGate': sec_SecGate,
      'sec_Add': sec_Add
    });
    setState(() => hlistID = ref.documentID);
    // print(ref.documentID);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          // action button
          new IconButton(
              icon: new Icon(Icons.home),
              tooltip: 'Home',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              })
        ],
        title: const Text('List'),
        backgroundColor: Color.fromRGBO(207, 0, 0, 1),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.save_alt),
        backgroundColor: Color.fromRGBO(207, 0, 0, 1),
        label: Text("Save"),
        onPressed: () {
          if (hlistID == '0') {
            createData();
          } else {
            updateData();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: TabBarView(
          controller: _controller,
          children: _allPages.map<Widget>((_Page page) {
            return SafeArea(
              top: false,
              bottom: false,
              child: Container(
                  // key: _formkey,
                  padding: const EdgeInsets.all(12.0),
                  child: page.widget),
            );
          }).toList()),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  _showModal();
                }),
            IconButton(
              icon: Icon(Icons.email),
              onPressed: () {
                mail();
              },
            ),
          ],
        ),
      ),
    );
  }
}
