import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<bool> addSchedToFirebase(Map? map) async {
  try {
    print('before');
    await firestore.collection('mySched').doc().set(map!.cast());
    print('after');
  } on Exception catch (e) {
    print(e);
  }

  return true;
}
