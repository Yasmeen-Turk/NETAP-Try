import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _ctrlEmail = TextEditingController();
  TextEditingController _ctrlName = TextEditingController();
  TextEditingController _ctrlPhone = TextEditingController();
  TextEditingController _ctrlFaculty = TextEditingController();

  Widget textProfileField(
      {@required hintText,
      required TextEditingController controller,
      bool isEmail = false}) {
    return Material(
      elevation: 4,
      shadowColor: Color.fromRGBO(0, 132, 188, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        enabled: !isEmail,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  getUser() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    var doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid.toString())
        .get();
    setState(() {
      _ctrlEmail.text = doc.data()!["email"];
      _ctrlName.text = (doc.data()!["firstName"] ?? "") +
          " " +
          (doc.data()!["secondName"] ?? "");
      _ctrlPhone.text = doc.data()!["phone"] ?? "";
      _ctrlFaculty.text = doc.data()!["faculty"] ?? "";
    });
  }

  updateProfile() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    List<String> nameList = _ctrlName.text.split(" ");
    String firstName = "";
    String secondName = "";
    if (nameList.length != 0) {
      firstName = nameList[0];
      for (var i = 0; i < nameList.length; i++) {
        if (i == 0) continue;
        secondName += (nameList[i] + " ");
      }
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid.toString())
        .update({
      'firstName': firstName,
      'secondName': secondName,
      "phone": _ctrlPhone.text,
      "faculty": _ctrlFaculty.text
    }).then((value) {
      showSuccess();
    });
  }

  showSuccess() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Success"),
          content: new Text("Profile Information was updated"),
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
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(0, 132, 188, 1),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/images/DB4DAB91-913E-4CA0-9CC0-219035571712.jpeg'),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 270, left: 184),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 450,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textProfileField(
                            hintText: 'Name', controller: _ctrlName),
                        textProfileField(
                            hintText: 'Email',
                            controller: _ctrlEmail,
                            isEmail: true),
                        textProfileField(
                            hintText: 'Phone Number', controller: _ctrlPhone),
                        textProfileField(
                            hintText: 'Faculty', controller: _ctrlFaculty),
                        Container(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(150.1, 40.0),
                              primary: Color.fromRGBO(0, 132, 188, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => updateProfile(),
                            child: Center(
                              child: Text(
                                "Update",
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color.fromRGBO(0, 132, 188, 1);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
