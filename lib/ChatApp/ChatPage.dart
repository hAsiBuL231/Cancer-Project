import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AddUser.dart';
import 'ShowConversationList.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                        const Text("Conversations", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                        GestureDetector(
                            onTap: () => showDialog(context: context, builder: (context) => const AddUser()),
                            child: Container(
                                padding: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                                height: 30,
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.pink[50]),
                                child: const Row(children: <Widget>[
                                  Icon(Icons.add, color: Colors.pink, size: 20),
                                  SizedBox(width: 2),
                                  Text("All Users", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                                ])))
                      ]))),
              Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.all(8),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.grey.shade100))))),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('user_list')
                      .doc(userEmail)
                      .collection('inbox')
                      .orderBy('last_time', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.length < 1) {
                        return const Padding(
                            padding: EdgeInsets.all(40),
                            child: Center(child: Text('No User!', style: TextStyle(fontSize: 20))));
                      }
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 16),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            String email = snapshot.data.docs[index].id;
                            if ('$email' == '$userEmail') return SizedBox.shrink();
                            return ShowConversationList(
                              email: email,
                              messageText: snapshot.data.docs[index]['last_message'],
                              time: snapshot.data.docs[index]['last_time'],
                            );
                          });
                    }
                    return const Padding(
                        padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator()));
                  })
            ])));
  }
}

/*_name(String email) async {
  String name = 'No data';
  await FirebaseFirestore.instance
      .collection('user_list')
      .doc(email)
      .get()
      .then((value) {
    Map<String, dynamic>? data = value.data();
    name = data!['name'];
    return name;
  });
  return name = 'Wrong';
}
*/
/*String name = "NoData";
_getName(String value) async {
  var querySnapshot =
      await FirebaseFirestore.instance.collection('user_list').doc(value).get();
  var data = querySnapshot.data();
  if (data != null) name = data['name'];
}*/
