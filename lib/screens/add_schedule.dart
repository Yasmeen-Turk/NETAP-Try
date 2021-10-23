import 'dart:ui';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_netap/backend/server.dart';
import 'package:flutter_netap/model/saveschedulemodel.dart';
import 'package:flutter_netap/widgets/custom_text_field.dart';
import 'package:flutter_netap/widgets/days_widget.dart';
import 'package:flutter_netap/screens/instructor_home.dart';
import 'package:get/get.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key}) : super(key: key);

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  GlobalKey<FormState> saveFormkey = GlobalKey<FormState>();
  TextEditingController courseTitle = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController courseLocation = TextEditingController();
  bool sun = true;
  bool mon = false;
  bool tus = false;
  bool wed = false;
  bool thr = false;
  bool selectedWeek = true;
  SaveScheduleModel? saveScheduleModel;

  saveForm() async {
    if (saveFormkey.currentState!.validate()) {
      if (!(sun || mon || tus || wed || thr)) {
        setState(() {
          selectedWeek = false;
        });
      } else {
        setState(() {
          selectedWeek = true;
        });
        saveScheduleModel = SaveScheduleModel(
          className: courseTitle.text,
          startDate: startDate.text,
          endDate: endDate.text,
          startTime: startTime.text,
          endTime: endTime.text,
          classLocation: courseLocation.text,
          days: [
            sun ? "Sunday" : '',
            mon ? "Monday" : '',
            tus ? "Tuesday" : '',
            wed ? "Wednesday" : '',
            thr ? "Thursday" : '',
          ],
        );
        bool done = await addSchedToFirebase(saveScheduleModel!.toMap());
        if (done) {
          print('done');
          showSuccess();
        } else {
          print('error');
        }
      }
    }
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
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => InstructorHomePage()));
          },
        ),
        title: Text('Add Schedule '),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 132, 188, 1),
      ),
      body: Form(
        key: saveFormkey,
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
              SizedBox(height: 40),
              Text(" fill these to add to your schedule"),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextFormField(
                    autofocus: false,
                    controller: courseTitle,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return (" Course Title cannot be Empty");
                      }
                    },
                    onSaved: (value) {
                      courseTitle.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.subject,
                        color: Color.fromRGBO(0, 132, 188, 1),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Course Title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
              ),
              SizedBox(
                height: 16,
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
                        labelText: 'Start Date',
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
                        startDate.text = value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: DateTimePicker(
                      decoration: InputDecoration(
                        labelText: 'Start Time',
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
                        startTime.text = value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 16,
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
                        labelText: 'End Date',
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
                        } else if (DateTime.parse(startDate.text)
                                .difference(DateTime.parse(value))
                                .inDays >
                            0) {
                          return ("cannot be past than start");
                        }
                      },
                      onChanged: (value) {
                        endDate.text = value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: DateTimePicker(
                      type: DateTimePickerType.time,
                      decoration: InputDecoration(
                        labelText: 'End Time',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      initialValue: '',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return (" cannot be Empty");
                        } else if (startDate.text == endDate.text) {
                          if (int.parse(startTime.text.split(":")[0]) * 60 +
                                  int.parse(startTime.text.split(":")[1]) >
                              int.parse(endTime.text.split(":")[0]) * 60 +
                                  int.parse(endTime.text.split(":")[1])) {
                            return ("cannot be past than start");
                          }
                        }
                      },
                      onChanged: (value) {
                        endTime.text = value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextFormField(
                    autofocus: false,
                    controller: courseLocation,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return (" course Location cannot be Empty");
                      }
                    },
                    onSaved: (value) {
                      courseLocation.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.pin_drop,
                        color: Color.fromRGBO(0, 132, 188, 1),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Location",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: DaysWidget(
                      label: 'Sunday',
                      value: sun,
                      onChanged: (v) {
                        sun = v;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: DaysWidget(
                      label: 'Monday',
                      value: mon,
                      onChanged: (v) {
                        mon = v;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: DaysWidget(
                      label: 'Tuesday',
                      value: tus,
                      onChanged: (v) {
                        tus = v;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: DaysWidget(
                      label: 'Wednesday',
                      value: wed,
                      onChanged: (v) {
                        wed = v;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: DaysWidget(
                      label: 'Thursday',
                      value: thr,
                      onChanged: (v) {
                        thr = v;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              selectedWeek
                  ? Container()
                  : Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.centerLeft,
                      child: Text("please select weekday",
                          style: TextStyle(color: Colors.red, fontSize: 12)),
                    ),
              SizedBox(
                height: 10,
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
                      'Add',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InstructorHomePage()));
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
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showSuccess() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Success"),
          content: new Text("Schedule was added"),
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
}
