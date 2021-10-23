import 'package:flutter/material.dart';
import 'package:flutter_netap/api/firestore_helper.dart';
import 'package:flutter_netap/model/saveschedulemodel.dart';
import 'package:flutter_netap/screens/add_schedule.dart';
import 'package:flutter_netap/screens/edit_schedual.dart';

class SchedualProvider extends ChangeNotifier {
  late SaveScheduleModel saveScheduleModel;
  TextEditingController classNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController classLocationController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController daysController = TextEditingController();

  getSchedualFromFirestore(String userId) async {
    //this.saveScheduleModel =
    //  await FirestoreHelper.firestoreHelper.getUserFromFirestore(userId);
    // notifyListeners();
  }

  setSchedualInFirestore(AddSchedule addSchedule) async {
    // print(addSchedule.toMap());
    //FirestoreHelper.firestoreHelper.saveUserInFirestore(addSchedule);
  }

  /// fill the textfields in the edit schedual page with the saveScheduleModel values
  /// then go to edit schedual page
  editSchedualNavigation() {
    classNameController.text = saveScheduleModel.className!;
    startDateController.text = saveScheduleModel.startDate!;
    endDateController.text = saveScheduleModel.endDate!;
    classLocationController.text = saveScheduleModel.classLocation!;
    startTimeController.text = saveScheduleModel.startTime!;
    endTimeController.text = saveScheduleModel.endTime!;
    daysController.text = saveScheduleModel.days as String;

    // RouteHelper.routeHelper.goToPage(EditSchedual.routeName);
  }

  /// take the new values on the textfields and change the local usermodel
  /// then update the user in the firestore based on the new values
  /// go back to home page
  editProfile() async {
    saveScheduleModel.className = classNameController.text;
    saveScheduleModel.startDate = startDateController.text;
    saveScheduleModel.endDate = endDateController.text;
    saveScheduleModel.classLocation = classLocationController.text;
    saveScheduleModel.startTime = startTimeController.text;
    saveScheduleModel.endTime = endTimeController.text;
    saveScheduleModel.days = daysController.text as List<String>?;

    //await updateSchedual();
    // RouteHelper.routeHelper.goBack();
  }
}
