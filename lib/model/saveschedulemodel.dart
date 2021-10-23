import 'package:cloud_firestore/cloud_firestore.dart';

class SaveScheduleModel {
  String? id;
  String? className;
  String? startDate;
  String? endDate;
  String? classLocation;
  String? startTime;
  String? endTime;
  List<String>? days;
  SaveScheduleModel(
      {this.className,
      this.startDate,
      this.endDate,
      this.classLocation,
      this.days,
      this.startTime,
      this.endTime});

  SaveScheduleModel.fromMap(Map map) {
    this.id = map['id'];
    this.className = map['className'];
    this.startDate = map['startDate'];
    this.endDate = map['endDate'];
    this.classLocation = map['classLocation'];
    this.days = map['days'];
    this.startTime = map['startTime'];
    this.endTime = map['endTime'];
  }

  toMap() {
    return {
      'id': this.id,
      'className': this.className,
      'startDate': this.startDate,
      'endDate': this.endDate,
      'classLocation': this.classLocation,
      'days': this.days,
      'startTime': this.startTime,
      'endTime': this.endTime
    };
  }
}
