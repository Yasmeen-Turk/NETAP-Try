import 'package:flutter/material.dart';

import 'home_page.dart';

class Success2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Success"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(32),
          child: Center(
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
                Text(
                  'You have checked-out succesfully',
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(height: 48),
                buildLogoutButton(context)
              ],
            ),
          ),
        ),
      );

  Widget buildLogoutButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        child: Text(
          'Home',
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        ),
      );
}
