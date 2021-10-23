import 'package:flutter/material.dart';
import 'package:flutter_netap/page/location.dart';
import 'package:flutter_netap/page/location2.dart';
import 'package:flutter_netap/page/permission_page.dart';
import 'package:flutter_netap/page/profile.dart';
import 'package:flutter_netap/page/sick-leave.dart';
import 'package:flutter_netap/page/submit_request.dart';
import 'package:flutter_netap/screens/login_screen 2.dart';
import '../main.dart';
import 'checkin_page.dart';
import 'location2.dart';
import 'package:flutter_netap/provider/checkProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CheckProvider _checkProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _checkProvider = Provider.of<CheckProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 132, 188, 1),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: Icon(Icons.account_circle_outlined),
            ),
          )
        ],
        leading: InkWell(
          child: Icon(Icons.logout_outlined),
          onTap: () {
            _checkProvider.checkIn = false;
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login2Screen()));
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(32, 10, 32, 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assets/images/logo.png"),
              SizedBox(height: 10),
              buildCheckInButton(context),
              SizedBox(height: 30),
              buildSickleaveButton(context),
              SizedBox(height: 30),
              buildAbsentExcuseButton(context),
              SizedBox(height: 30),
              buildPermissionButton(context),
              SizedBox(height: 30),
              buildCheckOutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCheckInButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(60),
          primary: _checkProvider.checkIn == true
              ? Colors.green
              : Color.fromRGBO(0, 132, 188, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Check-In Here',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          if (_checkProvider.checkIn == false)
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Home()),
            );
        },
      );

  Widget buildSickleaveButton(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(60),
        primary: Color.fromRGBO(0, 132, 188, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        'Sick-Leave Request',
        style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      onPressed: () {});

  Widget buildAbsentExcuseButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(60),
          primary: Color.fromRGBO(0, 132, 188, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Absence Excuse',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SubmitFileScreen()),
        ),
      );
  Widget buildPermissionButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(60),
          primary: Color.fromRGBO(0, 132, 188, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Permission To Leave',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Permission()),
        ),
      );

  Widget buildCheckOutButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(60),
          primary: _checkProvider.checkIn == true
              ? Color.fromRGBO(0, 132, 188, 1)
              : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Check-Out Here',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          if (_checkProvider.checkIn == true)
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Home2()),
            );
        },
      );
}
