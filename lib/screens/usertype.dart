import 'package:flutter/material.dart';
import 'package:flutter_netap/screens/admin.dart';
import 'package:flutter_netap/screens/instructor.dart';
import 'package:flutter_netap/screens/staff.dart';

class UserTypeScreen extends StatefulWidget {
  @override
  _UserTypeScreenState createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final adminButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(0, 132, 188, 1),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AdminScreen()));
          },
          child: Text(
            "Admin",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    final staffButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(0, 132, 188, 1),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => StaffScreen()));
          },
          child: Text(
            "Staff",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    final instructorButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(0, 132, 188, 1),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => InstructorScreen()));
          },
          child: Text(
            "Instructor",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("ONETAP"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 132, 188, 1),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      height: 0,
                      child: Image.asset(
                        "assets/images/BKG3UP.png",
                        //width: 5000,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    SizedBox(height: 80),
                    SizedBox(
                        height: 100,
                        child: Text(
                          "Welcome",
                          style: TextStyle(
                              fontSize: 40,
                              color: Color.fromRGBO(0, 132, 188, 1),
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                        height: 100,
                        child: Text(
                          "Choose Your Role",
                          style: TextStyle(
                              fontSize: 40,
                              color: Color.fromRGBO(0, 132, 188, 1),
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(height: 10),
                    adminButton,
                    SizedBox(height: 15),
                    staffButton,
                    SizedBox(height: 15),
                    instructorButton,
                    Positioned(
                      bottom: 0,
                      right: 0,
                      height: 0,
                      child: Image.asset(
                        "assets/images/BKG3.png",
                        // width: 4000,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
