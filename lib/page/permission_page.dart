import 'dart:ui';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_netap/backend/server2.dart';
import 'package:flutter_netap/model/permissionmodel.dart';
import 'package:flutter_netap/page/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_netap/widgets/custom_text_field.dart';
import 'package:get/get.dart';

class Permission extends StatefulWidget {
  const Permission({Key? key}) : super(key: key);

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<Permission> {
  GlobalKey<FormState> saveFormKey = GlobalKey<FormState>();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController reason = TextEditingController();
  PermissionModel? permissionModel;

  saveForm() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (saveFormKey.currentState!.validate()) {
      permissionModel = PermissionModel(
        reqId: firebaseUser!.uid,
        reqEmail: firebaseUser.email,
        date: date.text,
        time: time.text,
        reason: reason.text,
      );
      bool done = await permissionToFirebase(permissionModel!.toMap());
      if (done) {
        print('done');
        showSuccess();
      } else {
        print('error');
      }
    }
  }

  showSuccess() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Success"),
          content: new Text("Permission was requested"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        title: Text('Permission To Leave'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 132, 188, 1),
      ),
      body: Form(
        key: saveFormKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

              SizedBox(
                height: 80,
              ),
              Text("fill the required to request permission"),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DateTimePicker(
                      type: DateTimePickerType.date,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      initialValue: '',
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return (" cannot be Empty");
                        }
                      },
                      onChanged: (value) {
                        date.text = value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: DateTimePicker(
                      decoration: InputDecoration(
                        labelText: 'Time',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      type: DateTimePickerType.time,
                      initialValue: '',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return (" cannot be Empty");
                        }
                      },
                      onChanged: (value) {
                        time.text = value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              //TextFeild(label: 'Location', controller: courseLocation ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextFormField(
                    autofocus: false,
                    controller: reason,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return (" course Location cannot be Empty");
                      }
                    },
                    onSaved: (value) {
                      reason.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.text_snippet,
                        color: Color.fromRGBO(0, 132, 188, 1),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Reason",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
              ),
              SizedBox(
                height: 90,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                    onPressed: saveForm,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      primary: Color.fromRGBO(0, 132, 188, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    primary: Color.fromRGBO(0, 132, 188, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
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
    );
  }
}
