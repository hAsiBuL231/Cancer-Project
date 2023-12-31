import 'package:cancer_project/Auth/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Register.dart';

class AuthTreeWidget extends StatefulWidget {
  const AuthTreeWidget({Key? key}) : super(key: key);

  @override
  _AuthTreeWidgetState createState() => _AuthTreeWidgetState();
}

class _AuthTreeWidgetState extends State<AuthTreeWidget> with TickerProviderStateMixin {
  /*@override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    // await for for the widget to mount
    await Future.delayed(const Duration(seconds: 0));
    User? user = FirebaseAuth.instance.currentUser; 
    if (user != null) {
      authentication(context);
    }
  }*/

  bool doctor = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(19, 22, 25, 100),
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * 1,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(19, 22, 25, 100),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: Image.asset(
                'Assets/black1.png',
              ).image,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Hope Image
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 60, 0, 60),
                child: Image.asset(
                  'Assets/Hope.png',
                  width: 300,
                  height: 250,
                ).animate(
                  autoPlay: true,
                  effects: [
                    FadeEffect(
                      curve: Curves.easeInOut,
                      delay: 0.ms,
                      duration: 600.ms,
                      begin: 0,
                      end: 1,
                    ),
                    MoveEffect(
                      curve: Curves.easeInOut,
                      delay: 0.ms,
                      duration: 600.ms,
                      begin: const Offset(-0.0, 64),
                      end: const Offset(0, 0),
                    ),
                    ScaleEffect(
                      curve: Curves.easeInOut,
                      delay: 0.ms,
                      duration: 600.ms,
                      begin: const Offset(1, 0),
                      end: const Offset(1, 1),
                    ),
                  ],
                ),
              ),

              /// Register Button
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                child: FloatingActionButton.extended(
                  heroTag: "heritage1",
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => RegisterWidget(doctor: doctor))),
                  label: Text("Register",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: GoogleFonts.outfit().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  isExtended: true,
                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 3,
                  backgroundColor: const Color(0xFF42BEA5),
                  extendedPadding: const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 70),
                  foregroundColor: const Color(0xFF42BEA5),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                ).animate(
                  autoPlay: true,
                  effects: [
                    FadeEffect(
                      curve: Curves.easeInOut,
                      delay: 250.ms,
                      duration: 600.ms,
                      begin: 0,
                      end: 1,
                    ),
                    MoveEffect(
                      curve: Curves.easeInOut,
                      delay: 250.ms,
                      duration: 600.ms,
                      begin: const Offset(0, 64),
                      end: const Offset(0, 0),
                    ),
                    ScaleEffect(
                      curve: Curves.easeInOut,
                      delay: 250.ms,
                      duration: 600.ms,
                      begin: const Offset(1, 0),
                      end: const Offset(1, 1),
                    ),
                  ],
                ),
              ),

              /// Login Button
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: FloatingActionButton.extended(
                  heroTag: "heritage2",
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginWidget(doctor: doctor),
                      )),
                  label: Text("Login",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: GoogleFonts.outfit().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF42BEA5))),
                  isExtended: true,
                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 3,
                  backgroundColor: Colors.white,
                  extendedPadding: const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 80),
                ).animate(
                  autoPlay: true,
                  effects: [
                    FadeEffect(
                      curve: Curves.easeInOut,
                      delay: 420.ms,
                      duration: 600.ms,
                      begin: 0,
                      end: 1,
                    ),
                    MoveEffect(
                      curve: Curves.easeInOut,
                      delay: 420.ms,
                      duration: 600.ms,
                      begin: const Offset(0, 74),
                      end: const Offset(0, 0),
                    ),
                    ScaleEffect(
                      curve: Curves.easeInOut,
                      delay: 420.ms,
                      duration: 600.ms,
                      begin: const Offset(1, 0),
                      end: const Offset(1, 1),
                    ),
                  ],
                ),
              ),

              /// Doctor Checkbox
              SizedBox(
                height: 50,
                width: 200,
                child: CheckboxListTile(
                  fillColor: MaterialStateProperty.all(Colors.white),
                  checkColor: Colors.black,
                  //tileColor: Colors.white,
                  selectedTileColor: Colors.white,
                  activeColor: Colors.white,
                  hoverColor: Colors.white,
                  title: const Text("I'm a Doctor", style: TextStyle(color: Colors.white)),
                  value: doctor,
                  onChanged: (newValue) {
                    setState(() {
                      doctor = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ).animate(
                autoPlay: true,
                effects: [
                  FadeEffect(
                    curve: Curves.easeInOut,
                    delay: 420.ms,
                    duration: 600.ms,
                    begin: 0,
                    end: 1,
                  ),
                  MoveEffect(
                    curve: Curves.easeInOut,
                    delay: 420.ms,
                    duration: 600.ms,
                    begin: const Offset(0, 74),
                    end: const Offset(0, 0),
                  ),
                  ScaleEffect(
                    curve: Curves.easeInOut,
                    delay: 420.ms,
                    duration: 600.ms,
                    begin: const Offset(1, 0),
                    end: const Offset(1, 1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
