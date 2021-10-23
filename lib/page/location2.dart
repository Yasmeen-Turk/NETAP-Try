import 'package:flutter/material.dart';
import 'package:flutter_netap/page/checkout_page.dart';
import 'package:flutter_netap/page/home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Home2 extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home2> {
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
          MaterialPageRoute(builder: (context) => CheckoutScreens()),
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
        children: [
          Text("latitude:  $latitude"),
          Text("longitude: $longitude"),
          Icon(
            Icons.location_on,
            size: 45.0,
            color: Color.fromRGBO(0, 132, 188, 1),
          ),
          SizedBox(
            height: 20.0,
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
              ))
        ],
      )),
    );
  }
}
