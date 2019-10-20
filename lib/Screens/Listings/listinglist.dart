import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'package:mailer/mailer.dart';
import 'package:remaxinfoagent/widgets/Listinginfo.dart';
import 'package:remaxinfoagent/Screens/Home/index.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:remaxinfoagent/Screens/Listings/Listinginfo.dart';
import 'package:mailer/smtp_server.dart';

String mlistID;
String mlistType;
String h_userId;

class ListingList extends StatefulWidget {
  final String listType;
  final String userid;

  ListingList(this.listType, this.userid);
  //const ListingList({Key key}) : super(key: key);
  @override
  ListingListState createState() {
    return ListingListState(this.listType, this.userid);
  }
}

class ListingListState extends State<ListingList> {
  TextEditingController editingController = TextEditingController();
  String archiveflag = '0';
  final db = Firestore.instance;
  //final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = List<String>();
  String userid = '';
  String listType;
  String sType = '';
  String iType = '';
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

  Stream<QuerySnapshot> stream;
  ListingListState(this.listType, this.userid);
  @override
  void initState() {
    switch (listType) {
      case '0':
        {
          sType = 'Listing';
          iType = '0';
          mlistType = '0';
        }
        break;
      case '1':
        {
          sType = 'Inspection';
          iType = '1';
          mlistType = '1';
        }
        break;
    }
    stream = db
        .collection('Listings')
        .where('UserID', isEqualTo: h_userId)
        .where('lst_Archive', isEqualTo: archiveflag)
        .where('lst_AppType', isEqualTo: iType)
        .snapshots();
    //items.addAll(duplicateItems);
    super.initState();
  }

//Email
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

  void readData() async {
    if (mlistID != '0') {
      print('List ID' + mlistID.toString());
      DocumentSnapshot snapshot =
          await db.collection('Listings').document(mlistID).get();
      // setState(() {
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
    } //);
    // }
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
              child: Icon(Icons.business),
              foregroundColor: Colors.white,
            ),
            title: Text('${doc.data['lst_Erf_No']} ${doc.data['lst_Street']}'),
            subtitle: Text('${doc.data['lst_ComplexName']}'),
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
              caption: 'Archive',
              color: Colors.blue,
              icon: Icons.archive,
              onTap: () {
                Firestore.instance
                    .collection('Listings')
                    .document(doc.documentID.toString())
                    .updateData({'lst_Archive': '1'});
              }),
          IconSlideAction(
              caption: 'Edit',
              color: Colors.indigo,
              icon: Icons.edit_attributes,
              onTap: () {
                hlistID = doc.documentID.toString();
                hlistType = iType.toString();
                hLoad = '0';
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListingInfo()));
              }),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => {
                    Firestore.instance
                        .collection('Listings')
                        .document(doc.documentID.toString())
                        .delete()
                  }),
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
   // dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        //items.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MaterialColor iconcolor = Colors.grey;
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(sType),
          actions: <Widget>[
            // action button
            new IconButton(
                icon: new Icon(Icons.home),
                tooltip: 'Home',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                })
          ],
          backgroundColor: Color.fromRGBO(207, 0, 0, 1)),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.save_alt),
        backgroundColor: Color.fromRGBO(207, 0, 0, 1),
        label: const Text('Add'),
        onPressed: () {
          hlistID = '0';
          hlistType = iType.toString();
          Navigator.pushReplacementNamed(context, '/lstDetails');
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
          child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              filterSearchResults(value);
            },
            controller: editingController,
            decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
            stream: stream,
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
      ])),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.archive, color: iconcolor),
              onPressed: () {
                switch (archiveflag) {
                  case '0':
                    {
                      iconcolor = Colors.grey;
                      archiveflag = '1';
                      setState(() {
                        stream = db
                            .collection('Listings')
                            .where('UserID', isEqualTo: h_userId)
                            .where('lst_Archive', isEqualTo: '1')
                            .where('lst_AppType', isEqualTo: iType)
                            .snapshots();
                      });
                    }
                    break;

                  case '1':
                    {
                      iconcolor = Colors.red;
                      archiveflag = '0';
                      setState(() {
                        stream = db
                            .collection('Listings')
                            .where('UserID', isEqualTo: h_userId)
                            .where('lst_Archive', isEqualTo: '0')
                            .where('lst_AppType', isEqualTo: iType)
                            .snapshots();
                      });
                    }
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
