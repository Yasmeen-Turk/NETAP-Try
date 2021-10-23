import 'package:cloud_firestore/cloud_firestore.dart';

class SaveScheduleModel {
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
  toMap() {
    return {
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
