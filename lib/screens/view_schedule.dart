import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
//import 'package:flutter_netap/page/checkin_page.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'instructor_home.dart';
import 'package:flutter_netap/model/saveschedulemodel.dart';

class ViewSchedulePage extends StatefulWidget {
  //final String title;
  @override
  ViewSheduleState createState() => ViewSheduleState();
}

class ViewSheduleState extends State<ViewSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.week,
      firstDayOfWeek: 6,
      //initialDisplayDate: DateTime(2021, 03, 01, 08, 30),
      //initialSelectedDate: DateTime(2021, 03, 01, 08, 30),
      dataSource: MeetingDataSource(getAppointments()),
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Board Meeting',
      color: Colors.blue,
      recurrenceRule: 'FREQ=DAILY;COUNT=10',
      isAllDay: false));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class LoadDataFromFirebase extends StatefulWidget {
  @override
  _LoadDataFromFirebaseState createState() => _LoadDataFromFirebaseState();
}

class _LoadDataFromFirebaseState extends State<LoadDataFromFirebase> {
  List<Color> _colorCollection = <Color>[];
  MeetingDataSource? events;
  final List<String> options = <String>["Update", "Delete"];
  final databaseReference = FirebaseFirestore.instance;
  @override
  void initState() {
    _initializeEventColor();
    getDataFromFirestore().then((results) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    // TODO: implement initState
    super.initState();
  }

  Future<void> getDataFromFirestore() async {
    var snapshotsValue = await databaseReference.collection("mySched").get();
    final Random random = new Random();
    List<Meeting> list = snapshotsValue.docs
        .map((e) => Meeting(
            eventName: e.data()['Subject'],
            from:
                DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['StartTime']),
            to: DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['EndTime']),
            background: _colorCollection[random.nextInt(9)],
            isAllDay: false))
        .toList();

    setState(() {
      events = MeetingDataSource(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/*
class ViewSheduleState extends State<ViewSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('instructor schedule'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 132, 188, 1),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (context) => InstructorHomePage()));
          },
        ),
      ),
      body: SfCalendar(
        view: CalendarView.workWeek,
        timeSlotViewSettings: TimeSlotViewSettings(
          startHour: 7,
          endHour: 3,
          nonWorkingDays: <int>[
            DateTime.saturday,
            DateTime.friday,
          ],
          timeInterval: Duration(minutes: 60),
          timeIntervalHeight: 80,
          //timeFormat: 'h:MM',
          //dateFormat: 'd',
          //dayFormat: 'EEE',
          timeRulerSize: 60,
          allDayPanelColor: Color.fromRGBO(0, 132, 188, 1),
        ),
        dataSource: MeetingDataSource(getAppointments()),
      ),
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Metting',
      color: Color.fromRGBO(0, 132, 188, 1),
      recurrenceRule: 'FREQ=DAILY;COUNT=10',
      isAllDay: false));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
*/
