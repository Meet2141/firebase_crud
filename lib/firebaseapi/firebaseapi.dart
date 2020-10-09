import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/common/common.dart';

class FireBaseApi {
  Firestore db = Firestore.instance;

  Future<void> addSubUser(
      String phone, String address, String pinCode, String uid) async {
    await db
        .collection(Common.user)
        .document(uid)
        .collection(Common.subuser)
        .add({
      'phone': phone,
      'address': address,
      'pinCode': pinCode,
    }).then((documentReference) {
      Common.contactAddedToast('Contact Added');
    }).catchError((e) {
      print(e);
    });
  }
}
