import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:form_field_validator/form_field_validator.dart';

import 'HomeScreen.dart';

enum MobilVerificationState { SHOW_PHONE_STATE, SHOW_OTP_STATE }

class Login extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();

  final currentState = MobilVerificationState.SHOW_PHONE_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  getLogin(context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 200, left: 20, right: 20),
                child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink,
                          offset: Offset(-10, -20),
                          blurRadius: 20,
                        )
                      ],
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                    ),
                    child: Form(
                      key: this._formkey,
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          // TEXT FIELD FOR PHONE NO
                          TextFormField(
                              controller: phoneController,
                              validator: MultiValidator([
                                MinLengthValidator(10,
                                    errorText: "should be 10 digits.")
                              ]),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: "Enter phone number")),
                          SizedBox(height: 30),
                          ElevatedButton(
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                   await _auth.verifyPhoneNumber(
                                      phoneNumber: phoneController.text,
                                       verificationCompleted: verificationCompleted,
                                       verificationFailed: verificationFailed, codeSent: codeSent,
                                       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
                                }
                              },
                              child: Text("Verify"))
                        ],
                      ),
                    )))));
  }

  getOtp(context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 200, left: 20, right: 20),
                child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink,
                          offset: Offset(-10, -20),
                          blurRadius: 30,
                        )
                      ],
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                    ),
                    child: Form(
                      key: this._formkey,
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          // TEXT FIELD FOR PHONE NO
                          TextFormField(
                              controller: otpController,
                              // validator: MultiValidator([
                              //   MinLengthValidator(10,
                              //       errorText: "should be 10 digits.")
                              // ]),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: "Enter OTP")),
                          SizedBox(height: 30),
                          ElevatedButton(
                              onPressed: () {}, child: Text("Verify"))
                        ],
                      ),
                    )))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentState == MobilVerificationState.SHOW_PHONE_STATE
          ? getLogin(context)
          : getOtp(context),
    );
  }
}
