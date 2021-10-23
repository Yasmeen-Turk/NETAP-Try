import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netap/backend/server.dart';
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

//firebase
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

// @override
// Widget build(BuildContext context) {
//   return StreamBuilder(
//     stream: FirebaseFirestore.instance.collection('mySched').snapshots(),
//     builder: (BuildContext context,
//         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//       if (!snapshot.hasData) return Text('Loading...');
//       switch (snapshot.connectionState) {
//         case ConnectionState.waiting:
//           return new Text('Loading ...');
//         default:
//           return ListView(
//             children: snapshot.data!.docs
//                 .map((DocumentSnapshot) => new ListTile())
//                 .toList(),
//           );
//       }
//     },
//   );
// }
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
