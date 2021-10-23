import 'package:flutter/material.dart';
import 'package:flutter_netap/page/checkin_page.dart';
import 'package:flutter_netap/page/home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double latitude = 0.0;
  double longitude = 0.0;

  String locationMessage = "Location Data";
  getUserLocation() async {
    Position position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    setState(() {
      if (position.latitude >= 24.72 && position.longitude >= 46.61) {
        // if (position.latitude>0) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CheckinScreens()),
        );
      } else {
        locationMessage = "Outside University";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Location'),
        centerTitle: true,
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
      body: Center(
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
          SizedBox(height: 100),
          Text("latitude:  $latitude"),
          Text("longitude: $longitude"),
          Icon(
            Icons.location_on,
            size: 45.0,
            color: Color.fromRGBO(0, 132, 188, 1),
          ),
          SizedBox(
            height: 40.0,
          ),
          Text(
            "Verify Your Location",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 132, 188, 1),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100.1, 40.0),
                primary: Color.fromRGBO(0, 132, 188, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                getUserLocation();
              },
              child: Text(
                "Get Location",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 170.0,
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
