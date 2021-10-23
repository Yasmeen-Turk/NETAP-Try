import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netap/api/firebase_api.dart';
import 'package:flutter_netap/page/home_page.dart';
import 'package:flutter_netap/widgets/button_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class SubmitFileScreen extends StatefulWidget {
  @override
  _SubmitFileScreenState createState() => _SubmitFileScreenState();
}

class _SubmitFileScreenState extends State<SubmitFileScreen> {
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        title: Text("Absence Excuse"),
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
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8),
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
              Text(
                  "Make sure the excuse include (Your full Name, and the date of absence)"),
              SizedBox(height: 20),
              ButtonWidget(
                text: 'Select File',
                icon: Icons.attach_file,
                onClicked: selectFile,
              ),
              SizedBox(height: 10),
              Text(
                fileName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 48),
              ButtonWidget(
                text: 'Submit',
                icon: Icons.send,
                onClicked: uploadFile,
              ),
              SizedBox(height: 20),
              task != null ? buildUploadStatus(task!) : Container(),
              SizedBox(height: 48),
              ButtonWidget(
                text: 'Cancel',
                icon: Icons.cancel,
                onClicked: uploadFile,
              ),
              SizedBox(height: 8),
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

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Future cancle() async {}

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              "your download " + '$percentage %' + "ready",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
