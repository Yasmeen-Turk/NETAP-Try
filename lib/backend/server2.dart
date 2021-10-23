import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<bool> permissionToFirebase(Map? map) async {
  try {
    print('before');
    await firestore.collection('permission').doc().set(map!.cast());
    print('after');
  } on Exception catch (e) {
    print(e);
  }

  return true;
}
