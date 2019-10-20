import 'package:flutter/material.dart';
import 'package:remaxinfoagent/Screens/Listings/Listinginfo.dart';

String listID;
String listType;

class ListingInfoW extends StatefulWidget {
  @override
  createState() => _ListingInfoW();
}

class _ListingInfoW extends State<ListingInfoW> {
  @override
  
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                          Text('Listing Details',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Sale / Rental'),
                              initialValue: liststate.detail_salerental,
                              onChanged: (value) =>
                                  {liststate.detail_salerental = value}),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Unit'),
                              initialValue: liststate.detail_Unit,
                              onChanged: (value) =>
                                  {liststate.detail_Unit = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Complex Name'),
                              initialValue: liststate.detail_ComplexName,
                              onChanged: (value) =>
                                  {liststate.detail_ComplexName = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Street Name'),
                              initialValue: liststate.detail_StreetName,
                              onChanged: (value) =>
                                  {liststate.detail_StreetName = value}),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Suburb'),
                              initialValue: liststate.detail_Suburb,
                              onChanged: (value) =>
                                  {liststate.detail_Suburb = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Erf Number'),
                              initialValue: liststate.detail_ErfNo,
                              onChanged: (value) =>
                                  {liststate.detail_ErfNo = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Unit Size'),
                              initialValue: liststate.detail_UnitSize,
                              onChanged: (value) =>
                                  {liststate.detail_UnitSize = value}),
                        ])))));
  }
}

//Price
class ListingInfoPrice extends StatefulWidget {
  @override
  createState() => _ListingPrice();
}

class _ListingPrice extends State<ListingInfoPrice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                        // key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                          Text('Listing Price',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Nett Price'),
                              initialValue: liststate.price_nett,
                              onChanged: (value) =>
                                  {liststate.price_nett = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Marketing Price'),
                              initialValue: liststate.price_MarkP,
                              onChanged: (value) =>
                                  {liststate.price_MarkP = value}),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Rates'),
                              initialValue: liststate.price_Rates,
                              onChanged: (value) =>
                                  {liststate.price_Rates = value}),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Levy'),
                              initialValue: liststate.price_leveys,
                              onChanged: (value) =>
                                  {liststate.price_leveys = value}),
                        ])))));
  }
}

//Listing Info Owner
class ListingInfoOwner extends StatefulWidget {
  @override
  createState() => _ListingOwner();
}

class _ListingOwner extends State<ListingInfoOwner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                        // key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                          Text('Listing Owner Details',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Name'),
                              initialValue: liststate.own_Name,
                              onChanged: (value) =>
                                  {liststate.own_Name = value}),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Surname'),
                              initialValue: liststate.own_Surname,
                              onChanged: (value) =>
                                  {liststate.own_Surname = value}),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Tel'),
                              initialValue: liststate.own_Tel,
                              onChanged: (value) =>
                                  {liststate.own_Tel = value}),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Email'),
                              initialValue: liststate.own_Email,
                              onChanged: (value) =>
                                  {liststate.own_Email = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Married in Com?'),
                              initialValue: liststate.own_Married,
                              onChanged: (value) =>
                                  {liststate.own_Married = value}),
                        ])))));
  }
}

//Listing Info Tenant
class ListingInfoTenant extends StatefulWidget {
  @override
  createState() => _ListingInfoTenant();
}

class _ListingInfoTenant extends State<ListingInfoTenant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                        // key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                          Text('Listing Tenant Details',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Name'),
                              initialValue: liststate.ten_Name,
                              onChanged: (value) =>
                                  {liststate.ten_Name = value}),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Surname'),
                              initialValue: liststate.ten_Surname,
                              onChanged: (value) =>
                                  {liststate.ten_Surname = value}),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Cell'),
                              initialValue: liststate.ten_Tel,
                              onChanged: (value) =>
                                  {liststate.ten_Tel = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Email Address'),
                              initialValue: liststate.ten_Email,
                              onChanged: (value) =>
                                  {liststate.ten_Email = value}),
                        ])))));
  }
}

