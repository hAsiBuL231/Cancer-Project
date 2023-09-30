import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../All Functions Page/Functions.dart';

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

class DeleteUser extends StatelessWidget {
  final String user;
  const DeleteUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.account_circle, color: Colors.blue, size: 50),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Delete conversation!'),
      content: const Text('Are you sure to delete this conversation?'),
      actions: [
        ElevatedButton(
            onPressed: () {
              String? userEmail = FirebaseAuth.instance.currentUser?.email;
              FirebaseFirestore.instance
                  .collection('user_list')
                  .doc(userEmail)
                  .collection('inbox')
                  .doc(user)
                  .delete()
                  .then((value) => snackBar('Conversation is deleted.', context));
            },
            child: const Text('Yes')),
        ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
      ],
    );
  }
}

class DeleteMessage extends StatelessWidget {
  final String user;
  final String id;
  const DeleteMessage({super.key, required this.user, required this.id});

  @override
  Widget build(BuildContext context) {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    var user1inbox = FirebaseFirestore.instance
        .collection('user_list')
        .doc(userEmail)
        .collection('inbox')
        .doc(user)
        .collection('messages')
        .doc(id);
    var user2inbox = FirebaseFirestore.instance
        .collection('user_list')
        .doc(user)
        .collection('inbox')
        .doc(userEmail)
        .collection('messages')
        .doc(id);

    return AlertDialog(
      icon: const Icon(Icons.dangerous_outlined, color: Colors.blue, size: 50),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Are you sure?'),
      content: const Text('This will delete this message!'),
      actions: [
        ElevatedButton(
            onPressed: () {
              /*user1inbox.get().then((value) => (value) async {
                    String url = value.data['url'];
                    print(" \n $url \n ");
                    await FirebaseStorage.instance
                        .ref(url)
                        .delete()
                        .then((value) => print(' \n success \n '));
                  });*/
              user1inbox.delete();
              user2inbox.delete().then((value) {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(title: const Text('Message is deleted!'), actions: [
                          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Ok'))
                        ]));
              });
            },
            child: const Text('Unsent Message')),
        ElevatedButton(
            onPressed: () {
              user1inbox.delete().then((value) {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(title: const Text('Message deleted!'), actions: [
                          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Ok'))
                        ]));
              });
            },
            child: const Text('Delete from you only')),
        ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
      ],
    );
  }
}
