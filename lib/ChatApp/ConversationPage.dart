import 'package:cached_network_image/cached_network_image.dart';
import 'package:cancer_project/All%20Functions%20Page/Functions.dart';
import 'package:cancer_project/ChatApp/UsersProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ChatFunctions.dart';

import 'PhotoUpload.dart';

class ConversationPage extends StatefulWidget {
  final String imageUrl;
  final String email;
  const ConversationPage({super.key, required this.email, required this.imageUrl});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  //ScrollController _scrollController = ScrollController();
  TextEditingController message = TextEditingController();
  String ReceiverName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          foregroundColor: Colors.black,
          flexibleSpace: SafeArea(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('user_list').doc(widget.email).snapshots(),
                builder: (context, snapshot) {
                  String name = 'Name';
                  String image = 'image';
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    var data = snapshot.data!.data();
                    name = data!['User Name'];
                    ReceiverName = '$name💥';
                    image = data['imageUrl'];
                  }

                  return Row(children: <Widget>[
                    const SizedBox(width: 5),
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.black)),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Row(children: [
                        CachedNetworkImage(
                            imageUrl: image,
                            imageBuilder: (context, imageProvider) => CircleAvatar(
                                backgroundImage: imageProvider, maxRadius: 25, backgroundColor: Colors.blue),
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const CircleAvatar(
                                maxRadius: 25,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.account_circle, size: 50))),
                        const SizedBox(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                              const SizedBox(height: 6),
                              const Text("Online", style: TextStyle(fontSize: 13)),
                            ])
                      ]),
                    ),
                    const SizedBox(width: 12),
                    PopupMenuButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        icon: const Icon(Icons.settings, color: Colors.black54),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  onTap: () => nextPage(UsersProfile(widget.email), context),
                                  child: const Row(children: [
                                    Icon(Icons.account_circle_outlined, color: Colors.black),
                                    SizedBox(width: 6),
                                    Text('Show Profile')
                                  ])),
                              PopupMenuItem(
                                  onTap: () => showDialog(
                                      context: context, builder: (context) => DeleteUser(user: widget.email)),
                                  child: const Row(children: [
                                    Icon(Icons.delete, color: Colors.black),
                                    SizedBox(width: 6),
                                    Text('Delete Chat')
                                  ]))
                            ]),
                    const SizedBox(width: 16),
                  ]);
                }),
          ),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('user_list')
                    .doc(userEmail)
                    .collection('inbox')
                    .doc(widget.email)
                    .collection('messages')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length < 1) {
                      return const Center(child: Text('Say Hi!'));
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        reverse: true,
                        //controller: _scrollController,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          /*SchedulerBinding.instance.addPostFrameCallback((_) {
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 10),
                                  curve: Curves.easeOut,
                                );
                              });*/
                          String messageType = snapshot.data.docs[index]['type'];
                          String ID = snapshot.data.docs[index].id;
                          String? name = FirebaseAuth.instance.currentUser!.displayName;
                          String SenderName = '$name🔥';
                          late String image;
                          try {
                            image = snapshot.data.docs[index]['url'];
                          } on StateError catch (e) {
                            image = '';
                          }
                          return Padding(
                            padding: (messageType == "receive"
                                ? const EdgeInsets.fromLTRB(15, 3, 60, 3)
                                : const EdgeInsets.fromLTRB(60, 3, 15, 3)),
                            //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            child: Column(
                                crossAxisAlignment:
                                    messageType == "receive" ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                      //padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(messageType == "receive" ? ReceiverName : SenderName,
                                          style: const TextStyle(
                                              fontSize: 10, fontFamily: 'Poppins', color: Colors.black87))),
                                  GestureDetector(
                                      onLongPress: () => showDialog(
                                          context: context,
                                          builder: (context) => DeleteMessage(user: widget.email, id: ID)),
                                      child: Align(
                                          alignment:
                                              (messageType == "receive" ? Alignment.topLeft : Alignment.topRight),
                                          child: Material(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: const Radius.circular(20),
                                                  topLeft: messageType == "receive"
                                                      ? const Radius.circular(2)
                                                      : const Radius.circular(20),
                                                  bottomRight: const Radius.circular(20),
                                                  topRight: messageType == "receive"
                                                      ? const Radius.circular(20)
                                                      : const Radius.circular(2)),
                                              color: (messageType == "receive" ? Colors.white : Colors.blue),
                                              elevation: 5,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                                                child: Builder(builder: (context) {
                                                  //if (image != '')
                                                  return CachedNetworkImage(
                                                      imageBuilder: (context, imageProvider) => Image(
                                                          height: 180,
                                                          width: 180,
                                                          image: CachedNetworkImageProvider(image)),
                                                      imageUrl: image,
                                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                          CircularProgressIndicator(
                                                              value: downloadProgress.progress),
                                                      errorWidget: (context, url, error) => Text(
                                                          snapshot.data.docs[index]['message'],
                                                          style: TextStyle(
                                                              color: (messageType == "receive"
                                                                  ? Colors.blue
                                                                  : Colors.white),
                                                              fontFamily: 'Poppins',
                                                              fontSize: 15)));
                                                  //Image(image: NetworkImage(snapshot.data.docs[index]['url']));
                                                  /*return Text(snapshot.data.docs[index]['message'],
                                                          style: TextStyle(
                                                              color: (messageType == "receive"
                                                                  ? Colors.blue
                                                                  : Colors.white),
                                                              fontFamily: 'Poppins',
                                                              fontSize: 15));*/
                                                }),
                                              ))))
                                ]),
                          );
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
          Align(
              //alignment: Alignment.bottomLeft,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 60,
                  width: double.infinity,
                  //color: Colors.white,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                    GestureDetector(
                        child: DecoratedBox(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.blue),
                            child: ForContext(email: widget.email))),
                    const SizedBox(width: 15),
                    Expanded(
                        child: Material(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                            elevation: 5,
                            child: TextField(
                                controller: message,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                    hintText: 'Type your message here...',
                                    hintStyle:
                                        TextStyle(fontFamily: 'Poppins', fontSize: 16, color: Colors.black54),
                                    border: InputBorder.none)))),
                    const SizedBox(width: 15),
                    FloatingActionButton(
                        onPressed: () async {
                          String msg = message.text;
                          message.clear();
                          String email = widget.email;
                          sendMessage(email, msg);
                        },
                        backgroundColor: Colors.blue,
                        elevation: 0,
                        child: const Icon(Icons.send, color: Colors.white, size: 18)),
                  ])))
        ]));
  }
}
/*Widget emojiSelect() {
  return EmojiPicker(
      rows: 4,
      columns: 7,
      onEmojiSelected: (emoji, category) {
        print(emoji);
        setState(() {
          _controller.text = _controller.text + emoji.emoji;
        });
      });
}
}*/
