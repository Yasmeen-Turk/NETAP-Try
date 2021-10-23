import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_netap/model/saveschedulemodel.dart';
import 'package:flutter_netap/screens/add_schedule.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  saveSchedualInFirestore(SaveScheduleModel saveScheduleModel) async {
    firestore
        .collection('mySched')
        .doc(saveScheduleModel.id)
        .set(saveScheduleModel.toMap());
  }

  Future<SaveScheduleModel> getUserFromFirestore(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await firestore.collection('mySched').doc(userId).get();
    Map<String, dynamic>? map = document.data();
    print(map);
    SaveScheduleModel saveScheduleModel = SaveScheduleModel.fromMap(map!);
    print(saveScheduleModel.toMap());
    return saveScheduleModel;
  }

  updateUserFromFirestore(SaveScheduleModel saveScheduleModel) async {
    firestore
        .collection('mySched')
        .doc(saveScheduleModel.id)
        .update(saveScheduleModel.toMap());
  }

  deleteSchedualFromFirestore(SaveScheduleModel saveScheduleModel) async {
    firestore.collection('mySched').doc(saveScheduleModel.id).delete();
  }
}
