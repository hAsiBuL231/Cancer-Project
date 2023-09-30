import 'package:cancer_project/Auth/AuthTree.dart';
import 'package:cancer_project/BottomNavigator.dart';
import 'package:cancer_project/Settings/EditDoctorProfile.dart';
import 'package:cancer_project/Settings/EditPatientProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Settings/GetImage.dart';
import 'Functions.dart';

//String? userEmail = FirebaseAuth.instance.currentUser?.email;
//String? userName = FirebaseAuth.instance.currentUser?.displayName;
//String? userImage = FirebaseAuth.instance.currentUser?.photoURL;

authentication(context) async {
  FirebaseAuth.instance.authStateChanges();
  FirebaseAuth.instance.idTokenChanges();
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    if (kDebugMode) {
      print('\n User is currently signed out! \n\n');
    }
    newPage(const AuthTreeWidget(), context);
  } else {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    String age = "NoData";
    String imageURL = '';
    String doctor = '';

    var querySnapshot = await FirebaseFirestore.instance.collection('user_list').doc(userEmail).get();
    var data = querySnapshot.data();
    if (data != null) {
      if (data['Age'] != null) age = data['Age'];
      if (data['imageUrl'] != null) imageURL = data['imageUrl'];
      if (data['User'] != null) doctor = data['User'];
    }

    if (kDebugMode) {
      print('\n User is Signed in as: $userEmail! \n');
      print('\n Phone Number data is: $age \n\n');
    }

    snackBar('Signed in as: $userEmail!', context);

    if (imageURL == '') {
      newPage(const GetImage(), context);
    } else if (age == "NoData") {
      if (doctor == "Doctor") {
        newPage(const EditDoctorProfile(), context);
      } else {
        newPage(const EditPatientProfile(), context);
      }
    } else {
      newPage(const BottomNavigatorWidget(), context);
    }
  }

  return;
}

createUserDatabase(_userEmail, _userName, bool _doctor) async {
  await FirebaseAuth.instance.currentUser!.updateDisplayName("$_userName");
  await FirebaseFirestore.instance.collection('user_list').doc(_userEmail).set({
    'User Name': _userName,
    'User': _doctor ? "Doctor" : "Patient",
  }).onError((error, stackTrace) {
    SnackBar(content: Text('Error: $error'));
  });
}
/*
_getImage() {
  String image = '';
  FirebaseFirestore.instance.collection('user_list').doc(widget.email).snapshots().map((event) {
    setState(() {
      image = event.data()!['imageUrl'];
    });
  });
  return image;
}
*/
/*String getUsername(String email) {
  FirebaseFirestore.instance.collection('users').doc(email).snapshots().map((event) {
    var data = event.data();
    email = data!['name'];
    return email;
  });

  FirebaseFirestore.instance.collection('users').doc(email).get().then((document) {
    var data = document.data();
    email = data!['name'];
    return email;
  });
  return 'No User';
}*/
/*
addScore(int score) async {
  var userEmail = FirebaseAuth.instance.currentUser?.email;
  CollectionReference scores =
      FirebaseFirestore.instance.collection('user_list').doc(userEmail).collection('scores');
  await scores
      .doc()
      .set({
        'time': DateTime.now(),
        'score': score,
        'level': gLevel,
        'mode': gMode,
        'system': gSystem,
      })
      .then((value) => const SnackBar(content: Text('Score added')))
      .catchError((error) => SnackBar(content: Text('Error: $error')));
}*/

/*getUserName(String email) {
  String name = 'Something went wrong';
  FirebaseFirestore.instance
      .collection('user_list')
      .doc(email)
      .snapshots()
      .map((document) {
    Map<String, dynamic>? data = document.data();
    name = data?['name'];
  });
  return name;
}*/

/*Future<void> getHighestScore() async {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('scores');
  // Get docs from collection reference
  QuerySnapshot querySnapshot =
      await _collectionRef.where(FieldPath(['$userEmail'])).get();
  // Get data from docs and convert map to List
  querySnapshot.docs.map((DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // Assign the value of the 'score' field to the 'highestScore' variable
    highestScore = data['score'] as int;
  });
}*/

/*Future<void> addHeightsScore(int score) async {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  if (score > GameScoresState().highestScore) {
    String? userName = FirebaseAuth.instance.currentUser?.displayName;
    CollectionReference scores =
        FirebaseFirestore.instance.collection('scores');
    await scores
        .doc('$userEmail')
        .set({
          'player': userName.toString(),
          'score': score,
        })
        .then((value) => const SnackBar(content: Text('Score added')))
        .catchError((error) => SnackBar(content: Text('Error: $error')));
  }
}*/

/*String name = "NoData";
_getName(String value) async {
  var querySnapshot =
      await FirebaseFirestore.instance.collection('user_list').doc(value).get();
  var data = querySnapshot.data();
  if (data != null) name = data['name'];
}*/
