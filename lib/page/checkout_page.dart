// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_netap/page/checkout_success.dart';
import 'package:flutter_netap/page/location.dart';
import 'package:local_auth/local_auth.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_netap/provider/checkProvider.dart';

var now = DateTime.now();
var formattedDate = DateFormat('kk:mm \n EEE d MMM').format(now);

class CheckoutScreens extends StatefulWidget {
  @override
  _CheckoutScreensState createState() => _CheckoutScreensState();
}

class _CheckoutScreensState extends State<CheckoutScreens> {
  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  late CheckProvider _checkProvider;

  @override
  void initState() {
    super.initState();
    _checkProvider = Provider.of<CheckProvider>(context, listen: false);
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) return;
    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
    if (authenticated) {
      _checkProvider.checkIn = false;
      await successCheckOut();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CheckoutSuccess()));
    }
  }

  void _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  Future<bool> successCheckOut() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid.toString())
        .update({
      'checkIn': false,
      'checkedTime': DateTime.now().millisecondsSinceEpoch
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Check-out'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 132, 188, 1),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, new MaterialPageRoute(builder: (context) => Home()));
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 80),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(formattedDate,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Color.fromRGBO(0, 132, 188, 1),
                  )),
              Image.asset("assets/images/IMG_3053.PNG"),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150.1, 40.0),
                      primary: Color.fromRGBO(0, 132, 188, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _authenticate,
                    child: Text(
                      "Check-out",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
