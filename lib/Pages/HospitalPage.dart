import 'package:flutter/material.dart';

class HospitalPageWidget extends StatelessWidget {
  const HospitalPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          foregroundColor: Colors.black,
          title: RichText(
              softWrap: true,
              text: const TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'Hospital',
                    style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: 'Page',
                    style: TextStyle(fontSize: 24, color: Color(0xFF016DF7), fontWeight: FontWeight.bold))
              ]))),
      body: Center(
        child: RichText(
            softWrap: true,
            text: const TextSpan(children: <TextSpan>[
              TextSpan(
                  text: 'Coming',
                  style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: ' Soon',
                  style: TextStyle(fontSize: 24, color: Color(0xFF016DF7), fontWeight: FontWeight.bold))
            ])),
      ),
    );
  }
}
