import 'package:cancer_project/Auth/Login.dart';
import 'package:cancer_project/All%20Functions%20Page/Functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../All Functions Page/FirebaseFunction.dart';

class RegisterWidget extends StatefulWidget {
  final bool doctor;
  const RegisterWidget({Key? key, required this.doctor}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  bool passwordVisibility1 = false;
  bool passwordVisibility2 = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF42BEA5),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              /// Image - Hope
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 200,
                decoration: BoxDecoration(
                    color: const Color(0xFF42BEA5),
                    image: DecorationImage(fit: BoxFit.cover, image: Image.asset('Assets/black1.png').image)),
                child: const Image(image: AssetImage('Assets/Hope.png')),
              ),

              /// Form
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 36),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: TextFormField(
                          controller: fullNameController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            hintText: 'Enter your name here...',
                            floatingLabelStyle: const TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF359F8A),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFE21C3D),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFE21C3D),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF359F8A),
                          ),
                          style: TextStyle(color: Colors.black, fontFamily: GoogleFonts.outfit().fontFamily),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == '') {
                              return "Insert your name";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: TextFormField(
                          controller: emailTextController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            hintText: 'Enter your email here...',
                            floatingLabelStyle: const TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF359F8A),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFE21C3D),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFE21C3D),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF359F8A),
                          ),
                          style: TextStyle(color: Colors.black, fontFamily: GoogleFonts.outfit().fontFamily),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.contains('@gmail.com')) {
                              return null;
                            }
                            return 'Please enter a valid Gmail!';
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: TextFormField(
                          controller: passwordTextController,
                          obscureText: !passwordVisibility1,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password here...',
                            floatingLabelStyle: const TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF359F8A),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF359F8A),
                            suffixIcon: InkWell(
                              onTap: () => setState(
                                () => passwordVisibility1 = !passwordVisibility1,
                              ),
                              focusNode: FocusNode(skipTraversal: true),
                              child: Icon(
                                passwordVisibility1 ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                color: const Color(0x80FFFFFF),
                                size: 22,
                              ),
                            ),
                          ),
                          style: TextStyle(color: Colors.black, fontFamily: GoogleFonts.outfit().fontFamily),
                          validator: (input) {
                            if (input!.length < 6) {
                              return 'Your password needs to be at least 6 character';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: TextFormField(
                          controller: confirmPasswordTextController,
                          obscureText: !passwordVisibility2,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: 'Confirm password here...',
                            floatingLabelStyle: const TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF359F8A),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF359F8A),
                            suffixIcon: InkWell(
                              onTap: () => setState(
                                () => passwordVisibility2 = !passwordVisibility2,
                              ),
                              focusNode: FocusNode(skipTraversal: true),
                              child: Icon(
                                passwordVisibility2 ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                color: const Color(0x80FFFFFF),
                                size: 22,
                              ),
                            ),
                          ),
                          style: TextStyle(color: Colors.black, fontFamily: GoogleFonts.outfit().fontFamily),
                          validator: (input) {
                            if (input != passwordTextController.text) {
                              return 'Your password needs to be matched previous one!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Register Button
              if (isLoading) const Center(child: CircularProgressIndicator()),
              if (!isLoading)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      String _email = emailTextController.text.trim();
                      String _password = passwordTextController.text.trim();
                      String _name = fullNameController.text.trim();
                      if (_formKey.currentState!.validate()) {
                        setState(() => isLoading = true);
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(email: _email, password: _password);
                        } catch (e) {
                          snackBar(e.toString(), context);
                          setState(() => isLoading = false);
                        }
                        createUserDatabase(_email, _name, widget.doctor);
                        authentication(context);
                        setState(() => isLoading = false);
                      }
                    },
                    label: Text("Create Account",
                        style: TextStyle(
                            fontFamily: GoogleFonts.outfit().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    isExtended: true,
                    shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 3,
                    backgroundColor: Colors.black,
                    extendedPadding: const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 60),
                  ),
                ),

              /// Login Switch
              Padding(
                padding: const EdgeInsetsDirectional.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Already have an account? ', style: TextStyle(color: Colors.black)),
                        TextButton(
                            onPressed: () => nextPage(LoginWidget(doctor: widget.doctor), context),
                            child: Text('Login',
                                style: TextStyle(
                                    fontFamily: GoogleFonts.outfit().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))),
                      ],
                    ),
                    const SizedBox(height: 50)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