//Listing Info Bed
class ListingInfoBed extends StatefulWidget {
  @override
  createState() => _ListingInfoBed();
}

class _ListingInfoBed extends State<ListingInfoBed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                          Text('Bedroom Details',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'No of Bedrooms'),
                              initialValue: liststate.bed_No,
                              onChanged: (value) => {liststate.bed_No = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Additional info'),
                              initialValue: liststate.bed_Add,
                              onChanged: (value) => {liststate.bed_Add = value}),
                        ])))));
  }
}

class ListingInfoBath extends StatefulWidget {
  @override
  createState() => _ListingInfoBath();
}

class _ListingInfoBath extends State<ListingInfoBath> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                        // key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                          Text('Bathroom Details',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'No of Bathrooms'),
                              initialValue: liststate.bath_No,
                              onChanged: (value) =>
                                  {liststate.bath_No = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Additional info'),
                              initialValue: liststate.bath_Add,
                              onChanged: (value) =>
                                  {liststate.bath_Add = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Guest Toilet'),
                              initialValue: liststate.bath_Guest,
                              onChanged: (value) =>
                                  {liststate.bath_Guest = value}),
                        ])))));
  }
}

//Interior
class ListingInfoIn extends StatefulWidget {
  @override
  createState() => _ListingInfoIn();
}

class _ListingInfoIn extends State<ListingInfoIn> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                        // key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                          Text('Interior Details',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextFormField(
                              decoration: InputDecoration(
                                  labelText:
                                      'Living Room/ Dining Room, Study (Seperate by ;)'),
                              initialValue: liststate.int_Detail,
                              onChanged: (value) =>
                                  {liststate.int_Detail = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Additional info'),
                              initialValue: liststate.int_Add,
                              onChanged: (value) =>
                                  {liststate.int_Add = value}),
                        ])))));
  }
}

//Exterior
class ListingInfoExterior extends StatefulWidget {
  @override
  createState() => _ListingInfoExterior();
}

class _ListingInfoExterior extends State<ListingInfoExterior> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                        // key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                          Text('Exterior Details',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Garden?'),
                              initialValue: liststate.ext_Garden,
                              onChanged: (value) =>
                                  {liststate.ext_Garden = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Swimming Pool'),
                              initialValue: liststate.ext_Pool,
                              onChanged: (value) =>
                                  {liststate.ext_Pool = value}),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Jacuzzi'),
                              initialValue: liststate.ext_Jacuzzi,
                              onChanged: (value) =>
                                  {liststate.ext_Jacuzzi = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Boma Braai'),
                              initialValue: liststate.ext_Braai,
                              onChanged: (value) =>
                                  {liststate.ext_Braai = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Additional Info'),
                              initialValue: liststate.ext_add,
                              onChanged: (value) =>
                                  {liststate.ext_add = value}),
                        ])))));
  }
}

class ListingInfoSec extends StatefulWidget {
  @override
  createState() => _ListingInfoSec();
}

class _ListingInfoSec extends State<ListingInfoSec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                        // key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                          Text('Security Details',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Electric Fence'),
                              initialValue: liststate.sec_eFence,
                              onChanged: (value) =>
                                  {liststate.sec_eFence = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Electric Gate'),
                              initialValue: liststate.sec_eGate,
                              onChanged: (value) =>
                                  {liststate.sec_eGate = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Intercom System'),
                              initialValue: liststate.sec_Intercom,
                              onChanged: (value) =>
                                  {liststate.sec_Intercom = value}),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Cameras'),
                              initialValue: liststate.sec_Camera,
                              onChanged: (value) =>
                                  {liststate.sec_Camera = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Security Gates'),
                              initialValue: liststate.sec_SecGate,
                              onChanged: (value) =>
                                  {liststate.sec_SecGate = value}),
                          TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Additional Info'),
                              initialValue: liststate.sec_Add,
                              onChanged: (value) =>
                                  {liststate.sec_Add = value}),
                        ])))));
  }
}
