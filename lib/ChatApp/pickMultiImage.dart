import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
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
    List<String> fileUrls = [];
    super.dispose();
  }

  /////////////////////////////////////////////////////////////// Single Image /////////////////////////////////////////////////////////////////////////////////////////

  final userEmail = FirebaseAuth.instance.currentUser?.email;


  Future _getCameraImage() async {
    List<String> imageUrls = [];

    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String imageUrl = await _uploadFileToFirebase(imageFile, pickedFile.name, 'images');
      imageUrls.add(imageUrl);
    }
    _storeFileUrlsInFirestore(imageUrls, 'images');
  }

  //////////////////////////////////////////////////////////////// Multiple Image /////////////////////////////////////////////////////////////////////////////////////////

  Future<void> _pickImages() async {
    List<String> imageUrls = [];

    final picker = ImagePicker();
    List<XFile>? pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      for (var file in pickedFiles) {
        File imageFile = File(file.path);
        String imageUrl = await _uploadFileToFirebase(imageFile, file.name, 'images');
        setState(() {
          imageUrls.add(imageUrl);
        });
      }
      _storeFileUrlsInFirestore(imageUrls, 'images');
    }
  }

  /*
  Future<String> _uploadImageToFirebase(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = FirebaseStorage.instance.ref().child('$userEmail/messages/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _urlMessage() async {
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
*/
  //////////////////////////////////////////////////////////////// Multiple Files /////////////////////////////////////////////////////////////////////////////////////////////
  //List<String> fileUrls = [];

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<String> uploadedUrls = [];

      for (PlatformFile file in result.files) {
        File fileToUpload = File(file.path!);
        String fileUrl = await _uploadFileToFirebase(fileToUpload, file.name, 'files');
        uploadedUrls.add(fileUrl);
      }

      await _storeFileUrlsInFirestore(uploadedUrls, 'files');

      /*setState(() {
        fileUrls.addAll(uploadedUrls);
      });*/
    }
  }

  /////////////////////////////////////////////////////////////// Firebase Functions ///////////////////////////////////////////////////////////////////////////////////////////////

  Future<String> _uploadFileToFirebase(File file, String fileName, String fileType) async {
    Reference storageReference = FirebaseStorage.instance.ref().child('Message/$fileType/$userEmail/$fileName');
    UploadTask uploadTask = storageReference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _storeFileUrlsInFirestore(List<String> fileUrls, String fileType) async {
    var user1inbox =
        FirebaseFirestore.instance.collection('user_list').doc(userEmail).collection('inbox').doc(widget.email);
    var user2inbox =
        FirebaseFirestore.instance.collection('user_list').doc(widget.email).collection('inbox').doc(userEmail);

    await user1inbox.collection('messages').add({
      "file type": fileType,
      "list": fileUrls,
      "type": 'send',
      "time": DateTime.now(),
    }).then((value) => user1inbox.set({
          "last_message": 'Sent files',
          "last_time": DateTime.now(),
        }));

    var docRef = user1inbox.collection('messages').orderBy("time", descending: true).limit(1);
    //FirebaseFirestore.instance.collection("data").snapshots().last
    var docSnap = await docRef.get();
    var docId = docSnap.docs[0].id;

    await user2inbox.collection('messages').doc(docId).set({
      "file type": fileType,
      "list": fileUrls,
      "type": 'receive',
      "time": DateTime.now(),
    }).then((value) => user2inbox.set({
          "last_message": 'Sent files',
          "last_time": DateTime.now(),
        }));
  }

  ////////////////////////////////////////////////////////////// Widget ///////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.add, color: Colors.white, size: 25),
      itemBuilder: (context) => [
        const PopupMenuItem(
            value: 1, child: Row(children: [Icon(Icons.photo), SizedBox(width: 10), Text("Photo")])),
        const PopupMenuItem(
            value: 2, child: Row(children: [Icon(Icons.photo_camera), SizedBox(width: 10), Text("Camera")])),
        const PopupMenuItem(
            value: 3, child: Row(children: [Icon(Icons.file_copy), SizedBox(width: 10), Text("Files")])),
      ],
      offset: const Offset(0, 100),
      //color: Colors.grey,
      elevation: 2,
      onSelected: (value) {
        if (value == 1) {
          _pickImages();
        } else if (value == 2) {
          _getCameraImage();
        } else if (value == 3) {
          _pickFiles();
        }
      },
    );
  }
}
