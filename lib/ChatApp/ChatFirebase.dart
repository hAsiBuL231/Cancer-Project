import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

sendMessage(email, msg) async {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  var user1inbox =
  FirebaseFirestore.instance.collection('user_list').doc(userEmail).collection('inbox').doc(email);
  var user2inbox =
  FirebaseFirestore.instance.collection('user_list').doc(email).collection('inbox').doc(userEmail);

  await user1inbox.collection('messages').add({
    //"url": '',
    "message": msg,
    "type": 'send',
    "time": DateTime.now(),
  }).then((value) => user1inbox.set({
    "last_message": msg,
    "last_time": DateTime.now(),
  }));

  var doc_ref = user1inbox.collection('messages').orderBy("time", descending: true).limit(1);
  //FirebaseFirestore.instance.collection("data").snapshots().last
  var docSnap = await doc_ref.get();
  var doc_id = docSnap.docs[0].id;

  await user2inbox.collection('messages').doc(doc_id).set({
    //"url": '',
    "message": msg,
    "type": 'receive',
    "time": DateTime.now(),
  }).then((value) => user2inbox.set({
    "last_message": msg,
    "last_time": DateTime.now(),
  }));
}
