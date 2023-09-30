import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ChatFunctions.dart';
import '../All Functions Page/Functions.dart';
import 'ConversationPage.dart';

class conversationListTile extends StatefulWidget {
  final String email;
  final String messageText;
  final Timestamp time;
  const conversationListTile({super.key, required this.messageText, required this.time, required this.email});
  @override
  conversationListTileState createState() => conversationListTileState();
}

class conversationListTileState extends State<conversationListTile> {
  String image = '';

  @override
  Widget build(BuildContext context) {
    //String image = _getImage().toString();
    /*FirebaseFirestore.instance.collection('user_list').doc(widget.email).get().then((value) {
      Map<String, dynamic>? data = value.data();
      setState(() {
        image = data!['imageUrl'];
      });
    });*/
    //_getImage();
    int msgl1 = widget.messageText.length;
    int msgl2 = msgl1 > 25 ? 25 : msgl1;

    return GestureDetector(
        onLongPress: () => showDialog(context: context, builder: (context) => DeleteUser(user: widget.email)),
        onTap: () => nextPage(ConversationPage(email: widget.email, imageUrl: image), context),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
          //margin: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
          child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white38),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('user_list').doc(widget.email).snapshots(),
                  builder: (context, snapshot) {
                    String image = 'image';
                    String name = 'Name';
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      var data = snapshot.data!.data();
                      image = data!['imageUrl'];
                      name = data['User Name'];
                    }
                    return Row(
                      children: [
                        CachedNetworkImage(
                            imageUrl: image,
                            imageBuilder: (context, imageProvider) => CircleAvatar(
                                backgroundImage: imageProvider, maxRadius: 25, backgroundColor: Colors.blue),
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const CircleAvatar(
                                maxRadius: 25,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.account_circle, size: 50))),
                        const SizedBox(width: 16),
                        Expanded(
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                            const SizedBox(height: 6),
                            Text(widget.messageText.replaceRange(msgl2, msgl1, '...'),
                                style: const TextStyle(fontSize: 13, color: Colors.grey)),
                          ]),
                          Text(timeFormat(widget.time), style: const TextStyle(fontSize: 12)),
                        ]))
                      ],
                    );
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(image),
                      backgroundColor: Colors.blue,
                      maxRadius: 25,
                    );
                  })),
        ));
  }
}

timeFormat(Timestamp time) {
  DateTime now = time.toDate();
  String convertedTime = "${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";
  String convertedDate =
      "${now.year.toString()}/${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}";
  String convertedDateTime = "$convertedTime\n$convertedDate";
  return convertedDateTime;
}
