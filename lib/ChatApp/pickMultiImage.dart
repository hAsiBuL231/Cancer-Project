import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key, required this.email});
  final String email;

  @override
  ImagePickerScreenState createState() => ImagePickerScreenState();
}

class ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    List<String> imageUrls = [];
    super.dispose();
  }

  final userEmail = FirebaseAuth.instance.currentUser?.email;

  List<String> imageUrls = [];

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String imageUrl = await uploadImageToFirebase(imageFile);
      imageUrls.add(imageUrl);
    }
    urlMessage();
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    List<XFile>? pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      for (var file in pickedFiles) {
        File imageFile = File(file.path);
        String imageUrl = await uploadImageToFirebase(imageFile);
        setState(() {
          imageUrls.add(imageUrl);
        });
      }
    }
    urlMessage();
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = FirebaseStorage.instance.ref().child('$userEmail/messages/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  urlMessage() async {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    var user1inbox =
        FirebaseFirestore.instance.collection('user_list').doc(userEmail).collection('inbox').doc(widget.email);
    var user2inbox =
        FirebaseFirestore.instance.collection('user_list').doc(widget.email).collection('inbox').doc(userEmail);

    await user1inbox.collection('messages').add({
      "url": 'image',
      "list": imageUrls,
      "type": 'send',
      "time": DateTime.now(),
    }).then((value) => user1inbox.set({
          "last_message": 'Sent photos',
          "last_time": DateTime.now(),
        }));

    var docRef = user1inbox.collection('messages').orderBy("time", descending: true).limit(1);
    //FirebaseFirestore.instance.collection("data").snapshots().last
    var docSnap = await docRef.get();
    var docId = docSnap.docs[0].id;

    await user2inbox.collection('messages').doc(docId).set({
      "url": 'image',
      "list": imageUrls,
      "type": 'receive',
      "time": DateTime.now(),
    }).then((value) => user2inbox.set({
          "last_message": 'Sent photos',
          "last_time": DateTime.now(),
        }));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.add, color: Colors.white, size: 25),
      itemBuilder: (context) => [
        const PopupMenuItem(
            value: 1, child: Row(children: [Icon(Icons.photo), SizedBox(width: 10), Text("Photo")])),
        const PopupMenuItem(
            value: 2, child: Row(children: [Icon(Icons.photo_camera), SizedBox(width: 10), Text("Camera")])),
      ],
      offset: const Offset(0, 100),
      //color: Colors.grey,
      elevation: 2,
      onSelected: (value) {
        if (value == 1) {
          pickImages();
        } else if (value == 2) {
          getImage();
        }
      },
    );
  }
}

/*
Expanded(
            child: ListView.builder(
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Image.network(imageUrls[index]),
                );
              },
            ),
          ),
 */
