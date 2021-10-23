import 'package:flutter/material.dart';
import 'package:flutter_netap/screens/login_screen%203.dart';
import 'package:flutter_netap/screens/usertype.dart';

class InstructorScreen extends StatefulWidget {
  @override
  _InstructorScreenState createState() => _InstructorScreenState();
}

class _InstructorScreenState extends State<InstructorScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final staffButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(0, 132, 188, 1),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login3Screen()));
          },
          child: Text(
            "Yes",
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
                MaterialPageRoute(builder: (context) => UserTypeScreen()));
          },
          child: Text(
            "No",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => UserTypeScreen()));
          },
        ),
        title: Text('Instructor'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 132, 188, 1),
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
                          "Are you Instructor?",
                          style: TextStyle(
                              fontSize: 40,
                              color: Color.fromRGBO(0, 132, 188, 1),
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(height: 10),
                    SizedBox(height: 15),
                    staffButton,
                    SizedBox(height: 15),
                    instructorButton,
                    SizedBox(height: 115),
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
