import 'package:flutter/material.dart';

class LifestylePage extends StatefulWidget {
  const LifestylePage({super.key});

  @override
  State<LifestylePage> createState() => _LifestylePageState();
}

class _LifestylePageState extends State<LifestylePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Cancer Lifestyle")),
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Maintain a Healthy Weight"),
              )),
              Card(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Exercise Regularly"),
              )),
              Card(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Don't Smoke"),
              )),
              Card(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Eat a Healthy Diet"),
              )),
              Card(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Get Screening Test"),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
