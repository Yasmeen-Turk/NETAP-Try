import 'package:flutter/material.dart';
import 'package:flutter_netap/page/home_page.dart';

class CheckInSuccess extends StatefulWidget {
  const CheckInSuccess({Key? key}) : super(key: key);

  @override
  _CheckInSuccessState createState() => _CheckInSuccessState();
}

class _CheckInSuccessState extends State<CheckInSuccess> {
  TextEditingController sampledata1 = new TextEditingController();
  TextEditingController sampledata2 = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CheckIn-Success"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 132, 188, 1),
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
            height: 150.0,
          ),
          Text(
            "You have Checked-In Successfully",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 132, 188, 1),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(150.1, 40.0),
              primary: Color.fromRGBO(0, 132, 188, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  new MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text(
              "Home Page",
              style: TextStyle(
                fontSize: 19,
                color: Colors.white,
                //fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(
            height: 210.0,
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
      )),
    );
  }
}
